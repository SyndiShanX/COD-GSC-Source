/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_4f91372b79c514b7.gsc
*************************************************/

#using script_102d83a437e2b29f;
#using script_16ea79836916888c;
#using script_19b3e06c555316d7;
#using script_1e172edbfbe283b6;
#using script_1e86a7270eee1c17;
#using script_1f26e1f43fae865c;
#using script_21195abcdee569da;
#using script_2386704e3c08f8ca;
#using script_24411f7b18415b53;
#using script_2b9373071eab7afc;
#using script_2e301dbc588668b1;
#using script_3a8f9ace195c9da9;
#using script_3ae866a6dd08daf9;
#using script_3bb187756499e26e;
#using script_3c5077a8847a5d9e;
#using script_3d2931807002dffe;
#using script_46b342a079938c68;
#using script_48324b060b129b7b;
#using script_4f91372b79c514b7;
#using script_58654341593183ce;
#using script_681b3034f1bd25ee;
#using script_7e7eaa110dbb1c83;
#using script_f603f40349f99c8;
#using scripts\aitypes\riotshield\riotshield;
#using scripts\anim\dialogue;
#using scripts\anim\shared;
#using scripts\common\ai;
#using scripts\common\anim;
#using scripts\common\scene;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle_paths;
#using scripts\cp\coop_stealth;
#using scripts\cp\cp_checkpoint;
#using scripts\cp\cp_claymore;
#using scripts\cp\cp_compass;
#using scripts\cp\cp_create_script_utility;
#using scripts\cp\cp_infilexfil;
#using scripts\cp\cp_interaction;
#using scripts\cp\cp_objectives;
#using scripts\cp\cp_outofbounds;
#using scripts\cp\cp_snakecam;
#using scripts\cp\cp_spawning_util;
#using scripts\cp\globallogic;
#using scripts\cp\laststand;
#using scripts\cp\movement;
#using scripts\cp\munitions;
#using scripts\cp\pickups;
#using scripts\cp\player\offhand_box;
#using scripts\cp\player_death;
#using scripts\cp\spawning;
#using scripts\cp\starts;
#using scripts\cp\utility;
#using scripts\cp\utility\connect_event_aggregator;
#using scripts\cp\utility\player;
#using scripts\cp\weapon;
#using scripts\cp_mp\armor;
#using scripts\cp_mp\equipment;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\vehicles\vehicle_anim;
#using scripts\engine\math;
#using scripts\engine\scriptable;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\stealth\utility;
#namespace cp_jup_apt;

function main() {
  if(getdvarint(@ "hash_e6afce2cf5cf7515", 0)) {
    return;
  }

  namespace_97aa0fe3dfa9c61a::main();
  namespace_720312f11945c211::main();
  namespace_b3a6633c5e80c3c2::main();
  thread namespace_a637649c8cd4ff68::main();
  thread namespace_78ef5a12a453ec66::main();
  scripts\cp\cp_outofbounds::function_4ff3dde013cb8715(15);

  if(level.createfx_enabled) {
    return;
  }

  level.var_aba7e24cef7c6d5 = &namespace_897c361e01268820::function_aba7e24cef7c6d5;

  if(!isDefined(level.valstruct)) {
    level.valstruct = spawnStruct();
  }

  scripts\cp\cp_checkpoint::function_4bfef22c47a65be5("obj_find_hostage_checkpoint");
  scripts\cp\cp_checkpoint::function_4bfef22c47a65be5("obj_secure_hostage_checkpoint");
  function_61411c49eaca86e2("gaz");
  precacheshader("icon_waypoint_enemy_marker");
  precachemodel("c_jup_carry_rig_skeleton_nolan");
  scripts\cp\utility\player::overridevisionsetnightforlevel("nvg_base_color_outline_jup");

  if(level.mapname == "cp_jup_apt") {
    level.var_61a54be8038f3a95 = 1;
    level.var_41957e049a51e8bc = "stealth_ai_music_bundle_cp_jup_apt";
    level.var_8e4a4897f3b80823 = 1;
    level.var_3b1ccf105481b5e6 = 1;
  }

  coop_mode_enable("sp_stealth");
  thread function_5624d33c91d90008();
  function_8484628d82e5353a();
  add_start("basement", &function_e1328f6ecc1b19e9, &function_7560e0d167fc9e3d, &basement_catchup);
  add_start("mid_level_1", &function_d6ff019279ea20e, &function_98cca25078a53c4e);
  add_start("mid_level_2", &function_d6fef19279e9fdb, &function_28c395c697bf915d);
  add_start("upper_level_1", &function_1b2176c7c876052c, &function_46c028137566c4b0);
  add_start("upper_level_2", &function_1b2179c7c8760bc5, &function_89da309601320b5b);
  add_start("roof", &function_14b08933e9f75a9a, &function_6eeb961d2a2bb2cc);
  add_start("capture", &function_c25a949b60b2276, &function_4c4b6a361a9f1242);
  add_start("hvt_attach", &function_abf07e37c671cfa6, &function_d2739fda6774c074);
  add_start("defend", &start_defend, &function_70e338121570fa62);
  add_start("exfil", &function_b0f6d6910f3b8af8, &function_cce1ca1325cccbe4);
  function_bb3e0c926b0667c4("basement,mid_level_1,mid_level_2,upper_level_1,upper_level_2,roof,hvt_attach,defend,exfil,");
  thread function_ac2e42c678489275();
  function_cdfd74e95368bd63(8000);
  level.valstruct val::set("level", "stealth_ttlt_lkp", 16000);
  level.valstruct val::set("level", "stealth_ttlt_not_lkp", 8000);
  function_d525f1534752bfc7();
  function_2cfef434ce6a1c44();
  function_279964c2c969dda3();
  function_3861eb0a004e0d38();
  function_c4d555bf9485ac3b();
  function_40214e8c06d5b6f4();
  function_704b4bf73954cd43();
  function_547fcc516e322c01();
  thread function_dbf5702adc534bc3();
  thread function_244cc115103485fb();
  thread function_2fec7e4049183fe0();
  thread function_18b3aed9ff371aac();

  thread function_22da0a58fb83564e();
  thread function_60f826ea764aefb2();
}

function function_8484628d82e5353a() {
  triggers = getEntArray("trigger_multiple_set_minimap_floor", "classname");
  array_delete(triggers);
}

function function_17b1976d7ff3c657() {
  result = scripts\cp\cp_checkpoint::function_cd10e09e02e4eb07("obj_find_hostage_checkpoint") || function_23abb4950e65038d();

  if(!istrue(result)) {
    ddl_checkpoint = namespace_1170726b2799ea65::function_50f02a42c72031cb(level.mapname);

    if(isDefined(ddl_checkpoint) && ddl_checkpoint == "obj_find_hostage_checkpoint") {
      return 1;
    }
  }

  return result;
}

function function_23abb4950e65038d() {
  result = scripts\cp\cp_checkpoint::function_cd10e09e02e4eb07("obj_secure_hostage_checkpoint");

  if(!istrue(result)) {
    ddl_checkpoint = namespace_1170726b2799ea65::function_50f02a42c72031cb(level.mapname);

    if(isDefined(ddl_checkpoint) && ddl_checkpoint == "obj_secure_hostage_checkpoint") {
      return 1;
    }
  }

  return result;
}

function function_22da0a58fb83564e() {
  dvar = @ "hash_dc36f6c740afa45";
  var_bc32c908e72bc7f7 = @ "hash_ed0f3a608051612b";
  setDvar(dvar, 0);
  setDvar(var_bc32c908e72bc7f7, -1);

  while(true) {
    if(getdvarint(dvar) > 0) {
      origin = level.player.origin;
      angles = level.player.angles;
      axis = getaiarray("<dev string:x1c>");
      axis = sortbydistance(axis, level.player.origin);
      attacker = axis[0];
      stance = scripts\cp\player_death::get_stance();

      if(getdvarint(var_bc32c908e72bc7f7) > -1) {
        deathscene = level.player.death.deaths[getdvarint(var_bc32c908e72bc7f7)];
      } else {
        deathscene = scripts\cp\player_death::get_animated_player_death(stance, 0, "<dev string:x21>", undefined, attacker);
      }

      if(isDefined(deathscene)) {
        println("<dev string:x2f>" + deathscene.type + "<dev string:x3d>" + deathscene.stance + "<dev string:x3d>" + deathscene.gesture);
      } else {
        println("<dev string:x40>");
      }

      level.player thread scripts\cp\player_death::setdeathangles(attacker, stance, deathscene);

      if(isDefined(deathscene)) {
        thread scripts\cp\player_death::gesture_death_anim(deathscene);
      } else {
        thread scripts\cp\player_death::non_gesture_death_anim();
      }

      wait 3;
      parent = level.player getlinkedparent();
      parent.origin = origin;
      parent.angles = angles;
      wait 0.1;
      level.player unlink();
      parent delete();
      level.player allowstand(1);
      level.player allowprone(1);
      level.player allowcrouch(1);
      level.player enableweaponswitch();
      level.player enableoffhandsecondaryweapons();
      level.player allowoffhandshieldweapons(1);
      level.player enableoffhandweapons();
      level.player allowjump(1);
      level.player allowfire(1);
      level.player freezecontrols(0);
      setDvar(dvar, 0);
    }

    wait 0.1;
  }
}

function function_60f826ea764aefb2() {
  dvar = @ "hash_b156572a589ed4a0";
  setDvar(dvar, 0);

  while(true) {
    if(getdvarint(dvar) > 0) {
      origin = level.player.origin;
      angles = level.player.angles;
      playerangles = level.player getplayerangles();
      parent = level.player spawn_tag_origin();
      parent.angles = playerangles;
      level.player thread function_37d2eb5e8e6d89a8();
      parent thread function_37d2eb5e8e6d89a8();
      iprintlnbold("<dev string:x5a>");
      iprintlnbold("<dev string:x61>");
      parent rotateTo(parent.angles + (0, 180, 0), 1);
      parent moveTo(parent.origin, 1);
      wait 5;
      level.player unlink();
      parent delete();
      setDvar(dvar, 0);
    }

    wait 0.1;
  }
}

function function_37d2eb5e8e6d89a8() {
  index = 1;

  if(self == level.player) {
    index = 0;
  }

  if(!isDefined(level.var_2bc34f2110eb313f)) {
    level.var_2bc34f2110eb313f = [];
  }

  if(!isDefined(level.var_2bc34f2110eb313f[index])) {
    struct = spawnStruct();
    struct.x = 250;
    struct.y = 425 + index * 25;
    struct.scale = 2;
    level.var_2bc34f2110eb313f[index] = struct;
  } else {
    struct = level.var_2bc34f2110eb313f[index];
  }

  if(index == 0) {
    prefix = "<dev string:x68>";
  } else {
    prefix = "<dev string:x71>";
  }

  level notify("<dev string:x7a>" + index);
  level endon("<dev string:x7a>" + index);
  self endon("<dev string:x8d>");

  while(true) {
    printtoscreen2d(struct.x, struct.y, prefix + self.origin, (1, 1, 1), struct.scale);
    waitframe();
  }
}

function function_547fcc516e322c01() {
  keys = getarraykeys(level.struct_class_names);

  foreach(key in keys) {
    if(!isDefined(level.struct_class_names[key])) {
      continue;
    }

    values = getarraykeys(level.struct_class_names[key]);

    foreach(value in values) {
      foreach(temp in level.struct_class_names[key][value]) {
        if(isarray(temp)) {
          array = temp;
        } else {
          array = [temp];
        }

        foreach(struct in array) {
          if(isDefined(struct.interaction)) {
            struct.interaction = undefined;
          }

          if(isDefined(struct.script_idle)) {
            struct.script_idle = undefined;
          }
        }
      }
    }
  }
}

function function_93c9db69c193a5ce() {
  wait 2;
  start = (2574, 2833, 1870);
  end = start + (0, 0, -100);
  weapobj = makeweapon("iw9_pi_papa220_mp");

  while(true) {
    wait 0.2;
    magicbullet(weapobj, start, end, level.player);
  }
}

function function_40214e8c06d5b6f4() {
  function_318fc8ecd4d8e798("axis", &postspawn_axis);
}

function function_704b4bf73954cd43() {
  spawners = getStructArray("mid_2_group", "targetname");
  spawners = array_combine(getStructArray("mid_2b_group", "targetname"), spawners);
  function_6933179df6aa483e(spawners, &function_99640619c3f06481);
}

function function_5624d33c91d90008() {
  flag_wait("scriptables_ready");
  flag_wait("player_spawned_with_loadout");
  setDvar(@ "hash_d3ee5a6578fe61de", 0);

  if(!isDefined(level.var_ac43b292d2289d28)) {
    level.var_ac43b292d2289d28 = [];
  }

  var_e9b874ecb4468294 = getscriptablearray("hq_screen2", "targetname");
  var_472bca9077115312 = getscriptablearray("hq_screen3", "targetname");
  var_472bcb9077115545 = getscriptablearray("hq_screen4", "targetname");
  var_472bc490771145e0 = getscriptablearray("hq_screen5", "targetname");
  assert(isDefined(var_e9b874ecb4468294));
  array_thread(var_e9b874ecb4468294, &function_da385467a8a1fa12, "hq_screen2");
  assert(isDefined(var_472bca9077115312));
  array_thread(var_472bca9077115312, &function_da385467a8a1fa12, "hq_screen3");
  assert(isDefined(var_472bcb9077115545));
  array_thread(var_472bcb9077115545, &function_da385467a8a1fa12, "hq_screen4");
  assert(isDefined(var_472bc490771145e0));
  array_thread(var_472bc490771145e0, &function_da385467a8a1fa12, "hq_screen5");
  playcinematicforalllooping("jup_cp_apts_multicam_cctv");
}

function function_da385467a8a1fa12(key) {
  if(!isDefined(level.var_ac43b292d2289d28[key])) {
    level.var_ac43b292d2289d28[key] = 1;
  }

  self setscriptablepartstate("screen", "bink" + level.var_ac43b292d2289d28[key]);
  level.var_ac43b292d2289d28[key]++;

  if(level.var_ac43b292d2289d28[key] == 4) {
    level.var_ac43b292d2289d28[key] = 1;
  }

  thread function_5ff2727f50caf47d();
}

function function_5ff2727f50caf47d() {
  waittill_either("death", "damage");
}

function function_eff5827f68a0f911() {
  triggers = function_f159c10d5cf8f0b4("test_only", "targetname");
  array_thread(triggers, &function_7df51efc05b03cae);
}

function function_7df51efc05b03cae() {
  while(true) {
    self waittill("trigger", other);

    if(self.spawnflags & 1) {
      if(isai(other)) {
        print3d(other.origin, "<dev string:x93>");
      } else {
        print3d(other.origin, "<dev string:xa6>");
      }

      continue;
    }

    if(self.spawnflags & 8) {
      if(isPlayer(other)) {
        print3d(other.origin, "<dev string:x93>");

        continue;
      }

      print3d(other.origin, "<dev string:xa6>");
    }
  }
}

function function_2cfef434ce6a1c44() {
  scripts\cp\utility\connect_event_aggregator::registeronconnectcallback(&onplayerconnect);
  level.custom_onspawnplayer_func = &onplayerspawned;
}

function onplayerconnect(player) {}

function onplayerspawned() {}

function function_279964c2c969dda3() {}

function function_3861eb0a004e0d38() {
  level.objectivesfunc = &function_c2a86f682bf1ab71;
  level thread scripts\cp\cp_objectives::objectives_init();
}

function function_c4d555bf9485ac3b() {
  level.var_5966c39cb60075f1 = &function_da58f5fca036ffaa;
  setup_create_script();
  namespace_84c374d417dc82cf::load_laser_fx();
  namespace_84c374d417dc82cf::initsentrysettings();
  thread scripts\cp\cp_snakecam::enable_snake_cams();
  level thread init_laser_traps();
  level thread function_fc4803dc319a81d2();
  scripts\cp\cp_compass::setupminimap("compass_map_cp_jup_apt");
  namespace_515a97f7d4a4053d::function_b04f37f19c6631e0();
  level thread scripts\cp\cp_objectives::run_debug_start_objective();

  level.devgui_setup_func = &function_d8fb18a58a875db6;
  level thread setup_map_specific_devgui();

  flag_wait("create_script_initialized");
  function_c65f472f4630bff7();
  thread function_22c99e7fc51c0233();
  thread function_a86d1d13a41da5b4();
  level.var_e58efb25be1ee016 = 1;
  function_e00cc8c1c5cc38fb(1);
  level.valstruct val::set("level", "ai_eventlist", "jup_apt_aieventlist");
  setDvar(@ "hash_7dcc2628da4d8ee9", 0);
  setDvar(@ "hash_82bf2761cf29c9bf", 200);
  setDvar(@ "hash_98fb6f768c79d031", 400);
}

function init_laser_traps() {
  flag_wait("strike_init_done");
  flag_wait("player_spawned_with_loadout");
  flag_wait("start_mission_flow");
  var_8bdd1937dc080cca = getStructArray("laser_sentry_defuse", "script_noteworthy");
  level.laser_traps = var_8bdd1937dc080cca;

  foreach(struct in var_8bdd1937dc080cca) {
    struct.laser_trap = 1;
  }

  setDvar(@ "hash_7693c920bebdb71b", 0);
  namespace_84c374d417dc82cf::function_4855a66011f5974b(var_8bdd1937dc080cca);

  foreach(struct in var_8bdd1937dc080cca) {
    struct.hint_obj sethintonobstruction("hide");
  }
}

function function_dbf5702adc534bc3() {
  flag_wait("scriptables_ready");
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("brloot_nvg", &function_cf7ffb319bd12081);
  structs = getStructArray("nvg_helmet_prop", "targetname");

  foreach(struct in structs) {
    model = spawn("script_model", struct.origin);
    model.angles = struct.angles;
    model setModel("parts_jup_helmet_gravesshadow_helmet");
  }
}

function function_cf7ffb319bd12081(instance, part, state, player, var_a5b2c541413aa895, usestring) {
  thread function_fed2464824100bb1();
}

function function_244cc115103485fb() {
  flag_wait("scriptables_ready");
  flag_wait("dungeon_load_finished");
  waitframe();
  structs = getStructArray("opened_crate", "targetname");
  ascenders = getentitylessscriptablearray("cp_ascender_device");
  level.var_faa3696161505b00 = [];

  if(function_1f067aa9b7648939()) {
    return;
  }

  scripts\engine\scriptable::scriptable_addusedcallbackbypart("cp_ascender_device", &function_5c05828479ddbfcc);

  foreach(struct in structs) {
    crate = spawnscriptable("cp_blueprint_crate_dungeons", struct.origin, struct.angles);
    crate setscriptablepartstate("cp_blueprint_crate_dungeons", "fully_open_unusable");
    crate.var_be6b0f71bd991349 = 1;
    level.var_faa3696161505b00[level.var_faa3696161505b00.size] = crate;

    foreach(ascender in ascenders) {
      if(distancesquared(ascender.origin, crate.origin) < 10000) {
        crate.item = ascender;
        ascender.crate = crate;
        break;
      }
    }

    if(!isDefined(crate.item)) {
      continue;
    }

    level thread function_7a8c7a34460ea8bc(crate);
  }
}

function function_7a8c7a34460ea8bc(crate) {
  alias = "jup_loot_weapon_case_lp";
  tempent = spawn_script_origin(crate.origin);
  tempent playLoopSound(alias);
  crate function_519c7d34744de750();
  tempent stoploopsound(alias);
  tempent delete();
  function_d67fe027e8f97a8c(crate);
}

function private function_5c05828479ddbfcc(instance, part, state, player, var_a5b2c541413aa895, usestring) {
  instance notify("trigger");
}

function function_519c7d34744de750() {
  self endon("delete");
  self.item waittill("trigger");
}

function function_d67fe027e8f97a8c(var_ef1113f4c33b8021) {
  foreach(crate in level.var_faa3696161505b00) {
    if(crate != var_ef1113f4c33b8021) {
      crate freescriptable();
    }
  }
}

function setup_create_script() {
  scripts\cp\cp_create_script_utility::init_create_script_for_level();
  scripts\cp\cp_create_script_utility::register_create_script_arrays("cp_jup_apt_create_script", "cp_jup_apt_create_script", level.scripted_spawner_func.size, &namespace_6c43cd85b544ed7a::main);
}

function function_fc4803dc319a81d2() {
  level thread wait_for_pre_game_period();
  level thread wait_for_strike_init_complete();
  level thread function_971bf83fc35c7d8d();
  level thread function_76475ab344bd0cf3();
  level thread function_c0926f2d29510c1c();
}

function function_c0926f2d29510c1c() {
  flag_wait_all("level_ready_for_script", "objective_table_parsed", "start_mission_flow");
  level thread obj_flow();
}

function wait_for_pre_game_period() {
  level endon("game_ended");

  while(!isDefined(level.player)) {
    waitframe();
  }

  level.player waittill("loadout_class_selected");
  flag_set("start_mission_flow");
  thread namespace_1170726b2799ea65::function_aa47047a0f7d56da(level.player, 0);
}

function wait_for_strike_init_complete() {
  level endon("game_ended");
  flag_wait("level_ready_for_script");
  flag_wait("strike_init_done");
  flag_wait("objective_table_parsed");
  flag_wait("objectives_registered");
  scripts\cp_mp\vehicles\vehicle_anim::init_vehicles();
  wait 1;
  function_a39653bdf143931c();
  function_900a3e3171bed15d();
  thread function_ffc7dd3a5adfd5cf();
  thread function_dfeab09e12eff7e4();
  thread function_144d34e93cc17d70();
  thread function_ae3962e2f6bdd31c();
  thread function_2c31d268382bedb0();
  thread function_14433cb67f515c28();
  level.var_83782d6266ec4fb4 = &namespace_78ef5a12a453ec66::function_6c22b1feac90c495;
  thread function_8e01c459332b0111();

  if(getdvarint(@ "hash_e4d6219ba6e9bf7", 0)) {
    thread function_bc9edf35561cd6a0();
  }
}

function function_14433cb67f515c28() {
  flag_wait("level_ready_for_script");
  flag_wait("obj_secure_hostage_completed");
  wait 1;

  if(scripts\cp\cp_outofbounds::isoobimmune(level.player)) {
    disableoobimmunity(level.player);
  }

  thread function_df9f714657dd8b84();
  thread function_16f0141f97fc6ac9();
}

function function_df9f714657dd8b84() {
  level endon("game_ended");
  level endon("attach_interact_used");

  while(!istrue(level.player.var_859654e0445a36d9) || level.player.origin[2] > 1750) {
    wait 0.2;
  }

  level.player scripts\cp\cp_outofbounds::function_ea269c0ec2ba23cd();
}

function function_16f0141f97fc6ac9() {
  thread function_13c6eedf4af54081();
  level endon("game_ended");
  level endon("attach_interact_used");
  childthread function_5e3cfb4ac00452ec();

  while(true) {
    while(!istrue(level.player.var_859654e0445a36d9)) {
      waitframe();
    }

    level.player skydive_setbasejumpingstatus(0);
    level.player skydive_setdeploymentstatus(0);
    scripts\cp\cp_outofbounds::function_4ff3dde013cb8715(0);
    childthread function_5e3cfb4ac00452ec();

    while(istrue(level.player.var_859654e0445a36d9)) {
      waitframe();
    }

    level.player skydive_setbasejumpingstatus(1);
    level.player skydive_setdeploymentstatus(1);
    scripts\cp\cp_outofbounds::function_4ff3dde013cb8715(15);
    level notify("enable_revive");
    level.player scripts\cp\laststand::enable_self_revive();
  }
}

function function_5e3cfb4ac00452ec() {
  level endon("enable_revive");

  while(true) {
    while(!isDefined(level.player.self_revive) || level.player.self_revive == 0) {
      wait 0.1;
    }

    level.player scripts\cp\laststand::disable_self_revive();

    while(level.player.self_revive > 0) {
      wait 0.1;
    }
  }
}

function function_13c6eedf4af54081() {
  level waittill("attach_interact_used");
  waitframe();
  level.player skydive_setbasejumpingstatus(1);
  level.player skydive_setdeploymentstatus(1);
  scripts\cp\cp_outofbounds::function_4ff3dde013cb8715(15);
  level.player scripts\cp\laststand::enable_self_revive();
}

function function_dfeab09e12eff7e4() {
  thread scripts\cp\player\offhand_box::offhand_box_setup();
}

function function_ac2e42c678489275() {
  flag_wait("start_is_set");
  start = level.start_point;

  if(!isDefined(start) || start == "") {
    return;
  }

  if(start == "basement") {
    return;
  }

  if(start == "mid_level_1") {
    return;
  }

  flag_set("flag_apt_mid_1_complete");
  flag_set("flag_apt_mid_1_drone_tutorial_complete");

  if(start == "mid_level_2") {
    return;
  }

  if(start == "upper_level_1") {
    return;
  }

  if(start == "upper_level_2") {
    return;
  }

  flag_set("apt_drone_callout_stop");

  if(start == "roof") {
    return;
  }

  flag_set("flag_dungeon_hostage_interact_enabled");
  flag_set("roof_entered");
  flag_set("obj_find_hostage_completed");
  flag_set("obj_secure_roof_completed");

  if(start == "capture") {
    return;
  }

  flag_set("obj_secure_hostage_completed");
  flag_set("obj_reach_exfil_completed");

  if(start == "hvt_attach") {
    return;
  }

  if(start == "defend") {
    return;
  }

  flag_set("obj_defend_completed");

  if(start == "exfil") {
    return;
  }
}

function function_a39653bdf143931c() {
  hiddenranges["prone"] = 720;
  hiddenranges["crouch"] = 900;
  hiddenranges["stand"] = 1400;
  spottedranges["prone"] = 1800;
  spottedranges["crouch"] = 2400;
  spottedranges["stand"] = 4200;
  scripts\stealth\utility::set_detect_ranges(hiddenranges, spottedranges);
  level.var_8ee9c5604a4fb6c0 = 2048;
}

function function_41991eceeb75a1e7() {
  hiddenranges["prone"] = 720;
  hiddenranges["crouch"] = 900;
  hiddenranges["stand"] = 1400;
  spottedranges["prone"] = 3500;
  spottedranges["crouch"] = 4000;
  spottedranges["stand"] = 4200;
  scripts\stealth\utility::set_detect_ranges(hiddenranges, spottedranges);
}

function function_c2a86f682bf1ab71() {
  level.objectives_table = "cp/cp_jup_apt_objectives.csv";
  level.objectivesmatrixtable = "cp/cp_jup_apt_objectives_matrix.csv";
  level.objectiveregistration = &function_77765e5dd4c9db54;
  parseobjectivestable(level.objectives_table);
}

function function_77765e5dd4c9db54() {
  level endon("game_ended");
  flag_wait("level_ready_for_script");
  flag_wait("objective_table_parsed");
  thread registerobjective("obj_find_hostage", &function_703ff164fb289895, &function_4f32af5f16439ac9);
  thread registerobjective("obj_secure_roof", &function_bb4fcab91ad09928, &function_99409ca3c1caa5fa);
  thread registerobjective("obj_secure_hostage", &function_1ec0d47f299d3be3, &function_63438d691999d5af);
  thread registerobjective("obj_reach_exfil", &function_a4caa3a236762c68, &function_21ca7ca557aed23a);
  thread registerobjective("obj_defend", &function_dfeaa3ce5658e8fa, &function_61f1f98dbc2d7494);
  thread registerobjective("obj_exfil", &function_e69aad71e3c914b4, &function_1b3155a6a06c0d5e);
  scripts\cp\cp_checkpoint::function_d37e0c86fbcf710b("obj_find_hostage", "obj_find_hostage_checkpoint", &function_32f82d430fbe6486);
  scripts\cp\cp_checkpoint::function_d37e0c86fbcf710b("obj_find_hostage", "obj_secure_hostage_checkpoint", &function_32f82d430fbe6486);
  scripts\cp\cp_checkpoint::function_d37e0c86fbcf710b("obj_secure_hostage", "obj_secure_hostage_checkpoint", &function_13e139c428df7cbc);

  if(!objective_isunlimited()) {
    namespace_9d6ed0911e2ddf09::reserve_objectiveid([1, 2, 3, 4, 5, 6, 7]);
  }
}

function function_70d68bcbef8eeb26() {
  level.default_player_spawns = "find_hostage_checkpoint_spawn";
  flag_wait("obj_secure_hostage_completed");
  level.default_player_spawns = "secure_hostage_checkpoint_spawn";
}

function function_703ff164fb289895(objectivestruct, var_5dcdfd3a4eff9961) {
  objpoint = getStruct("obj_find_hostage_struct", "targetname");
  objpoint thread namespace_9d6ed0911e2ddf09::function_dc3c295fcb6d7c77(1, "obj_find_hostage_completed", objpoint.radius, undefined, undefined, undefined, undefined, undefined, undefined, undefined, &"CP_JUP_APT/OBJ_LOCATE_HVT", 1);
  waittillframeend();
  obj_num = isDefined(objpoint.var_191d2524aa36a7e) ? objpoint.var_191d2524aa36a7e : 1;
  objective_state(obj_num, "active");
  function_9766d0b79eada249(obj_num, 1);
  objective_setshowoncompass(obj_num, 0, 1);
  flag_wait("move_price_to_roof");
  objective_state(obj_num, "current");
  function_9766d0b79eada249(obj_num, 0);
  objective_setshowoncompass(obj_num, 1, 1);
  flag_wait("obj_find_hostage_completed");
  waitframe();
  objpoint notify("obj_find_hostage_completed");
}

function function_bb4fcab91ad09928(objectivestruct, var_5dcdfd3a4eff9961) {
  objpoint = getStruct("obj_secure_roof_struct", "targetname");
  objpoint thread namespace_9d6ed0911e2ddf09::function_dc3c295fcb6d7c77(2, "obj_secure_roof_completed", objpoint.radius, undefined, undefined, undefined, undefined, undefined, undefined, undefined, &"CP_JUP_APT/OBJ_SECURE_ROOF", 1);
  waittillframeend();
  obj_num = isDefined(objpoint.var_191d2524aa36a7e) ? objpoint.var_191d2524aa36a7e : 2;
  objective_state(obj_num, "active");
  function_9766d0b79eada249(obj_num, 1);
  objective_setshowoncompass(obj_num, 0, 1);
  flag_wait_all("obj_secure_roof_completed", "can_start_hvt_convo");
  waitframe();
  objpoint notify("obj_secure_roof_completed");
}

function function_1ec0d47f299d3be3(objectivestruct, var_5dcdfd3a4eff9961) {
  var_2f8b2ff7e0389b27 = getStruct("obj_secure_hostage_struct", "targetname");
  radius = var_2f8b2ff7e0389b27.radius;

  while(!isDefined(level.var_a208d3c07dba8204)) {
    waitframe();
  }

  objpoint = spawnStruct();
  objpoint.origin = level.var_a208d3c07dba8204.origin;
  objpoint.angles = level.var_a208d3c07dba8204.angles;
  objpoint.script_noteworthy = var_2f8b2ff7e0389b27.script_noteworthy;
  objpoint.origin += (0, 0, 10);
  objpoint thread namespace_9d6ed0911e2ddf09::function_dc3c295fcb6d7c77(3, "obj_secure_hostage_completed", radius, undefined, undefined, undefined, undefined, undefined, undefined, undefined, &"CP_JUP_APT/OBJ_SECURE_HVT", 1);
  flag_wait("obj_secure_hostage_completed");
  waitframe();
  objpoint notify("obj_secure_hostage_completed");
}

function function_a4caa3a236762c68(objectivestruct, var_5dcdfd3a4eff9961) {
  objpoint = getStruct("obj_reach_exfil_struct", "targetname");
  objpoint thread namespace_9d6ed0911e2ddf09::function_dc3c295fcb6d7c77(4, "obj_reach_exfil_completed", objpoint.radius, undefined, undefined, undefined, undefined, undefined, undefined, undefined, &"CP_JUP_APT/OBJ_ATTACH_HVT", 1);
  flag_wait("obj_reach_exfil_completed");
  waitframe();
  objpoint notify("obj_reach_exfil_completed");
}

function function_dfeaa3ce5658e8fa(objectivestruct, var_5dcdfd3a4eff9961) {
  objpoint = getStruct("obj_defend_struct", "targetname");
  objpoint thread namespace_9d6ed0911e2ddf09::function_dc3c295fcb6d7c77(5, "obj_defend_completed", objpoint.radius, undefined, undefined, undefined, undefined, undefined, undefined, undefined, &"CP_JUP_APT/OBJ_DEFEND", 1);
  waitframe();
  flag_wait("obj_defend_completed");
  waitframe();
  objpoint notify("obj_defend_completed");
}

function function_e69aad71e3c914b4(objectivestruct, var_5dcdfd3a4eff9961) {
  objpoint = getStruct("obj_exfil_struct", "targetname");
  objpoint thread namespace_9d6ed0911e2ddf09::function_dc3c295fcb6d7c77(6, "obj_exfil_completed", objpoint.radius, undefined, undefined, undefined, undefined, undefined, undefined, undefined, &"CP_JUP_APT/OBJ_ATTACH_PLAYER", 1);
  flag_wait("obj_exfil_completed");
  waitframe();
  objpoint notify("obj_exfil_completed");
}

function function_4f32af5f16439ac9(objectivestruct, var_5dcdfd3a4eff9961) {}

function function_99409ca3c1caa5fa(objectivestruct, var_5dcdfd3a4eff9961) {}

function function_63438d691999d5af(objectivestruct, var_5dcdfd3a4eff9961) {}

function function_21ca7ca557aed23a(objectivestruct, var_5dcdfd3a4eff9961) {}

function function_61f1f98dbc2d7494(objectivestruct, var_5dcdfd3a4eff9961) {}

function function_1b3155a6a06c0d5e(objectivestruct, var_5dcdfd3a4eff9961) {}

function function_2c5083f90e63540c(objectivestruct, objpoint) {
  flag_wait("player_carrying_hvt");
  var_12ae5e9d791ddbe = spawn_tag_origin();
  var_12ae5e9d791ddbe.script_noteworthy = "obj_pick_up_hvt";
  var_12ae5e9d791ddbe.origin = level.hvt gettagorigin("j_elbow_ri");
  var_12ae5e9d791ddbe.origin += (0, 0, 10);
  var_12ae5e9d791ddbe.radius = 60;
  var_12ae5e9d791ddbe linkTo(level.hvt);
  thread function_31f5312b3580f4fc(objpoint, var_12ae5e9d791ddbe);
  level endon("obj_reach_exfil_completed");
  var_12ae5e9d791ddbe = undefined;

  while(true) {
    level.player waittill("hostage_dropped");
    flag_clear("obj_pick_up_hvt_completed");
    var_12ae5e9d791ddbe thread namespace_9d6ed0911e2ddf09::function_dc3c295fcb6d7c77(7, "obj_pick_up_hvt_completed", undefined, undefined, undefined, undefined, var_12ae5e9d791ddbe, undefined, undefined, 1, level.hvt, &"CP_JUP_APT/OBJ_ATTACH_HVT");
    level.player waittill("hostage_picked_up");
    flag_set("obj_pick_up_hvt_completed");
    var_12ae5e9d791ddbe notify("obj_pick_up_hvt_completed");
  }
}

function function_31f5312b3580f4fc(objpoint, var_12ae5e9d791ddbe) {
  flag_wait("obj_reach_exfil_completed");
  objpoint notify("obj_reach_exfil_completed");
  flag_set("obj_pick_up_hvt_completed");
  var_12ae5e9d791ddbe notify("obj_pick_up_hvt_completed");
}

function obj_flow() {
  objstruct = level.objectivestabledata["obj_find_hostage"];
  thread initializeobjective(objstruct, "obj_find_hostage", "primary");
  thread startobjective(objstruct, "obj_find_hostage", "primary");
  flag_wait("obj_find_hostage_completed");

  if(!level.player function_17b1976d7ff3c657()) {
    scripts\cp\cp_checkpoint::checkpoint_set("obj_find_hostage_checkpoint");
  } else {
    namespace_96731f4d002634f6::function_666769c607f16d10();
  }

  completeobjective(objstruct, "obj_find_hostage", "primary");
  waitframe();
  waitframe();
  objstruct = level.objectivestabledata["obj_secure_roof"];
  thread initializeobjective(objstruct, "obj_secure_roof", "primary");
  thread startobjective(objstruct, "obj_secure_roof", "primary");
  flag_wait_all("obj_secure_roof_completed", "can_start_hvt_convo");
  completeobjective(objstruct, "obj_secure_roof", "primary");
  waitframe();
  waitframe();
  objstruct = level.objectivestabledata["obj_secure_hostage"];
  thread initializeobjective(objstruct, "obj_secure_hostage", "primary");
  thread startobjective(objstruct, "obj_secure_hostage", "primary");
  flag_wait("obj_secure_hostage_completed");

  if(!level.player function_23abb4950e65038d()) {
    scripts\cp\cp_checkpoint::checkpoint_set("obj_secure_hostage_checkpoint");
  }

  completeobjective(objstruct, "obj_secure_hostage", "primary");
  waitframe();
  waitframe();
  objstruct = level.objectivestabledata["obj_reach_exfil"];
  thread initializeobjective(objstruct, "obj_reach_exfil", "primary");
  thread startobjective(objstruct, "obj_reach_exfil", "primary");
  flag_wait("obj_reach_exfil_completed");
  completeobjective(objstruct, "obj_reach_exfil", "primary");
  waitframe();
  waitframe();
  objstruct = level.objectivestabledata["obj_defend"];
  thread initializeobjective(objstruct, "obj_defend", "primary");
  thread startobjective(objstruct, "obj_defend", "primary");
  flag_wait("obj_defend_completed");
  completeobjective(objstruct, "obj_defend", "primary");
  waitframe();
  waitframe();
  objstruct = level.objectivestabledata["obj_exfil"];
  thread initializeobjective(objstruct, "obj_exfil", "primary");
  thread startobjective(objstruct, "obj_exfil", "primary");
  flag_wait("obj_exfil_started");
  completeobjective(objstruct, "obj_exfil", "primary");
  flag_set("obj_exfil_completed");
}

function function_c538eacacb527a0() {
  flag_set("flag_apt_mid_1_complete");
  flag_set("flag_apt_mid_complete");
  flag_set("flag_apt_basement_complete");
  flag_set("flag_apt_mid_complete");
  flag_set("flag_apt_upper_2_started");
  flag_set("flag_apt_upper_complete");
  flag_set("stop_price_callouts");
  flag_set("show_blimp");
  flag_set("ally_on_roof");
  level.player.ability_invulnerable = undefined;
  thread namespace_1170726b2799ea65::function_cece888a7dfbeb0b();
}

function function_32f82d430fbe6486() {
  objstruct = level.objectivestabledata["obj_find_hostage"];
  flag_set("obj_find_hostage_completed");
  objstruct scripts\cp_mp\utility\game_utility::function_af5604ce591768e1();
  objpoint = getStruct("obj_find_hostage_struct", "targetname");
  objpoint notify("obj_find_hostage_completed");

  if(level.player function_23abb4950e65038d()) {
    flag_set("obj_secure_roof_completed");
    flag_set("can_start_hvt_convo");
    flag_set("obj_secure_hostage_completed");
    return;
  }

  function_c538eacacb527a0();
  flag_set("ally_vo_reveal");
  flag_set("ally_can_rappel");
  flag_set("move_price_to_roof");
  flag_set("roof_spawn");
  flag_wait("start_mission_flow");
  thread function_4e257994365fa73f("roof_spawn", "roof_spawn_trig");
  function_15ac00c604af0413();
  level.ally thread function_9f2ada961e09fb18();
  thread namespace_1170726b2799ea65::function_4576aecf9d0c4082(level.ally);
  function_6eeb961d2a2bb2cc();
  function_4c4b6a361a9f1242();
  function_d2739fda6774c074();
  function_70e338121570fa62();
  function_cce1ca1325cccbe4();
}

function function_9368a8111e60213c() {
  if(!isDefined(game["start_time"])) {
    return false;
  }

  if(level.player function_17b1976d7ff3c657()) {
    return false;
  }

  currtime = gettime() / 1000;

  if(currtime <= game["start_time"] + 45) {
    return true;
  }

  return false;
}

function function_13e139c428df7cbc() {
  objstruct = level.objectivestabledata["obj_secure_hostage"];
  flag_set("obj_secure_hostage_completed");
  objstruct scripts\cp_mp\utility\game_utility::function_af5604ce591768e1();
  objpoint = getStruct("obj_secure_hostage_struct", "targetname");
  objpoint notify("obj_secure_hostage_completed");
  function_c538eacacb527a0();
  flag_set("player_on_stronghold_platform");
  flag_set("obj_find_hostage_completed");
  flag_set("obj_secure_roof_completed");
  flag_set("can_start_hvt_convo");
  flag_wait("start_mission_flow");
  function_15ac00c604af0413("ally_capture_loc");
  level.ally function_9f2ada961e09fb18();
  thread namespace_1170726b2799ea65::function_4576aecf9d0c4082(level.ally);
  function_3649512a462f8e82();
  level.hvt function_b87686065982f169();
  level.hvt.var_b3054dce8cc525f2 = 1;
  level.hvt.ignoreme = 1;
  level.hvt namespace_1170726b2799ea65::function_624150e2bc78e81f("Nolan");
  node = getnode("ally_node_after_capture", "targetname");
  level.ally forceteleport(node.origin, node.angles);
  level.ally thread ally_pickup_shield();
  node = getnode("node_hvt_surrender", "targetname");
  level.hvt forceteleport(node.origin, node.angles);
  waittillframeend();
  level.hvt anim_first_frame_solo(level.var_8b3e280380afbbd, "capture_end_idle");
  level.hvt anim_first_frame_solo(level.hvt, "capture_end_idle");
  level.hvt thread namespace_c9c644ec9ed13750::hostage_onuse(level.player, 1);
  flag_set("hvt_picked_up_first_time");
  flag_set("player_carrying_hvt");
  level.hvt[[level.setagentteam]]("allies");
  enemiesarray = [level.hvt];
  level notify("visibilityTeamName", "allies", enemiesarray, 1);
  level.player.var_859654e0445a36d9 = 1;
  thread function_4e257994365fa73f("move_helo_2_troops", "move_helo_2_troops");
  thread function_4e257994365fa73f("nearing_blimp_platform", "nearing_blimp_platform_trig");
  thread function_7771434df4ddcffb();
  level.var_a423e6fbd31e09cf = [];
  thread function_73af9109ffdaa2f();
  function_d2739fda6774c074();
  function_70e338121570fa62();
  function_cce1ca1325cccbe4();
}

function function_d525f1534752bfc7() {
  setDvar(@ "hash_acd3891a0644e00", 1);
  setDvar(@ "hash_7c74d4814e0665d5", 3);
  setDvar(@ "sm_sunsamplesizenear", 1.25);
  setDvar(@ "hash_7686fcb92ccc5edb", 4);
  setDvar(@ "r_umbraaccurateocclusionthreshold", 2048);
  setDvar(@ "hash_1dde331a8e0153d8", 8);
  setDvar(@ "hash_63eb1893f96ac98d", 8);
  setDvar(@ "hash_1e36075e6b8ced83", 0);
  setdvarifuninitialized(@ "hash_2d59deb63c029ea8", 0);
  setDvar(@ "hash_a05f41e7fcf7184", 3);
  scripts\cp\utility::function_c72ff775cd61b11(@ "hash_b0c7dac3423c11d2", 200, 1000);
  level.var_318ceae290567709 = scripts\engine\trace::create_contents(0, 1, 0, 0, 0, 0, 0, 1, 0);
  flag_set("infil_complete");
}

function function_76475ab344bd0cf3() {
  level thread function_dafb3a3f4a103ccd();
  function_30160e0f4ccb9aaf();
  function_e47c20d9c3bc83ac();
}

function function_dafb3a3f4a103ccd() {
  flag_wait("player_spawned_with_loadout");
  level.var_c91a0e8fe84fb300 = &scripts\cp\cp_claymore::function_e2b6464932ab9b06;
  claymores = scripts\cp\cp_claymore::spawn_claymore_group("claymore");
}

function setup_map_specific_devgui() {}

function function_d8fb18a58a875db6(player) {
  playername = player.name;
  playernum = undefined;

  for(i = 0; i < level.players.size; i++) {
    if(level.players[i] == player) {
      player thread function_cab08c75e0639ea0(player, playername, i);
      break;
    }
  }
}

function function_cab08c75e0639ea0(player, name, num) {}

function function_bc9edf35561cd6a0() {
  while(!isDefined(level.player)) {
    waitframe();
  }

  wait 0.5;
  level.player endon("<dev string:xae>");
  level.player endon("<dev string:xc2>");
  level.player.var_7269deeba689cd65 = 1;
  level.player takeallweapons(1);
  objweapon = scripts\cp\weapon::function_768c9a047aed19f4("<dev string:xcd>");
  objweapon = objweapon scripts\cp\weapon::function_dcb52bcbbcb80b00(["<dev string:xdd>", "<dev string:xe3>"]);
  level.player giveweapon(objweapon);
  var_98428d423d8da0d8 = scripts\cp\weapon::function_768c9a047aed19f4("<dev string:xec>");
  level.player.last_stand_pistol = var_98428d423d8da0d8;
  level.player giveweapon(var_98428d423d8da0d8);
  scripts\cp\pickups::giveammo(level.player);
  level.player scripts\cp_mp\equipment::clearallequipment();
  level.player scripts\cp_mp\equipment::giveequipment("<dev string:xfd>", "<dev string:x108>");
  level.player scripts\cp_mp\equipment::giveequipment("<dev string:x110>", "<dev string:x11c>");
  level.player scripts\cp_mp\equipment::function_91bd2a98062313cb("<dev string:x108>", 4);
  level.player scripts\cp_mp\equipment::function_91bd2a98062313cb("<dev string:x11c>", 4);
  waitframe();
  level.player switchtoweapon(objweapon);
}

function function_da58f5fca036ffaa() {
  self visionsetthermalforplayer("flir_2_color_gradient");
  scripts\cp\munitions::check_for_empty_munitions();
  scripts\cp\munitions::assign_highest_full_slot_to_active();
  self.munition_splash_supress = undefined;
  self.var_7269deeba689cd65 = 1;
  self.var_a8440da4d5f5a9ad = 1;
  scripts\cp\utility::giveperk("specialty_hack");
}

function function_c4869b83b43e420f(group_name, func) {
  if(getdvarint(@ "hash_dcf5fcede3345fb8", 0) != 0 || getdvarint(@ "hash_d8d47ba9a7e3f94c", 0) != 0) {
    self.ignoreall = 1;
  }

  if(istrue(self.bhasriotshieldattached)) {
    self.var_2626d6897d71b728 = 1400;
    self function_9f82c74eb1b7caf9(0);
    self.allowstrafe = 1;
  }

  scripts\cp\coop_stealth::run_common_functions(self, 1, 1, 60, 160000);
  self.var_a4709d00b598b7bf = 1;
  self.maystumble = 0;
  self.shouldstumble = 0;
  thread function_80dc965028d873a2();
  thread function_82cdd0ff660ce304();
  thread function_6b057f33caf799af();
  thread function_b77fa6d696666245();

  if(flag("stealth_spotted")) {
    if(self[[self.fnisinstealthcombat]]() || self[[self.fnisinstealthhunt]]()) {
      return;
    }

    self getenemyinfo(level.player);
    return;
  }

  if(flag("broke_stealth_earlier")) {
    if(self[[self.fnisinstealthcombat]]() || self[[self.fnisinstealthhunt]]()) {
      return;
    }

    self[[self.fnsetstealthstate]]("hunt");
    self aieventlistenerevent("damage", self, self.origin);
  }
}

function function_16e5f29b3aebbc0f(group_name, func) {
  if(getdvarint(@ "hash_dcf5fcede3345fb8", 0) != 0 || getdvarint(@ "hash_d8d47ba9a7e3f94c", 0) != 0) {
    self.ignoreall = 1;
  }

  scripts\cp\coop_stealth::run_common_functions(self, 1, 1, 60, 160000);
  self.var_a4709d00b598b7bf = 1;
  self.maystumble = 0;
  self.shouldstumble = 0;
  self.var_5323a94889eff1de = 1;
  thread function_80dc965028d873a2();
  thread function_82cdd0ff660ce304();
  thread function_6b057f33caf799af();
  self.stealth.funcs["event_investigate"] = &function_f161c068112045e3;
  self.stealth.funcs["event_cover_blown"] = &function_f161c068112045e3;
  self.stealth.funcs["event_combat"] = &function_f161c068112045e3;
  self.stealth.funcs["should_hunt"] = &function_23cc696ddb16ab42;
  self[[self.fnsetstealthstate]]("hunt");
}

function function_38ba7b842978ba92(group_name, func) {
  self endon("death");

  if(getdvarint(@ "hash_dcf5fcede3345fb8", 0) != 0) {
    self.ignoreall = 1;
  }

  self.var_5323a94889eff1de = 1;
  self.goalradius = 100;
  function_41916c7ce22f8f8b(0);
  thread function_6b057f33caf799af();

  if(isDefined(self.heli)) {
    self.heli waittill("unloaded");
  }

  if(isDefined(self.target)) {
    goal_struct = getStruct(self.target, "targetname");
    thread scripts\cp\spawning::enter_combat_after_go_to_node(goal_struct);
    waittill_any_return_2("reached_path_end", "stop_going_to_node");
    wait randomfloatrange(10, 30);
  }

  goal_vol = function_1c4d592029f2b0d3(self.script_squadname);
  self setgoalvolumeauto(goal_vol);
  self getenemyinfo(level.player);
}

function function_3e28d41bce5691de(group_name, func) {
  self.ignoreall = 1;
  function_41916c7ce22f8f8b(0);
  self.baseaccuracy = 0.2;
  thread function_c4869b83b43e420f();
}

function function_1b0bc59f8ef3ad5b() {
  self.ignoreall = 1;
  flag_wait("flag_apt_mid_complete");
  self.ignoreall = 0;
  function_c4869b83b43e420f();
}

function function_81307e1899871835() {
  scripts\cp_mp\vehicles\vehicle_anim::init_vehicles();
}

function function_e1328f6ecc1b19e9() {
  namespace_1170726b2799ea65::function_cece888a7dfbeb0b();
  function_9250dfcc43a9ccb9();
  thread namespace_a637649c8cd4ff68::function_2e71e16db1ac390a();
}

function function_d6ff019279ea20e() {
  flag_set("flag_apt_basement_complete");
  function_9250dfcc43a9ccb9();
  thread namespace_a637649c8cd4ff68::function_23729f7cf505880a();
  thread function_ec71d9929947ee39("pre_hvt_roof_group");
}

function function_d6fef19279e9fdb() {
  flag_set("flag_apt_basement_complete");
  function_9250dfcc43a9ccb9();
  thread namespace_a637649c8cd4ff68::function_23729e7cf50585d7();
  thread namespace_72b44a95db6318c::function_2ac4b666d5219b3c("mid", "flag_apt_mid_complete");
  flag_wait("level_ready_for_script");
  thread function_ec71d9929947ee39("pre_hvt_roof_group", 1);
  thread function_ec71d9929947ee39("mid_2_group", 1);
}

function function_1b2176c7c876052c() {
  flag_set("flag_apt_basement_complete");
  flag_set("flag_apt_mid_complete");
  thread function_4e257994365fa73f("upper_2_floor_spawn", "upper_2_floor_spawn_trig");
  function_9250dfcc43a9ccb9();
  thread namespace_a637649c8cd4ff68::function_f409ff83748d977c();
  function_6149b301ce19988b("pre_hvt_roof_group", &function_3e28d41bce5691de);
}

function function_1b2179c7c8760bc5() {
  flag_set("flag_apt_basement_complete");
  flag_set("flag_apt_mid_complete");
  thread function_4e257994365fa73f("upper_2_floor_spawn", "upper_2_floor_spawn_trig");
  function_9250dfcc43a9ccb9();
  thread namespace_a637649c8cd4ff68::function_f40a0283748d9e15();
  thread namespace_72b44a95db6318c::function_2ac4b666d5219b3c("upper", "flag_apt_upper_complete");
  function_6149b301ce19988b("pre_hvt_roof_group", &function_3e28d41bce5691de);
}

function function_14b08933e9f75a9a() {
  flag_set("flag_apt_basement_complete");
  flag_set("flag_apt_mid_complete");
  flag_set("flag_apt_upper_2_started");
  flag_set("flag_apt_upper_complete");
  flag_set("show_blimp");
  flag_set("ally_vo_reveal");
  flag_set("ally_can_rappel");
  thread function_4e257994365fa73f("move_price_to_roof", "move_price_to_roof");
  thread function_4e257994365fa73f("roof_spawn", "roof_spawn_trig");
  function_9250dfcc43a9ccb9();
  thread namespace_a637649c8cd4ff68::function_21f1f6c11a565371();
  function_15ac00c604af0413("ally_overwatch_loc");
}

function function_abf07e37c671cfa6() {
  flag_set("flag_apt_basement_complete");
  flag_set("flag_apt_mid_complete");
  flag_set("flag_apt_upper_2_started");
  flag_set("flag_apt_upper_complete");
  flag_set("show_blimp");
  flag_set("ally_on_roof");
  function_9250dfcc43a9ccb9();
  thread namespace_a637649c8cd4ff68::function_c456e31e8791085c();
  function_3649512a462f8e82();
  level.hvt.var_b3054dce8cc525f2 = 1;
  level.hvt namespace_1170726b2799ea65::function_624150e2bc78e81f("Nolan");
  function_15ac00c604af0413("ally_exfil_loc");
  level.ally function_9f2ada961e09fb18();
}

function start_defend() {
  flag_set("flag_apt_basement_complete");
  flag_set("flag_apt_mid_complete");
  flag_set("flag_apt_upper_2_started");
  flag_set("flag_apt_upper_complete");
  flag_set("show_blimp");
  flag_set("ally_on_roof");
  level.var_a423e6fbd31e09cf = [];
  function_9250dfcc43a9ccb9();
  thread namespace_a637649c8cd4ff68::function_d30a3a4e9341a243();
  function_3649512a462f8e82();
  level.hvt.var_b3054dce8cc525f2 = 1;
  level.hvt namespace_1170726b2799ea65::function_624150e2bc78e81f("Nolan");
  function_15ac00c604af0413("ally_overwatch_loc");
  level.ally function_9f2ada961e09fb18();
  thread function_7fc28b641bd8f6bd();
}

function function_b0f6d6910f3b8af8() {
  flag_set("flag_apt_basement_complete");
  flag_set("flag_apt_mid_complete");
  flag_set("flag_apt_upper_2_started");
  flag_set("flag_apt_upper_complete");
  flag_set("show_blimp");
  flag_set("ally_on_roof");
  level.var_a423e6fbd31e09cf = [];
  function_9250dfcc43a9ccb9();
  thread namespace_a637649c8cd4ff68::function_eee5bf44e4a36c41();
  function_3649512a462f8e82();
  level.hvt.var_b3054dce8cc525f2 = 1;
  level.hvt namespace_1170726b2799ea65::function_624150e2bc78e81f("Nolan");
  function_15ac00c604af0413();
  level.ally function_9f2ada961e09fb18();
  thread function_7fc28b641bd8f6bd();
}

function function_7560e0d167fc9e3d() {
  flag_wait("start_mission_flow");
  thread show_blimp();
  thread play_intro();
  thread intro_music();
  thread function_4b59baf32869dfa4();
  flag_wait("flag_dungeon_intro_complete");
  level.player dof_disable();
  thread namespace_72b44a95db6318c::function_2ac4b666d5219b3c("basement", "flag_apt_basement_complete");
  thread function_5db55ded4b9d3d21();
  function_6149b301ce19988b("pre_hvt_roof_group", &function_3e28d41bce5691de);
  function_d14fcd3a04720601("basement_elevator_guy_trigger");
  level thread function_742e994b8f2560fd();
  level thread function_6efca826052dbc92();
  flag_wait("player_top_of_basement_elevator");
  flag_set("flag_apt_basement_complete");
  namespace_b96fa4d8ce10f926::function_6ae6331457ff833d();
}

function intro_music() {
  setmusicstate("mx_apt_intro");
}

function basement_catchup() {
  thread namespace_1170726b2799ea65::function_cece888a7dfbeb0b();
}

function function_742e994b8f2560fd() {
  on_ladder = 0;
  dvar = @ "hash_80e61d093d70f81f";
  var_bfd725c8b1180517 = 0.4;
  val = var_bfd725c8b1180517 * 0.6;
  setDvar(dvar, var_bfd725c8b1180517);

  while(!flag("elevator_dialogue_done") && !flag("player_top_of_basement_elevator")) {
    if(!on_ladder && level.player isonladder()) {
      on_ladder = 1;
      setDvar(dvar, val);
    } else if(on_ladder && !level.player isonladder()) {
      on_ladder = 0;
      setDvar(dvar, var_bfd725c8b1180517);
    }

    waitframe();
  }

  setDvar(dvar, var_bfd725c8b1180517);
}

function function_ab29beccfe9bb49b() {
  if(should_play_intro() && !flag("intro_skipped")) {
    wait 8;
  }

  if(function_3ac1f74e29c477d9()) {
    return;
  }

  if(flag("basement_enemy_spawned")) {
    return;
  }

  spawner = getStruct("1_lower_group", "targetname");
  spawner function_5563625b36395600(&function_c4869b83b43e420f);
  flag_set("basement_enemy_spawned");
  guy = spawner function_3bc156ea86eac9e2(1);
}

function function_4b59baf32869dfa4() {
  flag_wait("near_basement_ascender");

  if(!function_1f067aa9b7648939()) {
    return;
  }

  thread function_ad9a31085eee46();
}

function function_98cca25078a53c4e() {
  flag_wait("start_mission_flow");
  thread function_791f60497ce995d4();
  spawners = getStructArray("1_mid_group_first_guys", "targetname");
  function_6933179df6aa483e(spawners, &function_ebcb135cf211f106);

  foreach(spawner in spawners) {
    spawner.script_deathflag = "mid_1_kill_first_guys";
  }

  guys = function_ec71d9929947ee39("1_mid_group_first_guys");
  level.var_83ff5ca62aefdeb9 = guys;
  level thread function_24d06ee4cf6331e6();
  spawners = getStructArray("mid_1_front_enemies", "targetname");
  function_6933179df6aa483e(spawners, &function_6d9ed3679c7a0323);
  thread function_52efb572a14e9a9e();
  spawners = getStructArray("mid_1_enemies", "targetname");
  function_6933179df6aa483e(spawners, &function_9aac0747def22ad8);
  function_ec71d9929947ee39("mid_1_front_enemies");
  function_ec71d9929947ee39("mid_1_enemies");
  function_ec71d9929947ee39("mid_2_group");
  thread function_df9bfcbd1a906fc3(guys);
  thread function_846b52899bd3da27();
  thread namespace_72b44a95db6318c::function_2ac4b666d5219b3c("mid", "flag_apt_mid_complete");
  level.player scripts\cp\movement::player_movement_state("default");
  thread spawn_on_stealth_break("1_mid_backup", undefined, "player_entered_mid_1_floor_2");
  thread function_4e257994365fa73f("player_near_blocked_stairs", "stairs_blocked_callout_trig");
  thread function_4e257994365fa73f("first_courtyard_view", "first_courtyard_view_trig");
  thread function_4e257994365fa73f("mid_1_enable_flyby", "mid_1_enable_flyby_trig");
  thread function_4e257994365fa73f("mid_1_to_upper_1_kickdown", "mid_1_to_upper_1_kickdown_trig");
  var_59ec9db05666f00 = ["1_mid_group_first_guys", "1_mid_group", "1_mid_backup"];
  thread function_4467fca29549fcaa(var_59ec9db05666f00, "mid_1_all_clear", "flag_apt_mid_1_complete");
  flag_wait_either("mid_2_start", "mid_1_to_upper_1_kickdown");
  flag_set("flag_apt_mid_1_complete");
}

function function_791f60497ce995d4() {
  flag_wait("mid_1_trap_route");
  struct = getStruct("mid_1_laser_traps_area", "targetname");
  radiussqrd = squared(struct.radius);

  foreach(trap in level.laser_traps) {
    if(distancesquared(trap.origin, struct.origin) < radiussqrd) {
      trap.var_16b75ff80e325c75 = gettime() + 60000;
    }
  }
}

function function_ec71d9929947ee39(targetname, forcespawn) {
  spawners = getStructArray(targetname, "targetname");
  function_6933179df6aa483e(spawners, &function_c4869b83b43e420f);
  guys = function_f1543fa991abb308(spawners, forcespawn);
  return guys;
}

function function_ebcb135cf211f106() {
  groupname = "mid_1_first";
  function_7e7d0b7221a5ab23(groupname, self);

  if(function_6f029baefb2143cf(groupname) == 2) {
    guys = function_d330ef725ee0137c(groupname);
    level thread function_17040b13d6d0d1d3(guys);
  }
}

function function_6d9ed3679c7a0323() {
  self.var_cbd87a0bc497b778 = 1;
  groupname = "mid_1_front";
  function_7e7d0b7221a5ab23(groupname, self);

  if(isDefined(self.script_linkto)) {
    waittillframeend();
    self.var_f843fbbada4e59b2 = 1;
    scripts\stealth\utility::set_stealth_func("hunt_custom_init", &function_e25a85752f87d0b);
    scripts\stealth\utility::set_stealth_func("hunt_custom_terminate", &function_efdb2f679da56f2c);
    thread function_eb83afa070829bc6();
  }
}

function function_eb83afa070829bc6() {
  self endon("death");
  self waittill("stealth_combat");
  waitframe();
  thread function_32440566084da420();
}

function function_ece85c8d7a219e6b() {
  self.var_f843fbbada4e59b2 = 0;
  self notify("stop_going_to_node");
  self notify("stop_custom_hunt");
  scripts\stealth\utility::set_stealth_func("hunt_custom_init", undefined);
  scripts\stealth\utility::set_stealth_func("hunt_custom_terminate", undefined);
}

function function_e25a85752f87d0b() {
  thread function_32440566084da420();
}

function function_32440566084da420() {
  self endon("death");
  self endon("stop_custom_hunt");
  self notify("stop_hunt_movement");
  self endon("stop_hunt_movement");

  if(flag("near_6th_floor_stairs")) {
    return;
  }

  structs = getStructArray("generic_poi", "targetname");

  foreach(struct in structs) {
    function_3a5a98ac68582e12(struct.origin, undefined);
  }

  structs = get_linked_structs();
  struct = structs[0];
  level thread function_454d22c5f4e93aea(self);
  self.goalradius = 32;
  scripts\cp\spawning::go_to_node(struct);
  self.goalradius = 1000;
}

function function_454d22c5f4e93aea(guy) {
  struct = getStruct("6th_floor_aiment_start", "targetname");
  guy thread function_5c65ccad521b35e3(struct);
  guy waittill_any_3("death", "damage", "player_detected");

  if(isalive(guy)) {
    guy notify("stop_player_detected");
    guy.var_abc30858a62a19a = undefined;
    guy.dontevershoot = 0;
    guy notify("stop_going_to_node");
    guy setgoalpos(guy.origin);
  }
}

function function_5c65ccad521b35e3(struct) {
  self endon("death");
  self endon("stop_player_detected");
  end_struct = getStruct(struct.target, "targetname");
  z_dist = struct.origin[2] - end_struct.origin[2];
  dist = distance(struct.origin, end_struct.origin);
  dir = vectorNormalize(end_struct.origin - struct.origin);

  while(true) {
    z = self.origin[2] + 56;

    if(z > struct.origin[2]) {
      percent = 0;
    } else if(z < end_struct.origin[2]) {
      percent = 1;
    } else {
      percent = (struct.origin[2] - z) / z_dist;
    }

    pos = struct.origin + dir * dist * percent;
    self.var_abc30858a62a19a = pos;

    if(self cansee(level.player)) {
      self notify("player_detected");
      break;
    }

    wait 0.05;
  }
}

function function_efdb2f679da56f2c() {
  function_ece85c8d7a219e6b();
}

function function_df9bfcbd1a906fc3(guys) {
  flag_wait("mid_1_elevator_comment_complete");

  foreach(guy in guys) {
    if(isalive(guy)) {
      guy.var_16b75ff80e325c75 = gettime() + 60000;
    }
  }

  flag_set("flag_apt_mid_1_drone_tutorial_complete");
}

function function_846b52899bd3da27() {
  while(!isDefined(level.var_7eaea852d7169e4a) || level.var_7eaea852d7169e4a.ai_spawned.size == 0) {
    wait 0.5;
  }

  radio_guy = level.var_7eaea852d7169e4a.ai_spawned[0];
  level.var_27b0dbdc7c692c9 = spawnStruct();
  radio_guy waittill("death");
  level.var_27b0dbdc7c692c9.origin = radio_guy.origin;
  flag_wait("mid_1_kill_first_guys");
  flag_set("mid_1_start_radio_chatter");
}

function function_9aac0747def22ad8() {
  if(!isDefined(level.mid_1_enemies)) {
    level.mid_1_enemies = [];
  }

  self.var_cbd87a0bc497b778 = 1;
  level.mid_1_enemies[level.mid_1_enemies.size] = self;
  waittillframeend();
  self.var_f843fbbada4e59b2 = 1;
  scripts\stealth\utility::set_stealth_func("hunt_custom_init", &function_f3d5f69b459d540e);
  scripts\stealth\utility::set_stealth_func("hunt_custom_terminate", &function_35dcd36c93144093);
  thread function_7ea90f0350205fde();
}

function function_65ddfa9b2ee88177() {
  if(flag("assigned_mid_1_goals")) {
    return;
  }

  flag_set("assigned_mid_1_goals");
  structs = getStructArray("mid_level_1_cover", "targetname");
  var_ebe0ee21fbd2b61a = undefined;

  foreach(struct in structs) {
    if(isDefined(struct.script_index)) {
      var_ebe0ee21fbd2b61a = struct;
      break;
    }
  }

  guys = sortbydistance(level.mid_1_enemies, var_ebe0ee21fbd2b61a.origin);
  structs = sortbydistance(structs, var_ebe0ee21fbd2b61a.origin);

  foreach(i, guy in guys) {
    if(i == structs.size) {
      break;
    }

    if(i == 0) {
      guy.var_533be64599ab00bc = 1;
    }

    guy.var_432a31ec25b1c23d = structs[i];
  }
}

function function_dfc502ca1c0399bd() {
  if(!isDefined(self.var_432a31ec25b1c23d)) {
    return;
  }

  self.goalheight = 80;
  self.goalradius = self.var_432a31ec25b1c23d.radius;
  self setgoalpos(self.var_432a31ec25b1c23d.origin);

  if(isDefined(self.var_533be64599ab00bc)) {
    thread function_52d526908b473bce();
  }
}

function function_52d526908b473bce() {
  self endon("death");
  self waittill("goal");
  nodes = getnodesinradius(self.var_432a31ec25b1c23d.origin, self.var_432a31ec25b1c23d.radius, 0, 90);
  nodes = sortbydistance(nodes, self.var_432a31ec25b1c23d.origin);
  node = nodes[0];
  self.goalradius = 32;
  self setgoalnode(node);
  self waittill("goal");
  self.combatmode = "ambush";
  self.goalradius = 128;
}

function function_f3d5f69b459d540e() {
  function_65ddfa9b2ee88177();
  function_dfc502ca1c0399bd();
}

function function_35dcd36c93144093() {}

function function_7ea90f0350205fde() {
  self endon("death");

  while(true) {
    self waittill("stealth_combat");
    waitframe();
    function_65ddfa9b2ee88177();
    function_dfc502ca1c0399bd();
  }
}

function function_28c395c697bf915d() {
  flag_wait("start_mission_flow");
  thread function_4e257994365fa73f("upper_2_floor_spawn", "upper_2_floor_spawn_trig");
  thread function_4e257994365fa73f("mid_2_to_upper_2_kickdown", "mid_2_to_upper_2_kickdown_trig");
  flag_wait("mid_2_start");
  thread function_35148079444a7bc1();
  var_f5f12dc3f99c04f1 = getEntArray("building_1_mid_clean_up_trig", "targetname");
  array_thread(var_f5f12dc3f99c04f1, &function_92fef86bd761fd5f, ["1_mid_group", "1_lower_group", "1_mid_backup", "1_mid_group_first_guys"]);
  var_976b2eb846326c2e = getEntArray("upper_floor_clean_up_mid_trig", "targetname");
  array_thread(var_976b2eb846326c2e, &function_92fef86bd761fd5f, ["mid_2_group", "mid_2b_group", "mid_2_backup"]);
  thread function_57aa7542afe8706c();
  thread function_2a475e871d2f36ae();
  thread function_679443d2d2c8a533();
  function_665d474ff040b446(["mid_2b_floor_spawn", "mid_1_to_upper_1_kickdown", "floor_9_shortcut"]);
  function_ec71d9929947ee39("mid_2b_group");
  function_665d474ff040b446(["upper_2_floor_spawn", "mid_2_to_upper_2_kickdown", "floor_9_shortcut"]);
  flag_set("flag_apt_mid_complete");
}

function function_679443d2d2c8a533() {
  level endon("flag_apt_mid_complete");
  flag_wait("mid_2_pop_smoke");
  volumes = getEntArray("info_volume_stealth_all", "classname");
  var_b7e53ff6651b6eed = undefined;
  var_7c9ec3616cffd8e4 = undefined;

  foreach(volume in volumes) {
    if(!isDefined(volume.script_stealthgroup)) {
      continue;
    }

    if(volume.script_stealthgroup == "stealth_2_mid_a") {
      var_b7e53ff6651b6eed = volume;
      continue;
    }

    if(volume.script_stealthgroup == "stealth_2_mid_b") {
      var_7c9ec3616cffd8e4 = volume;
    }
  }

  while(true) {
    guys = getaiarray("axis");
    var_42a7cb82d37c6782 = 0;
    var_1199655748790a94 = [];

    foreach(guy in guys) {
      if(!isalive(guy)) {
        continue;
      }

      if(!isDefined(guy.script_stealthgroup)) {
        continue;
      }

      if(guy.script_stealthgroup != "stealth_2_mid" && guy.script_stealthgroup != "stealth_2_mid_b" && guy.script_stealthgroup != "stealth_2_mid_a") {
        continue;
      }

      if(guy.script_stealthgroup == "stealth_2_mid_a" || guy istouching(var_b7e53ff6651b6eed)) {
        var_42a7cb82d37c6782++;
        continue;
      }

      var_1199655748790a94[var_1199655748790a94.size] = guy;
    }

    if(var_1199655748790a94.size < 3) {
      break;
    }

    if(var_42a7cb82d37c6782 < 4) {
      var_1199655748790a94 = array_randomize(var_1199655748790a94);
      count = min(var_1199655748790a94.size, 2);

      for(i = 0; i < count; i++) {
        var_1199655748790a94[i].script_stealthgroup = "stealth_2_mid_a";
        var_1199655748790a94[i] setgoalvolumeauto(var_b7e53ff6651b6eed);
        var_1199655748790a94[i].var_c59e6903b2fb9ccd = 1;
      }
    }

    wait 1;
  }
}

function function_99640619c3f06481() {
  self endon("death");
  flag_wait("mid_2_pop_smoke");
  self.var_5323a94889eff1de = 1;
  thread function_8aa95780b070856e();
}

function function_2a475e871d2f36ae() {
  level.var_fcf08772033bd968 = [];
  flag_wait("mid_2_pop_smoke");
  wait randomfloat(0.3);
  thread function_bf73f0d2dae5ebf4();
  thread flag_set_delayed("mid_2b_floor_spawn", 10);
  structs = getStructArray("mid_level_smoke", "targetname");

  foreach(struct in structs) {
    struct thread mid_2_pop_smoke();
    wait 2;
  }
}

function mid_2_pop_smoke() {
  target = getStruct(self.target, "targetname");
  speed = 500;

  if(isDefined(self.script_speed)) {
    speed = self.script_speed;
  }

  velocity = vectorNormalize(target.origin - self.origin) * speed;
  nade = magicgrenademanual("smoke_grenade_mp", self.origin, velocity, 2);
  nade waittill("death");
  level thread function_c36dc289e21bdc9e();

  if(isDefined(target.target)) {
    wait 3.5;
    fxstruct = getStruct(target.target, "targetname");
    playFX(getfx("smokey_room"), fxstruct.origin, (0, 0, 1), (1, 0, 0));
    thread function_5490c2804bd6a8c7(fxstruct.origin);
  }
}

function function_5490c2804bd6a8c7(point) {
  wait 2;
  index = level.var_fcf08772033bd968.size;
  level.var_fcf08772033bd968[index] = point;
  wait 45;
  level.var_fcf08772033bd968 = array_remove_index(level.var_fcf08772033bd968, index);
}

function function_c36dc289e21bdc9e() {
  if(flag("smoke_ai_laser")) {
    return;
  }

  flag_set("smoke_ai_laser");
  guys = getaiarray("axis");
  array_thread(guys, &function_8aa95780b070856e);
}

function function_8aa95780b070856e() {
  self endon("death");

  if(istrue(self.var_a3cb79a515e923f6)) {
    return;
  }

  self.var_a3cb79a515e923f6 = 1;
  wait 1 + randomfloat(2);

  if(!isDefined(level.var_4cb4ea0ca914961d)) {
    level.var_ccbeec16970005a5 = gettime() + 45000;
  }

  og_accuracy = self.baseaccuracy;
  var_208220e9e4326e7e = self.baseaccuracy * 0.2;
  var_1f5cfccf1b3f0b76 = 40000;
  var_eeab2d46de4adcf3 = self.maxsightdistsqrd;

  while(gettime() < level.var_ccbeec16970005a5) {
    var_614021f0dd8d29e2 = 0;

    if(function_902a6197eb485390()) {
      var_614021f0dd8d29e2 = 1;
    }

    if(function_3f17bbffb7ff1d8e()) {
      self.maxsightdistsqrd = var_1f5cfccf1b3f0b76;
    } else {
      self.maxsightdistsqrd = var_eeab2d46de4adcf3;
    }

    if(var_614021f0dd8d29e2) {
      self.var_c88fcc14f9bda088 = 1;
      self laserforceon();
      self.baseaccuracy = var_208220e9e4326e7e;
    } else {
      self.var_c88fcc14f9bda088 = undefined;
      self laserforceoff();
      self.baseaccuracy = og_accuracy;
    }

    wait 0.1;
  }

  wait randomfloat(5);
  self.var_c88fcc14f9bda088 = undefined;
  self laserforceoff();
  self.baseaccuracy = og_accuracy;
}

function function_902a6197eb485390() {
  if(abs(self.origin[2] - 1200) > 300) {
    return false;
  }

  if(self.origin[0] < 2740) {
    return false;
  }

  if(self.origin[0] > 3700) {
    return false;
  }

  if(self.origin[1] < 2550) {
    return false;
  }

  if(self.origin[1] > 3400) {
    return false;
  }

  return true;
}

function function_3f17bbffb7ff1d8e() {
  if(!isDefined(level.var_fcf08772033bd968)) {
    return false;
  }

  foreach(point in level.var_fcf08772033bd968) {
    if(abs(point[2] - self.origin[2]) > 90) {
      continue;
    }

    if(distancesquared(point, self.origin) < 90000) {
      return true;
    }
  }

  return false;
}

function function_57aa7542afe8706c() {
  level endon("mid_2b_floor_spawn");
  level endon("mid_1_to_upper_1_kickdown");
  flag_wait("player_near_mid_2_ladder");

  if(flag("broke_stealth_earlier")) {
    function_6149b301ce19988b("mid_2_backup", &function_c4869b83b43e420f);
  }

  var_3740d196ebe21937 = ["mid_2_group", "mid_2_backup"];
  thread function_4467fca29549fcaa(var_3740d196ebe21937, "mid_2_all_clear", "flag_apt_mid_complete");
}

function function_46c028137566c4b0() {
  flag_wait("start_mission_flow");
  thread namespace_72b44a95db6318c::function_2ac4b666d5219b3c("upper", "flag_apt_upper_complete");
  thread function_f3e8f4cd089693dc();
  thread function_572ffceba380e54();
  thread function_4e257994365fa73f("spawn_computer_hallway", "spawn_computer_hallway");
  thread function_4e257994365fa73f("spawn_computer_hallway_back", "spawn_computer_hallway_back");
  thread function_4e257994365fa73f("start_computer_scene", "start_computer_scene");
  thread function_4e257994365fa73f("balloon_first_callout", "balloon_first_callout_trig");
  thread function_4e257994365fa73f("upper_1_shortcut_route", "upper_1_shortcut_route_trig");
  thread function_4e257994365fa73f("upper_1_cargo_side_route", "upper_1_cargo_side_route_trig");
  thread function_28ac83084d8c41d6();
  thread function_7358bbbc3a3e344d();
  thread function_382e7539693dd29();
  flag_wait_either("upper_2_floor_spawn", "mid_2_to_upper_2_kickdown");
}

function function_572ffceba380e54() {
  level endon("mid_2_to_upper_2_kickdown");
  flag_wait_either("spawn_computer_hallway", "spawn_computer_hallway_back");
  childthread function_6c198d4092a1ff57();

  if(!flag("spawn_computer_hallway")) {
    return;
  }

  childthread function_1b18ae2f2f6c3fe5();
  enemies = function_90d3f7b0c040f569("1_upper_group_hallway");
  array_call(enemies, &getenemyinfo, level.player);
  level.var_2009c2f240a11712 = enemies;
  array_thread(enemies, &function_f611cfbcca79846e);
  array_thread(enemies, &function_8f08378040f01528, 0);
  flag_wait("start_computer_scene");
  wait 2;
  flag_set("move_hallway_enemies");
  array_thread(enemies, &function_ad9433aab9fcdf04, 10, "death", &setgoalentity, level.player);

  while(isDefined(enemies) || !flag("hallway_guys_down")) {
    enemies = array_removedead_or_dying(enemies);
    level.var_2009c2f240a11712 = enemies;

    if(enemies.size <= 1) {
      flag_set("hallway_guys_down");
      break;
    }

    wait 1;
  }
}

function function_1b18ae2f2f6c3fe5() {
  var_60e9e0349da382f5 = function_90d3f7b0c040f569("1_upper_group_back_hallway");
  array_thread(var_60e9e0349da382f5, &function_f611cfbcca79846e);
  array_call(var_60e9e0349da382f5, &getenemyinfo, level.player);
  array_thread(var_60e9e0349da382f5, &function_8f08378040f01528, 0);
  flag_wait("move_container_enemies");
  var_60e9e0349da382f5 = array_removedead_or_dying(var_60e9e0349da382f5);
  array_thread(var_60e9e0349da382f5, &function_8f08378040f01528, 1);
  var_aa371fad6cbd5b67 = function_90d3f7b0c040f569("1_upper_group_container");
  array_call(var_aa371fad6cbd5b67, &getenemyinfo, level.player);
  var_2f720ac1a8c3208f = getEnt("vol_container_01", "targetname");
  var_2f720bc1a8c322c2 = getEnt("vol_container_02", "targetname");
  var_aa371fad6cbd5b67[0] setgoalvolumeauto(var_2f720ac1a8c3208f);
  var_aa371fad6cbd5b67[1] setgoalvolumeauto(var_2f720bc1a8c322c2);
  flag_wait("move_enemies_upper_010");
  enemies = array_removedead_or_dying(var_aa371fad6cbd5b67);

  if(!isDefined(enemies) || enemies.size == 0) {
    return;
  }

  array_call(enemies, &cleargoalvolume);
  array_call(enemies, &setgoalentity, level.player);
}

function function_6c198d4092a1ff57() {
  enemy = function_90d3f7b0c040f569("computer_enemy")[0];
  enemy.animname = "computer_enemy";
  level.computer_enemy = enemy;
  enemy endon("death");
  enemy function_8f08378040f01528(0);
  enemy childthread function_6f2ea1b4137352ef();
  enemy childthread function_43199f84ff9c4544();
  animnode = getStruct("animnode_computer", "targetname");
  enemy childthread function_4223f79d246e29d4(animnode);
  flag_wait("start_computer_scene");
  waitframe();
  enemy function_e483413541e6f5cc();
  animnode anim_single_solo(enemy, "computer_react");
  node = getnode("computer_enemy_node", "targetname");
  enemy setgoalnode(node);
}

function function_4223f79d246e29d4(animnode) {
  level endon("start_computer_scene");

  while(true) {
    animnode anim_single_solo(self, "computer_idle");
  }
}

function function_6f2ea1b4137352ef() {
  level endon("start_computer_scene");

  while(!level.player can_see_origin(self getEye(), 0)) {
    wait 0.5;
  }

  flag_set("start_computer_scene");
}

function function_43199f84ff9c4544() {
  waittill_any_3("grenade danger", "bulletwhizby", "gunshot");
  flag_set("start_computer_scene");
}

function function_7358bbbc3a3e344d() {
  function_10e0e4b151086982("upper_1_cargo_side_route", "mid_2_to_upper_2_kickdown", "upper_1_shortcut_route");
  temp_dialogue("flag wait any 3 works!");
  flag_set("flag_disable_upper_1_balcony_flyby");
}

function function_382e7539693dd29() {
  flag_wait_either("upper_2_floor_spawn", "mid_2_to_upper_2_kickdown");
  flag_set("flag_disable_upper_1_start_flyby");
}

function function_28ac83084d8c41d6() {
  level endon("flag_apt_upper_2_started");
  level endon("mid_2_to_upper_2_kickdown");
  function_d14fcd3a04720601("1_upper_riot_trig");

  if(flag("broke_stealth_earlier")) {
    function_6149b301ce19988b("1_upper_group_riot", &function_c4869b83b43e420f);
  }

  var_e3cfd2875e56846 = ["1_upper_group", "1_upper_group_riot"];
  thread function_4467fca29549fcaa(var_e3cfd2875e56846, "upper_1_all_clear", "flag_apt_upper_2_started");
}

function function_89da309601320b5b() {
  flag_wait("start_mission_flow");
  flag_set("flag_apt_upper_2_started");
  flag_set("flag_disable_upper_1_zipline_flyby");
  thread function_b7e506c96e1e4f2();
  thread function_ff2d9615653a6c07();
  flag_wait("ally_can_rappel");
  flag_set("show_blimp");
  flag_set("flag_apt_upper_complete");
}

function function_b7e506c96e1e4f2() {
  thread function_4e257994365fa73f("upper_2_backup_a_spawn", "upper_2_backup_a_spawn_trig");
  thread function_4e257994365fa73f("start_ally_reveal", "start_ally_reveal_trig");
  thread function_4e257994365fa73f("start_ally_reveal_target", "start_ally_reveal_target_trig");
  thread function_4e257994365fa73f("player_can_see_ally_reveal", "player_can_see_ally_reveal");
  thread function_4e257994365fa73f("nearing_upper_2_screens", "nearing_upper_2_screens_trig");
  thread function_4e257994365fa73f("move_price_to_roof", "move_price_to_roof");
  thread function_4e257994365fa73f("roof_spawn", "roof_spawn_trig");
  thread function_4e257994365fa73f("move_enemies_upper_010", "move_enemies_upper_010");
  thread function_4e257994365fa73f("move_enemies_upper_020", "move_enemies_upper_020");
  thread function_4e257994365fa73f("move_enemies_upper_030", "move_enemies_upper_030");
}

function function_ff2d9615653a6c07() {
  thread function_eb5e7c2c5ba3f45f();
  thread function_40230f0ad69636b8();
  thread function_58d06b3cb403a437();
  level endon("mid_2_to_upper_2_kickdown");
  flag_wait("upper_2_floor_spawn");
  enemies = function_90d3f7b0c040f569("2_upper_group");
  array_call(enemies, &getenemyinfo, level.player);
  array_thread(enemies, &function_f611cfbcca79846e);
  flag_wait("move_enemies_upper_020");
  enemies = getaiarray("axis");

  if(isDefined(enemies)) {
    array_call(enemies, &function_710bd6843f902d50, level.player, 1);
  }
}

function function_40230f0ad69636b8() {
  flag_wait("player_can_see_ally_reveal");
  enemies = function_90d3f7b0c040f569("2_upper_backup_b");
  level.var_2e5f1280969b82bc = enemies;
  array_thread(enemies, &function_f611cfbcca79846e);
  var_3188dd38f49c4249 = ["2_upper_group", "2_upper_backup_a", "2_upper_backup_b"];
  thread function_4467fca29549fcaa(var_3188dd38f49c4249, "upper_2_all_clear", "flag_apt_upper_complete");
}

function function_eb5e7c2c5ba3f45f() {
  flag_wait("upper_2_backup_a_spawn");
  struct = function_7a18da6e48b71c35("struct_sight_roof_entrance");

  while(!level.player can_see_origin(struct.origin, 0)) {
    wait 0.1;

    if(distance2d(level.player.origin, struct.origin) < 300) {
      break;
    }
  }

  flag_set("player_can_see_ally_reveal");
}

function function_58d06b3cb403a437() {
  flag_wait("start_ally_reveal_target");
  flag_set("apt_drone_callout_stop");
  function_15ac00c604af0413();
  level.ally hide();
  animnode = getStruct("animnode_ally_rappel", "targetname");
  level.ally.ascender = spawn_anim_model("ascender");
  animnode anim_first_frame_solo(level.ally, "zipline");
  animnode anim_first_frame_solo(level.ally.ascender, "zipline");
  pistol = spawn("script_model", level.ally gettagorigin("tag_weapon_left"));
  pistol.angles = level.ally gettagangles("tag_weapon_left");
  pistol setModel("weapon_wm_pi_decho_brprop");
  pistol notsolid();
  pistol function_3671ec427c125cb(1);
  level.ally attach(pistol.model, "tag_weapon_left");
  target_guy = function_90d3f7b0c040f569("ally_reveal_target")[0];
  node = getnode("node_platform", "targetname");
  target_guy setgoalnode(node);
  target_guy.goalradius = 20;
  flag_wait("start_ally_reveal");
  target_guy getenemyinfo(level.player);
  target_guy.favoriteenemy = level.player;

  if(!flag("mid_1_to_upper_1_kickdown") && !flag("mid_2_to_upper_2_kickdown")) {
    while(isalive(target_guy) && !level.player point_in_fov(target_guy.origin, 0.9, 1) && !level.player point_in_fov(level.ally.origin, 0.8, 0)) {
      waitframe();
    }
  }

  level.ally show();
  flag_set("ally_can_rappel");
  function_656abb0204a14ad2(target_guy);
  flag_set("ally_vo_reveal");

  if(function_9368a8111e60213c()) {
    scripts\common\utility::giveachievement_wrapper("jup_sp_fullsweep", undefined);
  }
}

function function_656abb0204a14ad2(target_guy) {
  level.var_bb473981236c9e8a = 0;

  if(isalive(target_guy)) {
    thread namespace_78ef5a12a453ec66::function_b248bf57abb8eb43();
    target_guy function_25a5214a0216859d();
    level.var_bb473981236c9e8a++;
  }

  if(isalive(level.var_2e5f1280969b82bc[0])) {
    level.var_2e5f1280969b82bc[0] function_25a5214a0216859d();
    level.var_bb473981236c9e8a++;
  }

  if(isalive(level.var_2e5f1280969b82bc[1])) {
    level.var_2e5f1280969b82bc[1] function_25a5214a0216859d();
    level.var_bb473981236c9e8a++;
  }

  flag_set("balcony_clear");
}

function function_25a5214a0216859d() {
  if(!isalive(self)) {
    return;
  }

  if(self.team != "axis") {
    return;
  }

  target = self getEye();
  thread namespace_78ef5a12a453ec66::function_87fa20426a85dd01(self);

  for(i = 0; i < 2; i++) {
    level waittill("price_fire");
    start = level.ally gettagorigin("tag_flash");
    level.ally shootblank();
    magicbullet(level.ally.weapon, start, target);
    playFXOnTag(getfx("vfx_apt_price_shot_light_flash"), level.ally, "tag_weapon_left");
  }

  if(isalive(self)) {
    playFXOnTag(getfx("vfx_apt_blood_spurt_price_shot"), self, "j_head");
    thread namespace_78ef5a12a453ec66::function_62e0ae6e1529d894(self);
    self kill();
  }
}

function function_7f01861c4769bb73(animnode) {
  thread function_d4c3b4bade61472b();
  anime = getanim("snipe_death");
  animlength = getanimlength(anime);
  wait animlength - 0.8;
  self notify("CancelAnimscriptMP");
  self.var_f543095c3ca1b743 = 1;
  self kill();
}

function function_d4c3b4bade61472b() {
  wait 1;
  shieldweapon = self.secondaryweapon;
  droppedweapon = spawn("weapon_" + getcompleteweaponname(shieldweapon), self gettagorigin(self.riotshieldmodeltag));
  droppedweapon.angles = self gettagangles(self.riotshieldmodeltag);
  droppedweapon physicslaunchserveritem(droppedweapon.origin, (0, 0, 15));
  removeriotshield();
}

function function_6eeb961d2a2bb2cc() {
  flag_wait("start_mission_flow");
  thread function_e46b766028526ae8();
  thread function_49b78194831e97fc();
  thread namespace_72b44a95db6318c::function_2ac4b666d5219b3c("roof", "flag_apt_roof_complete");
  thread function_4e257994365fa73f("player_sees_roof_vista", "player_sees_roof_vista_trig");
  flag_set("roof_entered");
  flag_set("stop_price_callouts");
  function_92fef86bd761fd5f(["pre_hvt_roof_group"], 1);
  function_25a1f70006faef38(1200);
  flag_wait("player_sees_roof_vista");
  thread function_25a1f70006faef38(undefined, 1712);
  thread function_6c91df86c1709d2d();
  wait 0.5;
  flag_set("obj_find_hostage_completed");
  thread function_4e257994365fa73f("player_left_roof", "player_left_roof_trig");
  flag_wait("player_detected_on_roof");
}

function function_6c91df86c1709d2d() {
  flag_wait("player_detected_on_roof");
  enemies = getaiarray("axis");
  array_thread(enemies, &function_f74cb67ae3fe24a6);
}

function function_f74cb67ae3fe24a6() {
  self endon("death");

  if(self.origin[2] > 1824) {
    return;
  }

  self cleargoalvolume();
  self setgoalpos((2516, 2830, 1728), 550);
  self.goalheight = 90;
  self getenemyinfo(level.player);
}

function function_c25a949b60b2276() {
  flag_set("flag_apt_basement_complete");
  flag_set("flag_apt_mid_complete");
  flag_set("flag_apt_upper_2_started");
  flag_set("flag_apt_upper_complete");
  flag_set("start_grenade_toss");
  flag_set("player_on_stronghold_platform");
  flag_set("show_blimp");
  flag_set("ally_on_roof");
  function_9250dfcc43a9ccb9();
  thread namespace_a637649c8cd4ff68::function_21f1f6c11a565371();
  function_15ac00c604af0413("ally_capture_loc");
  level.ally function_9f2ada961e09fb18();
  function_3649512a462f8e82();
  level.hvt.var_b3054dce8cc525f2 = 1;
  level.hvt namespace_1170726b2799ea65::function_624150e2bc78e81f("Nolan");
  level.player dof_disable();
}

function function_4c4b6a361a9f1242() {
  while(!isDefined(level.player) || !isDefined(level.ally) || !isDefined(level.hvt)) {
    waitframe();
  }

  level.ally thread function_fd3ba40a9855b20e();
  level.ally thread ally_pickup_shield();
  function_bab16442a9403b9a();
  level waittill("start_hvt_convo");
  thread function_4e257994365fa73f("move_helo_2_troops", "move_helo_2_troops");
  thread function_4e257994365fa73f("nearing_blimp_platform", "nearing_blimp_platform_trig");
  thread function_7771434df4ddcffb();
  level.var_a423e6fbd31e09cf = [];
  thread function_73af9109ffdaa2f();
  level.player waittill("hostage_started_pick_up");
  flag_clear("flag_dungeon_apt_overwatch_enabled");
  flag_set("hvt_picked_up_first_time");
  flag_set("player_carrying_hvt");

  while(!istrue(level.player.var_859654e0445a36d9)) {
    waitframe();
  }

  flag_set("obj_secure_hostage_completed");
}

function function_2194eb93bba27f81() {
  level waittill("attach_interact_used");
  waitframe();
  level.player allow_gesture(1);
}

function show_blimp() {
  while(!isDefined(level.blimp) || !isDefined(level.var_133a64079b5e0c25)) {
    wait 0.1;
  }

  level.blimp hide();
  level.var_133a64079b5e0c25 hide();
  flag_wait("show_blimp");
  level.blimp show();
  level.var_133a64079b5e0c25 show();
}

function function_f33085177441ad08() {
  self detach(self.headmodel);
  head = spawn("script_model", (0, 0, 0));
  head setModel("c_jup_head_hero_nolan");
  head function_3671ec427c125cb(1);
  self attach(head.model, "", 1);
  self.headmodel = head;
  thread function_146a9686d5de0626(self.headmodel);
}

function function_dc995a70ce74fcee() {
  if(isDefined(self.headmodel)) {
    if(isent(self.headmodel)) {
      return;
    } else {
      self detach(self.headmodel);
    }
  }

  head = spawn("script_model", (0, 0, 0));
  head setModel(self.headmodel);
  head function_3671ec427c125cb(1);
  self attach(head.model, "", 1);
  self.headmodel = head;
  thread function_146a9686d5de0626(self.headmodel);
}

function function_146a9686d5de0626(headmodel) {
  self waittill("death");

  if(!isDefined(headmodel)) {
    return;
  }

  headmodel delete();
}

function function_bab16442a9403b9a() {
  flag_wait("start_grenade_toss");
  level.hvt thread function_58cad6fc6431108d();
  level.ally thread function_da5a3f60e9b82a17();
  flag_wait("player_on_stronghold_platform");
  function_3434182d74435bdd();

  while(getaiarray("axis").size > 0) {
    waitframe();
  }

  flag_set("obj_secure_roof_completed");
  flag_set("flag_dungeon_apt_roof_enemies_cleared");
  flag_set("flag_dungeon_hostage_interact_enabled");
}

function function_fd3ba40a9855b20e() {
  flag_wait("start_grenade_toss");
  self notify("stop_color_movement");
  vol = getEnt("vol_upper_stronghold", "targetname");
  self setgoalvolumeauto(vol);
  flag_wait("can_start_hvt_convo");
  node = getnode("ally_node_before_capture", "targetname");
  self setgoalnode(node);
  level waittill("start_hvt_convo");
  node = getnode("ally_node_after_capture", "targetname");
  self setgoalnode(node);
}

function ally_pickup_shield() {
  level endon("game_ended");
  self endon("death");

  if(isDefined(level.start_point)) {
    if(level.start_point == "capture") {
      shared::forceuseweapon(self.secondaryweapon, "primary");
    }
  }

  animnode = getStruct("animnode_ally_shield_pickup", "targetname");
  flag_wait("obj_secure_roof_completed");
  level.player waittill("hostage_started_pick_up");
  animnode anim_first_frame_solo(self, "ally_pickup_shield");
  wait 3.5;
  animnode anim_single_solo(self, "ally_pickup_shield");
  self detach("weapon_wm_riotshield_p34", "tag_accessory_left");
  function_44d0c7896ec50e9();
  thread namespace_6e0c78e9663c0033::function_72f87f6619b5a684("color_movement_roof_return");
  flag_wait("attach_interact_used");
  thread function_7ca87a5fedfb69fb();
}

function function_44d0c7896ec50e9() {
  self.weapon = self.secondaryweapon;
  self giveweapon(self.weapon);
  self.bulletsinclip = weaponclipsize(self.weapon);
  self.primaryweapon = self.weapon;
  scripts\anim\shared::forceuseweapon(self.weapon, "primary");
  self.secondaryweapon = makeweapon("iw9_me_riotshield_mp");
  self setoverridearchetype("default", "riotshield");
  scripts\aitypes\riotshield\riotshield::riotshield_init_cp();
  self.var_c833409fb72d15fb = 1;
  self._blackboard.forcestrafe = 1;
  self.dropweapon = 0;
  return self.secondaryweapon;
}

function function_150874ef396ff6e() {
  thread function_338422e9c3e5d94a();
  level.player_rig thread function_553691388af53d85();
  flag_wait_all("obj_secure_roof_completed", "can_start_hvt_convo");
  tag = self gettagorigin("j_elbow_ri");
  var_3ec6d7d1b7f04d7b = spawn_tag_origin(tag, self.angles);
  interact = var_3ec6d7d1b7f04d7b create_interact(undefined, (0, 0, 10), 90, 260, &"CP_JUP_APT/SECURE_NOLAN_INTERACT");
  level.var_a208d3c07dba8204 = interact;
  interact waittill("trigger", player);
  thread function_8d57a95131614641();

  if(level.player isnightvisionon()) {
    level.player nightvisionviewoff();
  }

  level notify("start_hvt_convo");
  interact delete();
}

function function_8d57a95131614641() {
  setmusicstate("mx_apt_exfil_beg");
}

function function_338422e9c3e5d94a() {
  level endon("game_ended");
  self endon("death");
  function_e483413541e6f5cc();
  scripts\anim\shared::dropaiweapon(self.secondaryweapon);
  node = getnode("node_hvt_surrender", "targetname");
  self.origin = node.origin;
  self.angles = node.angles;
  waitframe();
  function_b87686065982f169();
  flag_set("fake_hvt_spawned");
  level.var_8b3e280380afbbd.headmodel scriptmodelplayanim("jup_apt_skyhook_capture_nolan_stand_to_loop");
  thread anim_single_solo(level.var_8b3e280380afbbd, "capture_stand");
  anim_single_solo(self, "capture_stand");
  thread function_cb6e737c19156bce();
  waitframe();
  flag_set("can_start_hvt_convo");
  self waittill("started_hvt_convo");
  function_e483413541e6f5cc();
  level thread function_1177e1ce21ca9584();
  level.var_8b3e280380afbbd.headmodel scriptmodelplayanim("jup_apt_skyhook_capture_nolan_conversation_head");
  thread anim_single_solo(level.var_8b3e280380afbbd, "capture_convo");
  thread anim_single_solo(self, "capture_convo");
  self waittill("start_pickup_anim");
  function_e483413541e6f5cc();
  var_fb4e7aacfb225799 = spawnStruct();
  var_fb4e7aacfb225799.origin = self.origin;
  var_fb4e7aacfb225799.angles = self.angles + (0, 180, 0);
  var_fb4e7aacfb225799 anim_first_frame_solo(level.var_8b3e280380afbbd, "pickup_ground_8");
  var_fb4e7aacfb225799 anim_first_frame_solo(self, "pickup_ground_8");
  thread namespace_c9c644ec9ed13750::hostage_onuse(level.player, 1, 1);
}

function function_1177e1ce21ca9584() {
  modelnames = ["c_jup_carry_rig_skeleton_nolan"];
  models = [];

  foreach(modelname in modelnames) {
    temp = spawn("script_model", level.player.origin + (0, 0, 100));
    temp setModel(modelname);
    temp dontcastshadows();
    models[models.size] = temp;
  }

  level waittill("player_picked_up_hostage");
  array_delete(models);
}

function function_b87686065982f169() {
  function_140951a95fc605a5();
  self invisiblenotsolid();
  self hide();
  self.headmodel hide();
  level.var_8b3e280380afbbd function_e566bf8f7e6e1788();
}

function function_140951a95fc605a5() {
  level.var_8b3e280380afbbd = spawn("script_model", self.origin);
  level.var_8b3e280380afbbd.angles = self.angles;
  level.var_8b3e280380afbbd.animname = self.animname;
  level.var_8b3e280380afbbd assign_animtree("hvt");
  level.var_8b3e280380afbbd setModel(self.model);
}

function function_e566bf8f7e6e1788() {
  head = spawn("script_model", (0, 0, 0));
  head setModel("c_jup_head_hero_nolan");
  head linkTo(self, "j_spine4", (0, 0, 0), (0, 0, 0));
  self.headmodel = head;
  thread function_146a9686d5de0626(self.headmodel);
}

function function_cb6e737c19156bce() {
  self endon("death");
  self endon("started_hvt_convo");
  level.var_8b3e280380afbbd.headmodel scriptmodelplayanim("jup_apt_skyhook_capture_nolan_idle_loop_head");

  while(true) {
    thread anim_single_solo(level.var_8b3e280380afbbd, "capture_idle");
    anim_single_solo(self, "capture_idle");
  }
}

function function_553691388af53d85() {
  level waittill("start_hvt_convo");
  level.player thread dof_enable(10, undefined, level.hvt.headmodel);
  level.player thread utility::dof_enable_autofocus(10, level.hvt.headmodel);
  level.player thread hidehudenable();
  self show();
  self dontcastshadows();
  level.player.switchweapon = level.player getcurrentweapon();
  level.hvt link_player_to_rig("capture_convo", "stand", 0, undefined, 0, 0, 0, 0, 0, undefined, undefined, 1);
  level.hvt notify("started_hvt_convo");
  waittillframeend();
  level.hvt anim_single_solo(self, "capture_convo");
  self castshadows();
  level.hvt notify("start_pickup_anim");
  level.player dof_disable();
}

function function_49b78194831e97fc() {
  flag_wait("ally_can_rappel");
  thread function_4e257994365fa73f("move_to_corner", "move_leftover_enemies_corner");
  thread function_4d3604112fa2a843();
  thread roof_combat_start();
  thread function_613a172485df6f71();
  thread function_4d34c3c4bc62a89c();
}

function function_d47f70d349b8418d() {
  flag_wait("kickoff_roof_combat");
  time = randomintrange(9, 12);
  wait time;
  playerstartpos = getStruct("player_start_pos", "targetname");
  grenadepos = getStruct("player_start_grenade_pos", "targetname");
  playerstartpos = playerstartpos.origin;
  grenadepos = grenadepos.origin;
  vec = vectorNormalize(playerstartpos - grenadepos);

  if(distance2d(level.player.origin, playerstartpos) < 180) {
    nade = magicgrenademanual("semtex_mp", grenadepos, vec * (1350, 1350, 0) + (0, 0, 355), 5);
  }
}

function function_b39944dcf5c07414() {
  flag_wait("obj_exfil_started");
  wait 2.5;
  playerpos = (3424, 1892, 1896);
  grenadepos = getStruct("player_end_grenade_pos", "targetname");
  grenadepos = grenadepos.origin;
  vec = vectorNormalize(playerpos - grenadepos);
  nade = magicgrenademanual("semtex_mp", grenadepos, vec * ((1900, 2400, 0) + (0, 0, 500)), 3);
}

function roof_combat_start() {
  thread function_d47f70d349b8418d();
  flag_wait("roof_spawn");
  waitframe();
  flag_set("player_approaching_roof");
  var_6dca195d237c93bd = function_90d3f7b0c040f569("enemy_roof_riot");
  enemies = function_90d3f7b0c040f569("enemy_roof_start");
  array_thread(var_6dca195d237c93bd, &function_e80e278e94394c39);
  array_thread(enemies, &function_e80e278e94394c39);
  var_4e1743e2518ae112 = array_add(var_6dca195d237c93bd, level.hvt);
  array_thread(var_4e1743e2518ae112, &function_23674e32f28635c0, var_4e1743e2518ae112);
  array_thread(enemies, &function_f611cfbcca79846e);
  level.var_f4bd83ae99600161 = 0;
  level.var_7cf64959ff09db1 = 3;
  node = var_6dca195d237c93bd[0] getnearestnode();
  var_6dca195d237c93bd[0] thread function_4bac628a9b66b610(node);
  node = var_6dca195d237c93bd[1] getnearestnode();
  var_6dca195d237c93bd[1] thread function_4bac628a9b66b610(node);
  thread function_4da81b8c4294e109();
  flag_wait_or_timeout("player_detected_on_roof", 8);
  flag_set("kickoff_roof_combat");
  thread flag_set_delayed("spawn_roof_mid", 6);
  level.ally.ignoreall = 0;
  level.hvt thread function_552bc20d522ac241();
  function_1934dcff036cf6c(var_6dca195d237c93bd);
}

function function_e46b766028526ae8() {
  flag_wait("roof_spawn");
  function_3649512a462f8e82();
  level.hvt.var_b3054dce8cc525f2 = 1;
  level.hvt namespace_1170726b2799ea65::function_624150e2bc78e81f("Nolan");
  thread namespace_1170726b2799ea65::function_4576aecf9d0c4082(level.hvt);
}

function function_7ca87a5fedfb69fb() {
  self endon("stop_following_player");
  playerforward = anglesToForward(level.player.angles);
  vec = level.player.origin + playerforward * (110, 110, 1);
  var_55545c8361fd9335 = function_e24293736e639dcf("allies", vec, anglesToForward(level.player.angles), 0);
  var_55545c8361fd9335 linkTo(level.player, "tag_origin");
  goalnodes = getnodearray("node_ally_defend", "targetname");
  self.goalradius = 20;
  mindist = 20;

  while(true) {
    firstcheck = var_55545c8361fd9335.origin;
    wait 2;
    var_22be12f04f74f36b = var_55545c8361fd9335.origin;

    if(distance2dsquared(firstcheck, var_22be12f04f74f36b) < mindist * mindist) {
      continue;
    }

    nodes = getnodesinradiussorted(groundpos(var_55545c8361fd9335.origin), 60, 0, 130, "cover", 1);

    foreach(node in nodes) {
      if(!array_contains(goalnodes, node)) {
        nodes = array_remove(nodes, node);
      }
    }

    if(nodes.size == 0) {
      continue;
    }

    self setgoalnode(random(nodes));
  }
}

function function_da5a3f60e9b82a17() {
  flag_wait("hostage_enter_downed_state");
  stop_aiming();
  self.ignoreme = 0;
  self.ignoreall = 0;
  self.dontevershoot = 0;
}

function function_942964a647e35365() {
  self._blackboard.forcestrafe = 0;

  while(true) {
    time = randomintrange(0, 2);
    wait time;
    level.player waittill("bulletwhizby", shooter);
    self.favoriteenemy = shooter;
  }
}

function function_23674e32f28635c0(group) {
  self endon("death");
  minspeed = 0.8;
  maxspeed = 1.3;
  var_106e031c779cc672 = 1;
  end_target = (1512, 3812, 2172);

  if(self == level.hvt) {
    mygroup = array_remove(group, self);
  } else {
    mygroup = level.hvt;
  }

  while(!flag("move_riot_corner_up")) {
    wait 0.1;

    if(self == level.hvt) {
      farthest = getfarthest(self.origin, mygroup);
      farthestdist = distance2dsquared(farthest.origin, end_target);
      var_743bfdedfe3b9f47 = distance2dsquared(self.origin, end_target);

      if(farthestdist < var_743bfdedfe3b9f47) {
        var_106e031c779cc672 += 0.1;
      } else {
        var_106e031c779cc672 -= 0.1;
      }
    } else {
      var_968078e1393eabdd = distance2dsquared(level.hvt.origin, end_target);
      var_743bfdedfe3b9f47 = distance2dsquared(self.origin, end_target);

      if(var_968078e1393eabdd < var_743bfdedfe3b9f47) {
        var_106e031c779cc672 += 0.1;
      } else {
        var_106e031c779cc672 -= 0.1;
      }
    }

    scaler = clamp(var_106e031c779cc672, minspeed, maxspeed);
    self setmovespeedscale(scaler);
  }
}

function function_1934dcff036cf6c(var_6dca195d237c93bd) {
  thread function_221e4d0523379693();
  level.hvt waittill("done_flare_anim");
  wait 0.5;
  flag_set("move_hvt");
  wait 5;
  level.hvt waittill("goal");
  level.hvt.script_demeanor = "default";
  flag_wait("enemies_in_corner");
  flag_set("move_riot_corner_up");
  flag_wait("corner_rush_player");
  flag_clear("move_riot_corner_up");
  flag_set("move_riot_corner_back");
  wait 9;
  flag_clear("move_riot_corner_back");
  flag_set("move_riot_corner_up");
  var_6dca195d237c93bd = array_removedead_or_dying(var_6dca195d237c93bd);
  array_thread(var_6dca195d237c93bd, &function_be9f34bcb294eeda);
}

function function_be9f34bcb294eeda() {
  self endon("death");

  while(distance2dsquared(level.player.origin, level.hvt.origin) > 250000) {
    wait 0.1;
  }

  nodes = getnodearray("node_riot_end", "script_noteworthy");
  mynode = getclosest(self.origin, nodes);
  self setgoalnode(mynode);
}

function function_1cde281b112def5c() {
  self waittill("death");
  level.var_7cf64959ff09db1 -= 1;
}

function function_3379f0f09f1ac2d9() {
  level endon("spawn_enemies_corner");
  thread function_4e257994365fa73f("spawn_enemies_left", "spawn_enemies_left");
  flag_wait("spawn_enemies_left");
  enemies = function_90d3f7b0c040f569("enemy_left_rusher");

  foreach(enemy in enemies) {
    enemy.script_forcegoal = 1;
    enemy.goalradius = 200;
    enemy setgoalentity(level.player);
  }
}

function function_221e4d0523379693() {
  flag_wait("spawn_enemies_corner");
  enemies = function_90d3f7b0c040f569("enemy_roof_corner");
  level.var_6b42803ae7f2bf9b = 0;
  array_thread(enemies, &function_866d2da50ae0b939);

  while(level.var_6b42803ae7f2bf9b < enemies.size) {
    waitframe();
  }

  flag_set("enemies_in_corner");
  flag_wait("corner_rush_player");
  enemies = getaiarrayinradius((1560, 3756, 2168), 250, "axis");
  enemies = array_remove(enemies, level.hvt);

  foreach(enemy in enemies) {
    if(istrue(enemy.bhasriotshieldattached)) {
      enemies = array_remove(enemies, enemy);
    }
  }

  array_thread(enemies, &function_e149d6fbe870c388);
}

function function_e149d6fbe870c388() {
  self endon("death");
  wait 5;
  self setgoalentity(level.player);
  self.goalradius = 200;
  self function_710bd6843f902d50(level.player, 1);
  self getenemyinfo(level.player);
}

function function_613a172485df6f71() {
  thread function_4e257994365fa73f("spawn_roof_mid", "spawn_roof_mid");
  thread function_4e257994365fa73f("move_enemies_mid", "move_enemies_mid");
  thread function_3379f0f09f1ac2d9();
  flag_wait("spawn_roof_mid");
  enemies = function_90d3f7b0c040f569("enemy_roof_mid");
  array_thread(enemies, &function_f611cfbcca79846e);
}

function function_4d34c3c4bc62a89c() {
  thread function_2249a215ee1d3b21();
  thread function_4e257994365fa73f("spawn_enemies_corner", "spawn_enemies_corner");
  thread function_4e257994365fa73f("move_enemies_to_corner", "move_enemies_to_corner");
  thread function_4e257994365fa73f("move_snipers_to_corner", "move_snipers_to_corner");
  thread function_4e257994365fa73f("start_grenade_toss", "start_grenade_toss");
  flag_wait("spawn_enemies_corner");
  wait 1;
  enemies = getEntArray("enemy_roof_corner", "targetname");

  foreach(enemy in enemies) {
    enemy enableoffhandthrowback();
  }

  level.hvt enableoffhandthrowback();
  flag_wait("start_grenade_toss");
  thread function_2322deadc329411c();
  flag_set("corner_rush_player");
}

function function_2249a215ee1d3b21() {
  level endon("move_enemies_to_corner");
  flag_wait("player_sees_roof_vista");
  wait 25;
  flag_set("move_enemies_to_corner");
}

function function_58cad6fc6431108d() {
  level endon("game_ended");
  function_41916c7ce22f8f8b(0);
  node = getnode("node_hvt_surrender", "targetname");
  wait 1;
  self forceteleport(node.origin, node.angles);
  self notify("stop_going_to_node");
  stop_aiming();
  self.favoriteenemy = undefined;
  waitframe();
  node = getnode("node_hvt_surrender", "targetname");
  self setgoalnode(node);
  self.script_forcegoal = 1;
  self.goalradius = 10;
  self.allowstrafe = 0;
  self.maystumble = 0;
  self.allowpain = 0;
  self allowedstances("stand");
  flag_wait("player_on_stronghold_platform");

  while(!level.player point_in_fov(self.origin, undefined, 1) && !level.player point_in_fov(self getEye(), undefined, 1)) {
    wait 0.1;
  }

  self.helmethealth = 0;
  self.armorhealth = 0;
  self.armor_health = 0;
  self.allowdeath = 0;
  scripts\common\ai::stop_magic_bullet_shield();
  level endon("hostage_enter_downed_state");

  while(getaiarray("axis").size > 4) {
    wait 1;
  }

  while(!level.player point_in_fov(self.origin, undefined, 1) && !level.player point_in_fov(self getEye(), undefined, 1)) {
    wait 0.1;
  }

  self.health = 1;
  level.ally thread aim_at(self getEye(), 0, undefined, undefined);
  bullet_start = level.ally gettagorigin("tag_weapon_right");
  magicbullet(level.ally.weapon, bullet_start, self.origin + (0, 0, 50), level.ally);
  level.ally shoot(1, self);
  wait 0.2;
  self dodamage(1, level.ally.origin, level.ally);
}

function function_3434182d74435bdd() {
  wait 4;
  enemies = getaiarray("axis");

  if(isDefined(enemies) && enemies.size > 1) {
    foreach(enemy in enemies) {
      if(enemy == level.hvt) {
        continue;
      }

      if(istrue(self.bhasriotshieldattached)) {
        enemy.armorhealth = 0;
        enemy.armor_health = 0;
        continue;
      }

      enemy.goalradius = 200;
      enemy.attackeraccuracy = 1;
      enemy disable_long_death();
    }
  }

  flag_wait("hostage_enter_downed_state");
  enemies = getaiarray("axis");

  if(!isDefined(enemies)) {
    return;
  }

  array_thread(enemies, &function_5f25ca8564362b78);
}

function function_5f25ca8564362b78() {
  self endon("death");

  if(self == level.hvt) {
    return;
  }

  self.attackeraccuracy = 1;
  wait 5;

  while(function_e7c30095a6cdc3ef(self.origin) || function_e7c30095a6cdc3ef(self getEye())) {
    waitframe();
  }

  self.var_f543095c3ca1b743 = 1;
  self kill();
}

function function_2322deadc329411c() {
  structs = getStructArray("magic_grenade_corner", "targetname");

  foreach(struct in structs) {
    target = getStruct(struct.target, "targetname");
    vec = vectorNormalize(target.origin - struct.origin);
    nade = magicgrenademanual("smoke_grenade_mp", struct.origin, vec * (165, 165, 80), 0.8);
  }
}

function function_f611cfbcca79846e() {
  self endon("death");
  self endon("reached_path_end");

  if(isDefined(self.target)) {
    target = function_7a18da6e48b71c35(self.target);
    node = getnodesinradiussorted(target.origin, 64, 0, 64, "cover")[0];
  } else {
    node = self getnearestnode();
  }

  thread scripts\cp\spawning::go_to_node(node);
  self waittill("stop_going_to_node");

  if(isDefined(self.currentnode)) {
    node = self.currentnode;
    scripts\cp\spawning::go_to_node(node);
  }
}

function function_ee22bf6112c466a(volume) {
  self endon("death");
  target_struct = getStruct(self.target, "targetname");
  assertex(isDefined(target_struct), "AI needs target in goal volume");
  var_27cc00cc0f27e3b3 = undefined;
  volumes = getEntArray(volume, "script_noteworthy");

  foreach(volume in volumes) {
    if(volume istouchingpoint(target_struct.origin)) {
      var_27cc00cc0f27e3b3 = volume;
      break;
    }
  }

  assertex(isDefined(var_27cc00cc0f27e3b3), "AI target not in any goal volume");
  self setgoalvolumeauto(var_27cc00cc0f27e3b3);
  self.var_a9c343c8cc07e316 = 0;

  while(true) {
    if(!isDefined(var_27cc00cc0f27e3b3.target)) {
      return;
    }

    var_27cc00cc0f27e3b3 = getEnt(var_27cc00cc0f27e3b3.target, "targetname");

    if(!isDefined(var_27cc00cc0f27e3b3)) {
      return;
    }

    if(self.var_a9c343c8cc07e316 == 0) {
      self waittill("move_to_next_volume");
    }

    self.var_a9c343c8cc07e316 = 1;
    function_46459a3fc2c320a9(var_27cc00cc0f27e3b3);
    self setgoalvolumeauto(var_27cc00cc0f27e3b3);
  }
}

function function_46459a3fc2c320a9(volume) {
  self endon("move_to_next_volume");

  if(isDefined(volume.script_delay)) {
    wait volume.script_delay;
  }

  delay = randomfloatrange(0, 2.5);
  wait delay;
  self.var_a9c343c8cc07e316 = 0;
}

function function_4d3604112fa2a843() {
  while(!isDefined(level.ally)) {
    waitframe();
  }

  level.ally thread function_9f2ada961e09fb18();
  waitframe();

  if(!level.player function_17b1976d7ff3c657()) {
    level.ally function_2cced4f01c5054d8();
  } else {
    node = getnode("node_ally_rooftop_start", "targetname");
    level.ally forceteleport(node.origin, node.angles);
  }

  level.ally function_bc8fe51637066a89();
}

function function_2cced4f01c5054d8() {
  level endon("game_ended");
  self endon("death");
  animnode = getStruct("animnode_ally_rappel", "targetname");

  if(!isDefined(self.ascender)) {
    self.ascender = spawn_anim_model("ascender");
  }

  actors = [self, self.ascender];
  self.headmodel scriptmodelplayanim("jup_apt_roof_zipline_scene_price");
  animnode anim_single(actors, "zipline");

  if(!flag("move_price_to_roof")) {
    childthread function_fc2d07685032f053(animnode, actors);
    waitframe();
  }

  flag_wait("move_price_to_roof");
  namespace_b96fa4d8ce10f926::function_ebd9a9c9789d200f();
  function_e483413541e6f5cc();
  self.headmodel scriptmodelplayanim("jup_apt_roof_zipline_exit_price");
  animnode anim_single(actors, "zipline_exit");
  self.ascender linkTo(self, "tag_stowed_thigh");
  flag_set("ally_on_roof");
  thread function_6aedbebe764ec978(self.ascender);
}

function function_fc2d07685032f053(animnode, actors) {
  level endon("move_price_to_roof");

  while(true) {
    self.headmodel scriptmodelplayanim("jup_apt_roof_zipline_idle_price");
    animnode anim_single(actors, "zipline_idle");
  }
}

function function_c99b788d9420d70f() {
  setmusicstate("mx_apt_roof");
}

function function_6aedbebe764ec978(prop) {
  self waittill("goal");
  wait 1.5;

  while(level.player can_see_origin(prop.origin, 1)) {
    wait 0.1;
  }

  prop delete();
}

function function_e1d2c04c0d6f9f6a() {
  position = "thigh";
  weapon = getweaponforpos(position);

  if(isundefinedweapon(weapon)) {
    return;
  }

  self updateentitywithweapons();
}

function function_866d2da50ae0b939() {
  node = self getnearestnode();
  goalnode = getnode(node.target, "targetname");
  thread scripts\cp\spawning::go_to_node(goalnode);
  waittill_either("goal", "death");
  level.var_6b42803ae7f2bf9b++;
}

function function_9f2ada961e09fb18() {
  function_dc995a70ce74fcee();
  self visiblesolid();
  self setCanDamage(1);
  self.dontmeleeme = 1;
  self.ignoreall = 1;
  self.ignoreme = 0;
  self.dontevershoot = 0;
  self.goalradius = 300;
  clear_movement_speed();
  self.baseaccuracy = 0.75;
  self.accuracy = self.baseaccuracy;
  self setengagementmindist(256, 0);
  self setengagementmaxdist(768, 2048);
  self function_9215ce6fc83759b9(2048);
  self allowedstances("stand", "crouch", "prone");
  self function_9f82c74eb1b7caf9(1);
  scripts\common\ai::reset_gunpose();
  namespace_1170726b2799ea65::function_624150e2bc78e81f();
  flag_wait("ally_on_roof");
  stop_aiming();
  scripts\anim\shared::forceuseweapon(self.secondaryweapon, "primary");
}

function function_4da81b8c4294e109() {
  level endon("player_detected_on_roof");

  while(true) {
    wait 0.1;

    if(level.player.origin[2] < 1984) {
      continue;
    }

    if(level.player.origin[0] < 3060 || level.player.origin[1] > 1500) {
      flag_set("player_detected_on_roof");
      break;
    }
  }
}

function function_4bac628a9b66b610(node) {
  thread function_1cde281b112def5c();
  self endon("death");
  thread scripts\cp\spawning::go_to_node(node);

  while(true) {
    wait 5;
    self waittill("goal");
    level.var_f4bd83ae99600161++;
    flag_wait("move_hvt");
  }
}

function function_4ffc8a933982af80() {
  scripts\common\ai::magic_bullet_shield();
  struct = function_7a18da6e48b71c35("ally_move_end");
  var_51ad0fcefca9b380 = spawn_tag_origin();
  var_932b1a9d1ec479f8 = spawn_tag_origin(struct.origin, struct.angles);
  var_51ad0fcefca9b380 moveTo(var_932b1a9d1ec479f8.origin, 3);
  thread function_bc8fe51637066a89();
  level notify("end_ally_overwatch");
  level thread notify_delay("stop_ally_tele", 3.1);
  level endon("stop_ally_tele");

  while(true) {
    self forceteleport(var_51ad0fcefca9b380.origin, var_51ad0fcefca9b380.angles);
    waitframe();
  }
}

function function_bc8fe51637066a89() {
  node = getnode("node_ally_rooftop_start", "targetname");
  thread scripts\cp\spawning::go_to_node(node);
  flag_wait("kickoff_roof_combat");
  thread namespace_6e0c78e9663c0033::function_72f87f6619b5a684("color_movement_roof");
  flag_wait("hostage_downed");
  self notify("stop_color_movement");
}

function function_552bc20d522ac241() {
  flag_set("player_detected_on_roof");
  self.var_5323a94889eff1de = 1;
  node = getnode("hvt_retreat_path_start", "targetname");
  thread function_4bac628a9b66b610(node);
}

function function_e80e278e94394c39() {
  self endon("death");
  self.ignoreall = 1;
  self.allowstrafe = 1;

  if(istrue(self.bhasriotshieldattached)) {
    self.helmethealth = 100;
    self.armorhealth = 1250;
    self.armor_health = 1250;
    self.health = 540;
    self.maystumble = 0;
    self.ignoreme = 1;
    self.allowpain = 0;
    self.onlytakedamagefromplayer = 1;
    self.var_a4709d00b598b7bf = 1;
    self.shouldstumble = 0;
    flag_wait("player_detected_on_roof");
    self.ignoreall = 0;
    self.favoriteenemy = level.player;
    self.var_c833409fb72d15fb = 1;
    self.allowstrafe = 1;
    self._blackboard.forcestrafe = 1;
    wait 10;
    self.ignoreme = 0;
    self.allowpain = 1;
    self.maystumble = 1;
    flag_wait_or_timeout("player_on_stronghold_platform", 20);
    self.onlytakedamagefromplayer = 0;
    return;
  }

  scripts\cp\coop_stealth::run_common_functions(self, 1, 1, 60, 160000);
  self.var_a4709d00b598b7bf = 1;
  self.shouldstumble = 0;
  flag_wait("player_detected_on_roof");
  thread function_c99b788d9420d70f();
  function_b02660db23058beb();
}

function function_b02660db23058beb() {
  self setstealthstate("combat");
  self getenemyinfo(level.player);
  function_8f08378040f01528(1);
  self.ignoreall = 0;
}

function function_6c06956f5d720e53() {
  guys = getaiarray("axis");

  if(!isDefined(guys)) {
    return undefined;
  }

  if(isDefined(level.ally)) {
    guys = array_remove(guys, level.ally);
  }

  targetnames = ["", ""];

  while(true) {
    flag_wait("flag_roof_suspend_lower_floors");
    guys = array_removedead_or_dying(guys);

    foreach(guy in guys) {
      foreach(group in targetnames) {
        if(is_equal(guy.enemy_group, group)) {
          guy.ignoreall = 1;
          guy.ignoreme = 1;
        }
      }
    }

    flag_waitopen("flag_roof_suspend_lower_floors");
    guys = array_removedead_or_dying(guys);

    foreach(guy in guys) {
      foreach(group in targetnames) {
        if(is_equal(guy.enemy_group, group)) {
          guy.ignoreall = 0;
          guy.ignoreme = 0;
        }
      }
    }

    waitframe();
  }
}

function function_1a36b4303dafa62() {
  level endon("end_ally_overwatch");
  var_3796fe8cf560b672 = getStruct("ally_overwatch_loc", "targetname");
  contents = physics_createcontents(["physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_ainosight"]);
  var_a93fe0cfcd3db568 = undefined;
  flag_set("flag_dungeon_apt_overwatch_enabled");
  thread function_e4447c9494b98b9a();

  while(true) {
    wait 1;

    if(!flag("flag_dungeon_apt_overwatch_enabled")) {
      continue;
    }

    if(isDefined(var_a93fe0cfcd3db568)) {
      var_aaecca81af75003b = var_a93fe0cfcd3db568 + 4000;

      if(flag("flag_dungeon_apt_player_low_health")) {
        var_aaecca81af75003b = var_a93fe0cfcd3db568 + 3000;
      }

      if(gettime() < var_aaecca81af75003b) {
        continue;
      }
    }

    guys = getaiarray("axis");

    if(!isDefined(guys)) {
      continue;
    }

    guys = array_remove(guys, level.hvt);
    guys = array_remove(guys, level.ally);
    guys = array_removedead_or_dying(guys);
    guys = sortbydistance(guys, level.player.origin);
    shoot_target = undefined;
    var_57a6f36ed19b10a6 = 0;

    foreach(guy in guys) {
      castend = guy gettagorigin("j_head");
      castresult = physics_raycast(var_3796fe8cf560b672.origin, castend, contents, undefined, 0, "physicsquery_closest", 0);

      if(isDefined(castresult) && castresult.size > 0) {
        continue;
      }

      in_fov = within_fov(level.player getEye(), level.player getplayerangles(), castend, cos(60));

      if(!in_fov && !flag("flag_dungeon_apt_player_low_health")) {
        continue;
      }

      if(isDefined(self.heli)) {
        continue;
      }

      var_b3c44708dfcab166 = within_fov(level.player getEye(), level.player getplayerangles(), castend, cos(30));

      if(var_b3c44708dfcab166 && !flag("flag_dungeon_apt_player_low_health")) {
        continue;
      }

      if(!function_e7c30095a6cdc3ef(guy getEye()) && !flag("flag_dungeon_apt_player_low_health")) {
        continue;
      }

      shoot_target = guy;
      break;
    }

    if(isDefined(var_a93fe0cfcd3db568) && gettime() > var_a93fe0cfcd3db568 + 14000) {
      shoot_target = random(guys);
      var_57a6f36ed19b10a6 = 1;
    }

    if(!isDefined(shoot_target)) {
      continue;
    }

    shot_end = undefined;
    var_98ccb7441919420b = 0;
    var_e014aa33281c00d8 = 0.7;

    if(flag("flag_dungeon_apt_player_low_health")) {
      var_e014aa33281c00d8 = 0.9;
    }

    if(randomfloat(1) <= var_e014aa33281c00d8 && !var_57a6f36ed19b10a6) {
      var_98ccb7441919420b = 1;
      thread function_37bd1c32c1e3741b(shoot_target);
      shot_end = shoot_target gettagorigin("j_head");
    } else {
      shot_end = shoot_target gettagorigin("j_head") + (0, 0, 40);
    }

    level.ally shoot(1, shoot_target);

    line(level.ally gettagorigin("<dev string:x126>"), shot_end, (0.7, 0.7, 0.7), 1, 1, 30);

    if(istrue(var_98ccb7441919420b)) {
      shoot_target kill();
    }
  }
}

function function_581b69a0b787b8a5(guys) {
  guys = sortbydistance(guys, level.player.origin);

  foreach(guy in guys) {
    can_see = level.ally function_ca53f38b1eb70113(guy getEye(), 0, 4000);

    if(can_see) {
      return guy;
    }
  }

  return guys[0];
}

function function_e4447c9494b98b9a() {
  level.player endon("death");

  while(true) {
    wait 0.25;

    if(level.player.health < 75) {
      flag_set("flag_dungeon_apt_player_low_health");
      continue;
    }

    flag_clear("flag_dungeon_apt_player_low_health");
  }
}

function function_37bd1c32c1e3741b(var_662f372e4d310c25) {
  results = var_662f372e4d310c25 waittill_any_timeout_1(2, "death");

  if(is_equal(results, "timeout")) {
    return;
  }

  if(randomint(10) < 7) {
    return;
  }

  level notify("ally_overwatch_kill");
}

function function_e72ce7df711d6518() {
  level endon("player_detected_on_roof");
  animnode = function_7a18da6e48b71c35("speech_animnode");

  while(true) {
    animnode anim_single_solo(self, "speech");
  }
}

function function_3649512a462f8e82() {
  flag_wait("player_spawned_with_loadout");
  startpoint = undefined;
  spawn_loc = "spawner_nolan";
  var_cb4dfc3c8138f8aa = undefined;

  if(isDefined(level.start_point)) {
    switch (level.start_point) {
      case #"hash_7f5ae40133d322a1":
        startpoint = "capture_start_hvt";
        var_cb4dfc3c8138f8aa = 3;
        break;
      case #"hash_af6948406930fe37":
        spawn_loc = "hostage_attach_spawner";
        var_cb4dfc3c8138f8aa = 1;
        break;
      case #"hash_7c31479cf04292f":
      case #"hash_8b567e450ad3ae21":
        spawn_loc = "hostage_attach_spawner";
        var_cb4dfc3c8138f8aa = 2;
        break;
    }
  }

  setDvar(@ "hash_736a89b6b2ab6fdf", 0);
  level.hvt = spawnhostage(spawn_loc, var_cb4dfc3c8138f8aa, startpoint, &namespace_24fed8bd28d362b::function_150874ef396ff6e);
  level.hvt.var_9d4f1024957fde36 = 1;
  level.hvt.var_a8622ecf49acda6e = 1;
  level.hvt.var_c7b10080abf06d59 = 1;
  level.hvt.var_685390c6753c2cc7 = 0;
  level.hvt.var_282d867559c07771 = 0;
  level.hvt function_f33085177441ad08();
  thread function_aced833bb509e9c2();

  if(isDefined(var_cb4dfc3c8138f8aa) && (var_cb4dfc3c8138f8aa == 1 || var_cb4dfc3c8138f8aa == 2)) {
    return;
  }

  level.hvt.helmethealth = 100;
  level.hvt.wearing_armor = 1;
  level.hvt.var_7cea08b66b2ad878 = 3;
  level.hvt.armorhealth = 300;
  level.hvt.armor_health = 300;
  level.hvt.health = 1250;
  level.hvt.allowpain = 0;
  level.hvt.animname = "hvt";
  level.hvt.disablepistol = 1;
  level.hvt.shouldstumble = 0;
  level.hvt.dontmeleeme = 1;
  level.hvt.team = "axis";
  level.hvt disableexecutionvictim();
  level.hvt scripts\common\ai::magic_bullet_shield();

  if(isDefined(var_cb4dfc3c8138f8aa) && var_cb4dfc3c8138f8aa == 3) {
    level.hvt.ignoreall = 1;
    return;
  }

  if(level.player function_23abb4950e65038d()) {
    return;
  }

  level.hvt thread function_5e24e0fc7b89b3d2();
  level.hvt thread function_d495c93c8fe0757f();
  level.hvt thread function_c572440073a4a21e();
  level.hvt thread function_f28628d3d0e4571d();
}

function function_aced833bb509e9c2() {
  while(true) {
    level.player waittill("hostage_picked_up");
    thread namespace_78ef5a12a453ec66::function_63e6de435da0d83f();
    level.player waittill_either("hostage_drop_complete", "end_hostage_carry");
    thread namespace_78ef5a12a453ec66::function_55b61726e8e1f043();
  }
}

function function_f28628d3d0e4571d() {
  level.hvt waittill("damage");
  flag_set("player_first_damaged_hostage");
}

function function_c572440073a4a21e() {
  level thread function_f50e54cd38764747();
  level thread function_6d7f4d5af6e53436();
  flag_wait("player_detected_on_roof");
  function_7a23492540716bbe();
}

function function_7a23492540716bbe() {
  var_4e5e2e35fb485438 = function_a07a9c680ab79d90(level.hvt, level.player);
  var_b07d19d32a3e2618 = 0;

  switch (var_4e5e2e35fb485438) {
    case #"hash_232a3d188fcc5c69":
      var_b07d19d32a3e2618 = 2;
      break;
    case #"hash_8ff62271106f45ee":
      var_b07d19d32a3e2618 = 8;
      break;
    case #"hash_c9b3133a17a3b2d0":
      var_b07d19d32a3e2618 = 4;
      break;
    case #"hash_96815ce4f2a3dbc5":
      var_b07d19d32a3e2618 = 6;
      break;
    default:
      var_b07d19d32a3e2618 = 8;
      break;
  }

  anim_base = "speech_react_";

  if(flag("player_damaged_hostage")) {
    anim_base = "speech_pain_";
  }

  level.hvt function_e483413541e6f5cc();
  var_f274c46cd89843ac = anim_base + var_b07d19d32a3e2618;
  level.speech_animnode anim_single_solo(level.hvt, var_f274c46cd89843ac);
  level.hvt notify("done_wake_anim");
}

function function_f50e54cd38764747() {
  level endon("game_ended");
  level.player endon("disconnect");

  while(true) {
    msg = level.player waittill_any_return_2("weapon_fired", "grenade_fire");

    if(msg == "grenade_fire") {
      wait 2;
      break;
    }

    if(msg == "weapon_fired") {
      break;
    }
  }

  wait 0.1;
  flag_set("player_detected_on_roof");
}

function function_6d7f4d5af6e53436() {
  level.hvt waittill("damage");
  flag_set("player_damaged_hostage");
  flag_set("player_detected_on_roof");
}

function function_5e24e0fc7b89b3d2() {
  self waittill("done_wake_anim");
  self.headmodel scriptmodelplayanim("jup_apt_roof_flare_nolan");
  thread anim_single_solo(self, "hvt_flare");
  thread function_1c55cd9aec0038d1();
  wait 1.9;
  waitframe();
  exploder("flare_gun_exploder");
  wait 0.5;
  self notify("done_flare_anim");
  flag_set("start_flare_anim_vo");
  self.pushable = 0;
}

function function_1c55cd9aec0038d1() {
  var_5a48a415fd52badc = (3082, 3050, 1982);
  speed = 700;
  velocity = vectorNormalize(self.origin - (0, 220, 0) - var_5a48a415fd52badc) * speed;
  nade = magicgrenademanual("smoke_grenade_mp", var_5a48a415fd52badc, velocity, 1.9);
  wait 2;
  speed = 200;
  velocity = vectorNormalize(self.origin - (0, 220, 0) - var_5a48a415fd52badc) * speed;
  nade = magicgrenademanual("smoke_grenade_mp", var_5a48a415fd52badc, velocity, 2);
}

function move_flare(mover, start, end) {
  apex = 320;
  time = 8;
  var_1199ac114b8f00ef = 1 / time / 0.05;
  frac = 0;

  while(frac < 1) {
    mover.origin = math::get_point_on_parabola(start, end, apex, frac);
    mover function_a0a0258a46abac8b();
    frac += var_1199ac114b8f00ef;
    wait 0.05;
    thread draw_circle(mover.origin, 5, (0, 1, 0), 1, 1, 25);
  }

  wait 4;
  mover delete();
}

function function_a0a0258a46abac8b() {
  if(!isDefined(self.prev_origin)) {
    self.prev_origin = self.origin;
    self.roll = 0;
    return;
  }

  self.angles = vectortoangles(self.origin - self.prev_origin);
  self.prev_origin = self.origin;
}

function function_d495c93c8fe0757f() {
  level endon("player_detected_on_roof");
  self endon("death");
  level.speech_animnode = spawnStruct();
  level.speech_animnode.origin = (2984, 2412, 1856);
  level.speech_animnode.angles = (0, 170, 0);

  while(true) {
    self.headmodel scriptmodelplayanim("jup_apt_enemy_alarmed_01");
    level.speech_animnode anim_single_solo(self, "speech");
  }
}

function function_2c31d268382bedb0() {
  while(!isDefined(level.player)) {
    wait 1;
  }

  if(level.player function_23abb4950e65038d()) {
    return;
  }

  level.player skydive_setbasejumpingstatus(1);
  level.player skydive_setdeploymentstatus(1);
}

function function_d2739fda6774c074() {
  flag_wait("start_mission_flow");
  function_85c3c2ae5721b882();
  flag_set("attach_interact_used");
  flag_set("obj_reach_exfil_completed");
  flag_set("jup_hostage_use_disabled");
  level.player notify("force_hostage_drop");
  wait 0.01;
  function_8acd86898c8c6bd9();
  level.player setclientomnvar("ui_stop_armor_hint", 0);
}

function function_7771434df4ddcffb() {
  level endon("exfil_attach_used");
  level.player endon("death");

  while(level.player.origin[2] < 2500) {
    wait 1;
  }

  function_fa7c87f2585bd907(0);
}

function function_73af9109ffdaa2f() {
  thread namespace_78ef5a12a453ec66::function_c1aee80b88bad254();
  wait 2;
  flag_set("move_helo_1_troops");
  flag_set("move_helo_2_troops");
  var_9c6043b223bcc972 = function_4fdb11d7c971fcb1("heli_spawner_1", "vol_attach");
  var_9c6042b223bcc73f = function_4fdb11d7c971fcb1("heli_spawner_2", "vol_attach");
  thread namespace_78ef5a12a453ec66::function_d1b66b48341bf2ea(var_9c6043b223bcc972, var_9c6042b223bcc73f);

  foreach(rider in level.var_a423e6fbd31e09cf) {
    rider.grenadeammo = 0;
  }

  var_9c6043b223bcc972 ent_flag_wait("helo_ready_to_unload");
  var_9c6042b223bcc73f ent_flag_wait("helo_ready_to_unload");
  flag_set("helo_1_unload");
  flag_set("helo_2_unload");
  var_20d64ce87a2cee26 = getStruct("obj_exfil_struct", "targetname");
  thread flag_set_delayed("enemy_move_exfil", 30);

  while(distance2dsquared(level.player.origin, var_20d64ce87a2cee26.origin) > 2250000 && !flag("enemy_move_exfil")) {
    wait 1;
  }

  foreach(rider in level.var_a423e6fbd31e09cf) {
    rider cleargoalvolume();
  }
}

function function_73afa109ffdac62() {
  flag_set("helo_3_unload");
  flag_set("helo_4_unload");
  flag_set("move_helo_3_troops");
  flag_set("move_helo_4_troops");
  thread namespace_78ef5a12a453ec66::function_c1aee80b88bad254();
  wait 4;
  var_9c6043b223bcc972 = function_4fdb11d7c971fcb1("heli_spawner_3");
  thread namespace_78ef5a12a453ec66::function_8681483e6d3d3522(var_9c6043b223bcc972);
  wait 6;
  var_9c6042b223bcc73f = function_4fdb11d7c971fcb1("heli_spawner_4");
  thread namespace_78ef5a12a453ec66::function_573981212498b10b(var_9c6042b223bcc73f);
  var_9c6042b223bcc73f ent_flag_wait("helo_ready_to_unload");
  flag_set("second_helos_arrived");

  for(i = 0; i < 5; i++) {
    if(i == 0) {
      timer = 10;
      enemy_count = 10;
      array_notify(level.var_a423e6fbd31e09cf, "move_to_next_volume");
      level notify("vo_exfil_nik_update");
    } else if(i == 1) {
      timer = 10;
      enemy_count = 8;
      thread function_a25dee97c67c3660();
    } else if(i == 2) {
      timer = 30;
      enemy_count = 4;
      level notify("vo_exfil_nik_update");
    } else if(i == 3) {
      timer = 20;
      enemy_count = 3;
    } else if(i == 4) {
      timer = 10;
      enemy_count = 2;
      flag_set("spawn_next_helos");
      array_notify(level.var_a423e6fbd31e09cf, "move_to_next_volume");
    }

    flag_clear("timeout_enemy_movement");
    thread flag_set_delayed("timeout_enemy_movement", timer);

    while(level.var_a423e6fbd31e09cf.size > enemy_count && !flag("timeout_enemy_movement")) {
      wait 1;
    }
  }
}

function function_a25dee97c67c3660() {
  wait 5;

  for(i = 0; i < 3; i++) {
    if(i == 0) {
      area = (2164, 2488, 2064);
      startpos = (2132, 2516, 2064);
      endpos = (2224, 2438, 1902);
      enemies = getaiarrayinradius(area, 350, "axis");
      array_notify(enemies, "move_to_next_volume");
      wait 3;
      magicgrenademanual("smoke_grenade_mp", startpos, endpos - startpos, 1.5);
    } else if(i == 1) {
      endpos = (2248, 2028, 1892);
      array_notify(level.var_a423e6fbd31e09cf, "move_to_next_volume");
      magicgrenademanual("smoke_grenade_mp", endpos, (0, 0, 0), 3);
    } else {
      endpos = (2622, 2002, 1892);
      array_notify(level.var_a423e6fbd31e09cf, "move_to_next_volume");
      magicgrenademanual("smoke_grenade_mp", endpos, (0, 0, 0), 3.5);
    }

    wait 5;
  }
}

function function_73afb109ffdae95() {
  thread namespace_78ef5a12a453ec66::function_c1aee80b88bad254();
  flag_wait("spawn_next_helos");
  flag_set("helo_5_unload");
  flag_set("helo_6_unload");
  var_9c6043b223bcc972 = function_4fdb11d7c971fcb1("heli_spawner_5", "vol_defend_back");
  var_9c6042b223bcc73f = function_4fdb11d7c971fcb1("heli_spawner_6", "vol_defend_back");
  thread namespace_78ef5a12a453ec66::function_9e0d228709e80dbc(var_9c6043b223bcc972, var_9c6042b223bcc73f);
  thread function_32166d91cdac55a9();
  var_9c6043b223bcc972 ent_flag_wait("helo_ready_to_unload");
  var_9c6042b223bcc73f ent_flag_wait("helo_ready_to_unload");
  thread flag_set_delayed("final_helo_unloading", 2);
  wait 14;
  array_notify(level.var_a423e6fbd31e09cf, "move_to_next_volume");

  foreach(enemy in level.var_a423e6fbd31e09cf) {
    enemy.accuracy = 1;
    enemy getenemyinfo(level.player);
    enemy.favoriteenemy = level.player;
  }

  flag_set("player_can_exfil");
  wait 10;

  foreach(enemy in level.var_a423e6fbd31e09cf) {
    if(enemy.aitype == "sniper_t3_rus_pmc") {
      continue;
    }

    enemy cleargoalvolume();
    enemy.goalradius = 1200;
    enemy setgoalentity(level.ally);
  }
}

function function_32166d91cdac55a9() {
  snipers = [];
  weapon1 = makeweapon("iw9_sn_alpha50_mp");
  weapon2 = makeweapon("iw9_sn_limax_mp");
  weapon3 = makeweapon("iw9_sn_mromeo_mp");
  weapons = [weapon1, weapon2, weapon3];

  foreach(rider in level.var_a423e6fbd31e09cf) {
    if(rider.aitype == "sniper_t3_rus_pmc") {
      snipers[snipers.size] = rider;
    }
  }

  foreach(sniper in snipers) {
    weapon = random(weapons);
    weapons = array_remove(weapons, weapon);
    sniper giveweapon(weapon);
    sniper.bulletsinclip = weaponclipsize(weapon);
    sniper.primaryweapon = weapon;
    sniper shared::forceuseweapon(sniper.primaryweapon, "primary");
  }
}

function function_4009e57734ce9a74() {
  self waittill("death");
  level.var_a423e6fbd31e09cf = array_remove(level.var_a423e6fbd31e09cf, self);
}

function function_85c3c2ae5721b882() {
  var_d32d4cc246fbdfd2 = getStruct("exfil_interact", "targetname");
  var_d32d4cc246fbdfd2.origin -= (0, 0, 5);
  var_cffca1a9623f41d5 = var_d32d4cc246fbdfd2 create_interact(undefined, (0, 0, 5), 160, 280, &"CP_JUP_APT/ATTACH_HOSTAGE_INTERACT", undefined, "show", 1);
  var_cffca1a9623f41d5 thread function_97d531ebf16bc603(160, 280);
  var_cffca1a9623f41d5 thread function_ee3b4bc96104f79f();
  var_cffca1a9623f41d5 waittill("trigger");
  level.player.ability_invulnerable = 1;
  thread function_c0d4508823341e9c();
  thread namespace_78ef5a12a453ec66::function_8d21939fb067fc32();

  while(!istrue(level.player.var_859654e0445a36d9)) {
    waitframe();
  }

  var_cffca1a9623f41d5 delete();
}

function function_c0d4508823341e9c() {
  setmusicstate("mx_apt_exfil_end");
}

function function_ee3b4bc96104f79f() {
  self endon("trigger");
  self endon("death");

  while(!istrue(level.player.var_859654e0445a36d9)) {
    waitframe();
  }

  while(true) {
    level.player waittill("hostage_dropped");

    if(distance2dsquared(level.player.origin, self.origin) < 14400) {
      self notify("trigger");
      return;
    }

    level.player waittill("hostage_picked_up");
  }
}

function function_97d531ebf16bc603(userange, displayrange) {
  self endon("death");

  if(!istrue(level.player.var_859654e0445a36d9)) {
    self setuserange(1);
    self sethintdisplayrange(1);
    level.player waittill("hostage_picked_up");
    self setuserange(userange);
    self sethintdisplayrange(displayrange);
  }

  while(true) {
    level.player waittill("hostage_dropped");
    self setuserange(1);
    self sethintdisplayrange(1);
    level.player waittill("hostage_picked_up");
    self setuserange(userange);
    self sethintdisplayrange(displayrange);
  }
}

function function_70e338121570fa62() {
  flag_wait("start_mission_flow");
  function_2b818914b5b73308();
  flag_wait("player_can_exfil");
  flag_set("obj_defend_completed");
}

function function_2b818914b5b73308() {
  function_73afa109ffdac62();
  thread function_73afb109ffdae95();
}

function function_4fdb11d7c971fcb1(heli_name, volume) {
  if(!isDefined(volume)) {
    volume = "vol_defend";
  }

  [veh_spawner] = getStructArray(heli_name, "targetname");
  heli = function_e48fde1878d8a034(veh_spawner);

  foreach(rider in heli.riders) {
    rider.heli = heli;
    rider.script_moveoverride = 1;
    rider function_41916c7ce22f8f8b(0);
    rider thread function_ee22bf6112c466a(volume);
    level.var_a423e6fbd31e09cf[level.var_a423e6fbd31e09cf.size] = rider;
    rider thread function_4009e57734ce9a74();
  }

  return heli;
}

function function_108864e93cb7a192() {
  self endon("death");

  if(isDefined(self.heli)) {
    self.heli waittill("unloaded");
    level.var_768baef6b13e756f = array_add(level.var_768baef6b13e756f, self);
  }
}

function function_cce1ca1325cccbe4() {
  flag_wait("start_mission_flow");
  thread function_eb6132d438f1b694();
  flag_set("exfil_attach_enabled");
  function_18b813b169746a27();
  level.player.ability_invulnerable = 1;
  flag_set("obj_exfil_started");
  flag_set("exfil_attach_used");
  flag_clear("flag_dungeon_apt_overwatch_enabled");
  stopcinematicforall(1);
  noself_delaycall(0.1, &setdvar, @ "hash_d3ee5a6578fe61de", 1);
  namespace_9766820f5baa93fb::function_cd054d9ba5a62557(0);
  thread play_outro();
  var_5018a9a0d40ed758 = getanimlength(level.scr_anim["player_rig"]["skyhook_exfil"]) - 0.1;
  wait var_5018a9a0d40ed758;
  level thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(level.player, 1, 0.1);
  flag_set("flag_dungeon_outro_start");
  thread namespace_78ef5a12a453ec66::function_1f92d589b3ae4c01();
  function_fa7c87f2585bd907(1);
}

function function_eb6132d438f1b694() {
  enemies = getaiarray("axis");

  if(isDefined(enemies) && enemies.size > 0) {
    array_thread(enemies, &function_b8c1690e80c2d0b6);
  }

  flag_wait("exfil_attach_used");
  function_73af4109ffd9f30();
  enemies = getaiarray("axis");

  if(!isDefined(enemies) || enemies.size < 3) {
    var_d241f88ed97aea4c = function_90d3f7b0c040f569("defend_exfil_group_01");
    var_d241fb8ed97af0e5 = function_90d3f7b0c040f569("defend_exfil_group_02");
    return;
  }

  if(enemies.size < 5) {
    var_d241f88ed97aea4c = function_90d3f7b0c040f569("defend_exfil_group_01");
  }
}

function function_73af4109ffd9f30() {
  var_9c6043b223bcc972 = function_4fdb11d7c971fcb1("heli_spawner_7");
  var_9c6042b223bcc73f = function_4fdb11d7c971fcb1("heli_spawner_8");
}

function function_b8c1690e80c2d0b6() {
  self endon("death");

  if(!isDefined(self.ai_type)) {
    return;
  }

  if(string_starts_with(self.ai_type, "smg") || string_starts_with(self.ai_type, "sh")) {
    self waittill("goal");
    self.goalradius = 200;
    self setgoalentity(level.ally);
    return;
  }

  self notify("move_to_next_volume");
}

function function_18b813b169746a27() {
  var_d32d4cc246fbdfd2 = getStruct("exfil_interact", "targetname");
  var_d32d4cc246fbdfd2.origin -= (0, 0, 5);
  var_cffca1a9623f41d5 = var_d32d4cc246fbdfd2 create_interact(undefined, (0, 0, 5), 95, 220, &"CP_JUP_APT/ATTACH_PLAYER_INTERACT", undefined, "show", 1);
  var_cffca1a9623f41d5 waittill("trigger");
  level.player.ability_invulnerable = 1;
  level.player.health = level.player.maxhealth;
  level.player.allowdeath = 0;
  thread outro_music();
  thread namespace_78ef5a12a453ec66::function_515796d61b108c60();
  var_cffca1a9623f41d5 delete();
}

function outro_music() {
  stopmusicstate("mx_apt_exfil_end");
}

function function_ae3962e2f6bdd31c() {
  flag_wait("scriptables_ready");
  level.cargo_container = function_1c4d592029f2b0d3("cargo_container_model");
  level.cargo_container assign_animtree("cargo_container");
  anim_org = spawn("script_origin", level.cargo_container.origin);
  anim_org.angles = level.cargo_container.angles;
  level.var_4b3ac8f7b190b434 = getEntArray("cargo_container_clip", "targetname");

  foreach(var_9b62a2b1c6914e8f in level.var_4b3ac8f7b190b434) {
    var_9b62a2b1c6914e8f linkTo(level.cargo_container);
  }

  thread namespace_a637649c8cd4ff68::function_42491645cecc764();
  function_694383acc7e67115();

  while(true) {
    anim_org anim_single_solo(level.cargo_container, "container_swing");
  }
}

function function_694383acc7e67115() {
  var_e8293b7b49b38cee = getStruct("struct_container_enemy", "targetname");
  startstruct = getStruct("struct_container_start", "targetname");
  linkpos = var_e8293b7b49b38cee spawn_tag_origin();
  startpos = startstruct spawn_tag_origin();
  linkpos linkTo(level.cargo_container);
  startpos linkTo(level.cargo_container);
  thread container_enemy(linkpos, startpos);
}

function container_enemy(linkpos, startpos) {
  thread function_4e257994365fa73f("player_near_container", "player_near_container");
  flag_wait("player_near_container");

  while(level.player.origin[0] < startpos.origin[0]) {
    if(level.player.origin[2] < 1630 || distance2dsquared(level.player.origin, startpos.origin) > 22500) {
      flag_clear("player_near_container");
      thread container_enemy(linkpos, startpos);
      return;
    }

    waitframe();
  }

  var_c9a5b848375fc50b = spawn("script_model", (0, 0, 0));
  enemy = function_90d3f7b0c040f569("enemy_container")[0];
  enemy.animname = "container_enemy";
  enemy forceteleport(linkpos.origin, linkpos.angles);
  enemy linkTo(linkpos);
  level.container_enemy = enemy;
  enemy.accuracy = 1;
  aiment = function_e24293736e639dcf("allies");
  enemy.favoriteenemy = aiment;
  battlechatter_off("axis");
  level.player.ignoreme = 1;
  var_6c8c128aaa660f21 = [linkpos, startpos, aiment, var_c9a5b848375fc50b];
  enemy thread function_e99f57b1c1f78592(var_6c8c128aaa660f21);
  flag_set("start_container_scene");
  thread namespace_78ef5a12a453ec66::function_854485abe0254369(linkpos);
  enemy endon("death");
  enemy childthread function_f753cd78f92d59b2();
  enemy childthread function_aac017c6700580a4(var_c9a5b848375fc50b);
  enemy childthread function_aed20357db78f5d4(linkpos, startpos);
  time = 2.8;
  enemy endon("kill_container_enemy");
  enemy thread notify_delay("kill_container_enemy", time);
  wait 0.4;
  offsetx = 20;

  while(true) {
    enemy.var_4a2d425b77cdade9 = (linkpos.origin[0] - offsetx, linkpos.origin[1], linkpos.origin[2] - 30);
    aiment.origin = enemy.var_4a2d425b77cdade9;
    enemy shoot(1, enemy.var_4a2d425b77cdade9, 1, 1, 1);
    offsetx += 14;
    time = randomfloatrange(0.1, 0.14);
    wait time;
  }
}

function function_aac017c6700580a4(var_c9a5b848375fc50b) {
  self endon("kill_container_enemy");
  level.cargo_container setCanDamage(1);
  level.cargo_container.health = 100000;

  while(!isDefined(self.var_4a2d425b77cdade9)) {
    waitframe();
  }

  while(true) {
    level.cargo_container waittill("damage", damage, attacker, direction_vec, point);

    if(attacker == self) {
      magicbullet(self.weapon, point, self.var_4a2d425b77cdade9 + direction_vec * 100, self, var_c9a5b848375fc50b);
    }
  }
}

function function_e99f57b1c1f78592(ents) {
  self waittill("death");
  battlechatter_on("axis");
  array_call(ents, &delete);
  level.cargo_container setCanDamage(0);
  level.player.ignoreme = 0;
}

function function_f753cd78f92d59b2() {
  self waittill("kill_container_enemy");
  level.var_2ff99aabf1f7224d = 1;

  if(isalive(self)) {
    bulletstart = (4778, 791.5, 2526.5);
    magicbullet("iw9_dm_la700_mp", bulletstart, self getEye(), undefined, self);
    wait 0.2;
    self unlink();
    waitframe();
    self kill();
  }
}

function function_aed20357db78f5d4(linkpos, startpos) {
  self endon("kill_container_enemy");

  while(true) {
    waitframe();

    if(level.player.origin[0] > linkpos.origin[0] || level.player.origin[0] < startpos.origin[0]) {
      break;
    }
  }

  namespace_78ef5a12a453ec66::function_ae0a4a264baff88c(linkpos);
  waitframe();
  self notify("kill_container_enemy");
}

function function_e47c20d9c3bc83ac() {
  thread function_c9817186a61bbd70(1, 18);
  thread function_c9817186a61bbd70(19, 42);
  thread function_c9817186a61bbd70(43, 58);
}

function function_c9817186a61bbd70(start_id, var_1fab7d087f22206) {
  var_a03cce8f6c35929 = [];

  for(i = start_id; i <= var_1fab7d087f22206; i++) {
    var_a03cce8f6c35929[var_a03cce8f6c35929.size] = i;
  }

  var_a03cce8f6c35929 = array_randomize(var_a03cce8f6c35929);

  for(i = 0; i < var_a03cce8f6c35929.size; i++) {
    playmayhem("mayhem_tarp_" + var_a03cce8f6c35929[i]);
    wait 0.2;
  }
}

function function_30160e0f4ccb9aaf() {
  var_25e0e219a5f51b66 = function_7a18da6e48b71c35("skyhook_animnode");

  if(!isDefined(level.player_rig)) {
    level.player_rig = spawn_anim_model("player_rig");
    level.player_rig hide();
  }

  if(!isDefined(level.var_5e84860df880bbce)) {
    level.var_5e84860df880bbce = spawn_anim_model("3rd_person_player");
    guy_head = spawn("script_model", (0, 0, 0));
    guy_head setModel("head_c_jup_sp_hero_gaz_urban");
    guy_head linkTo(level.var_5e84860df880bbce, "j_spine4", (0, 0, 0), (0, 0, 0));
    level.var_5e84860df880bbce.headmodel = guy_head;
    level.var_5e84860df880bbce.weapon = level.var_5e84860df880bbce function_acc596689d609fdf();
    function_a88c360e19062b00(0);
  }

  if(!isDefined(level.infil_ally)) {
    level.infil_ally = spawn_anim_model("infil_ally");
    guy_head = spawn("script_model", (0, 0, 0));
    guy_head setModel("c_jup_head_hero_price_urban");
    guy_head linkTo(level.infil_ally, "j_spine4", (0, 0, 0), (0, 0, 0));
    level.infil_ally.headmodel = guy_head;
    level.infil_ally hide();
    level.var_2cd1144d4a670216 = spawn("script_model", (0, 0, 0));
    level.var_2cd1144d4a670216 setModel("offhand2h_tablet_static_v0_apt");
    level.var_2cd1144d4a670216 linkTo(level.infil_ally, "tag_accessory_right", (0, 0, 0), (0, 0, 0));
    level.var_2cd1144d4a670216 hide();
  }

  if(!isDefined(level.infil_drone)) {
    level.infil_drone = spawn_anim_model("infil_drone");
    level.infil_drone hide();
  }

  if(!isDefined(level.exfil_plane)) {
    level.exfil_plane = spawn_anim_model("exfil_plane");
    level.exfil_plane hide();
  }

  if(!isDefined(level.var_eef1785b1c5b627f)) {
    level.var_eef1785b1c5b627f = spawn_anim_model("hostage_cable");
    var_25e0e219a5f51b66 anim_first_frame_solo(level.var_eef1785b1c5b627f, "skyhook_hvt");
  }

  if(!isDefined(level.price_cable)) {
    level.price_cable = spawn_anim_model("price_cable");
    var_25e0e219a5f51b66 anim_first_frame_solo(level.price_cable, "skyhook_hvt");
  }

  if(!isDefined(level.player_cable)) {
    level.player_cable = spawn_anim_model("player_cable");
    var_25e0e219a5f51b66 anim_first_frame_solo(level.player_cable, "skyhook_hvt");
  }

  if(!isDefined(level.var_e5f0aa4a3e51ad3)) {
    level.var_e5f0aa4a3e51ad3 = spawn_anim_model("hostage_carabiner");
    level.var_e5f0aa4a3e51ad3 hide();
  }

  if(!isDefined(level.spool)) {
    level.spool = spawn_anim_model("spool");
    var_25e0e219a5f51b66 anim_first_frame_solo(level.spool, "skyhook_exfil");
  }

  if(!isDefined(level.var_133a64079b5e0c25)) {
    level.var_133a64079b5e0c25 = spawn_anim_model("blimp_tether");
    var_25e0e219a5f51b66 thread anim_single_solo(level.var_133a64079b5e0c25, "blimp_idle");
  }

  if(!isDefined(level.blimp)) {
    level.blimp = spawn_anim_model("blimp");
    var_25e0e219a5f51b66 thread anim_single_solo(level.blimp, "blimp_idle");
  }

  thread show_blimp();
}

function play_intro() {
  flag_wait("dungeon_load_finished");
  level.player scripts\cp_mp\utility\game_utility::function_20cb4a5f727abe6e(0);

  if(!scripts\cp\starts::is_first_start()) {
    thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(level.player, 0);
    flag_set("flag_dungeon_intro_complete");
    return;
  }

  level.player val::set("intro", "weapon", 0);
  level.player.var_f296f7e55b9e9150 = getdvarint(@ "hash_b38fcf293d1e91a8");
  level.player utility::hidehudenable();
  level.var_b0e47888802f28e4 = function_7a18da6e48b71c35("skyhook_animnode");

  if(should_play_intro()) {
    thread function_330eeeb728d01302();
    thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(level.player, 0, 0.2);
    level.player scripts\cp\cp_infilexfil::cp_infil_player_allow(0);
    function_910f5e78744aed7();

    if(!function_17b1976d7ff3c657()) {
      if(!isDefined(game["start_time"])) {
        game["start_time"] = gettime() / 1000;
      }
    }
  } else {
    thread function_44a6386c7ea5a634();
  }

  intro_end();
}

function function_44a6386c7ea5a634() {
  var_c08d12e198965082 = function_ddc29f856c9ea4b0();
  level.player setOrigin(var_c08d12e198965082.origin);
  level.player setplayerangles(var_c08d12e198965082.angles);
  wait 0.1;
}

function function_910f5e78744aed7() {
  level endon("intro_skipped");
  level childthread fade_to_black();
  level childthread function_84793a5349db498b();

  if(getdvarint(@ "hash_aeea8513e72cf4f3")) {
    function_910b7e78744267d();
    function_910b4e787441fe4();
  }

  function_910b5e787442217();
}

function function_32da4c3dd4dc10a9(var_53bfcf2dfb38a051) {
  if(flag("already_showed_chyron")) {
    return;
  }

  if(!istrue(var_53bfcf2dfb38a051)) {
    wait 6;
  }

  flag_set("already_showed_chyron");
  level notify("show_chyrons");
}

function fade_to_black() {
  level waittill("fade_to_black");
  thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(level.player, 1, 0.5);
  level waittill("fade_from_black");
  scripts\cp_mp\utility\game_utility::fadetoblackforplayer(level.player, 0, 0.5);
}

function function_84793a5349db498b() {
  level waittill("start_prestream_infil");
  enemies = getaiarray("axis");
  array_call(enemies, &function_af96f7c8819ae854, level.player, 2000);
  level waittill("start_prestream_infil");
  enemies = getaiarray("axis");
  array_call(enemies, &function_af96f7c8819ae854, level.player, 2000);
  level.var_9f5abd3d45d4aa74 function_af96f7c8819ae854(level.player, 2000);
  level.player function_bc667001f9dd3808(level.var_9f5abd3d45d4aa74.origin, 3);
  level waittill("stop_prestream_infil");
  level.player clearpredictedstreampos();
  level.player function_bab9acc2cf205a62();
}

function function_910b7e78744267d() {
  level endon("intro_skipped");
  thread function_19aeb30ca3bf7a64();
  level.infil_ally show();
  level.var_2cd1144d4a670216 show();
  level.var_b0e47888802f28e4 thread anim_single([level.blimp, level.var_133a64079b5e0c25], "blimp_infil");
  level.var_2e7ea89531d1a785 = function_6149b301ce19988b("est_shot_extra_start", undefined, undefined, 0.05);
  array_thread(level.var_2e7ea89531d1a785.ai_spawned, &function_555346b39468e84b);
  level notify("start_prestream_infil");
  level.var_1cd8f1e3b626982a = function_6149b301ce19988b("est_shot_extra", undefined, undefined, 0.05);
  actors = [level.infil_ally];
  level.var_78d1946ead5b188c = getStruct("player_infil_shot_1_animnode", "targetname");
  anime = "infil_shot_1";
  guys = function_7f304aa00881ec8b("infil_shot_1_soldier");
  level.var_9f5abd3d45d4aa74 = function_7f304aa00881ec8b("infil_shot_1_hvt")[0];
  var_6fc037bda72b5c36 = guys;

  foreach(guy in guys) {
    guy.ignoreall = 1;
  }

  level.var_9f5abd3d45d4aa74 setModel("body_c_jup_sp_villain_nolan_apt");
  level.var_9f5abd3d45d4aa74 function_f33085177441ad08();
  actors = array_combine(actors, guys);
  actors = array_add(actors, level.var_9f5abd3d45d4aa74);
  array_thread(var_6fc037bda72b5c36, &function_dc995a70ce74fcee);

  foreach(actor in var_6fc037bda72b5c36) {
    actor.var_40a1e4f45ab83320 = actor getanim(anime);
  }

  foreach(actor in var_6fc037bda72b5c36) {
    actor.headmodel scriptmodelplayanim(actor.var_40a1e4f45ab83320);
  }

  level.var_9f5abd3d45d4aa74.headmodel scriptmodelplayanim("jup_apt_intro_hvt");
  level.var_bb35882347c384b4 = actors;
  level notify("start_prestream_infil");
  level.player setclientomnvar("ui_killstreak_controls", 9);
  level.var_78d1946ead5b188c anim_single(actors, anime);
  array_thread(actors, &function_91da54e1e2dd71a0);
  level.player setclientomnvar("ui_killstreak_controls", 0);
}

function function_555346b39468e84b() {
  self endon("death");
  wait 4;
  function_91da54e1e2dd71a0();
}

function function_910b4e787441fe4() {
  level endon("intro_skipped");
  level notify("stop_prestream_infil");
  thread function_19aeb60ca3bf80fd();
  level.infil_drone show();
  anime = "infil_shot_2";
  flag_set("flag_infil_shot_2");
  setDvar(@ "hash_d3ee5a6578fe61de", "0");
  setDvar(@ "hash_b9ff37d084074df3", "1");
  playcinematicforall("cp_jup_apt_infil_tablet");
  level.var_78d1946ead5b188c = getStruct("ally_overwatch_animnode", "targetname");
  actors = [level.infil_ally, level.infil_drone];
  level.infil_ally.headmodel scriptmodelplayanim("jup_apt_intro_price_02");
  level.var_78d1946ead5b188c anim_single(actors, anime);
  stopcinematicforall(1);
  array_thread(level.var_1cd8f1e3b626982a.ai_spawned, &function_91da54e1e2dd71a0);
  level.infil_ally delete();
  level.infil_ally.headmodel delete();
}

function function_910b5e787442217() {
  level endon("intro_skipped");
  thread function_32da4c3dd4dc10a9();
  thread function_19aeb50ca3bf7eca();
  actors = [level.player_rig, level.var_5e84860df880bbce];
  level.var_78d1946ead5b188c = getStruct("player_infil_animnode", "targetname");
  anime = "infil_shot_3";
  flag_set("flag_infil_shot_3");
  thread function_ab29beccfe9bb49b();
  thread namespace_78ef5a12a453ec66::function_1db933d9a1fea0e7();
  level.var_78d1946ead5b188c link_player_to_rig(anime, "stand", 0, 0, 1);
  function_a88c360e19062b00(1);
  level.var_5e84860df880bbce.headmodel scriptmodelplayanim("jup_apt_infil_enter_vm");
  thread flag_set("intro_anim_started");
  level.var_78d1946ead5b188c anim_single(actors, anime);
  level.var_b0e47888802f28e4 thread anim_single([level.blimp, level.var_133a64079b5e0c25], "blimp_idle");
}

function intro_end() {
  level.player scripts\cp\globallogic::userskip_stop();

  if(!flag("intro_skipped")) {
    function_f5645b8efa89b327();
  }

  function_9a9f041d4b97cf90();
  thread function_ab29beccfe9bb49b();
  level.infil_drone hide();
  level.var_2cd1144d4a670216 hide();
  level.player val::reset_all("intro");
  level.player scripts\cp\cp_infilexfil::cp_infil_player_allow(1);
  function_860a5c1214190a7c();
  thread namespace_78ef5a12a453ec66::function_6c83d1f9b8824de2();
}

function function_f5645b8efa89b327() {
  if(isDefined(level.player_rig)) {
    level.player val::reset_all("player_rig");
    level.player_rig notify("unlink_player");
    level.player stopanimScripted();
  }

  level.player castshadows();
  level.player hidelegsandshadow();
  level.player unlink();
}

function function_330eeeb728d01302() {
  var_c08d12e198965082 = function_ddc29f856c9ea4b0();
  userskipped = level.player scripts\cp\globallogic::userskip_wait();

  if(!userskipped) {
    return;
  }

  flag_set("intro_skipped");
  thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(level.player, 1);
  delaythread(0.1, &scripts\cp_mp\utility\game_utility::fadetoblackforplayer, level.player, 0);
  level.player stopsounds();
  level.player stopxcam();
  level.infil_drone stopsounds();
  stopcinematicforall(1);
  level stop_dialogue(1, 1);
  level.player stop_dialogue(1, 1);

  if(isDefined(level.var_bb35882347c384b4)) {
    array_thread(level.var_bb35882347c384b4, &function_91da54e1e2dd71a0);
  }

  if(isDefined(level.var_2e7ea89531d1a785)) {
    array_thread(level.var_2e7ea89531d1a785.ai_spawned, &function_91da54e1e2dd71a0);
  }

  if(isDefined(level.var_1cd8f1e3b626982a)) {
    array_thread(level.var_1cd8f1e3b626982a.ai_spawned, &function_91da54e1e2dd71a0);
  }

  function_f5645b8efa89b327();
  level.player setOrigin(var_c08d12e198965082.origin);
  level.player setplayerangles(var_c08d12e198965082.angles);
  level.player setclientomnvar("ui_killstreak_controls", 0);
  thread function_4334270d07a014f2();
}

function function_ddc29f856c9ea4b0() {
  struct = spawnStruct();
  var_523a02f756c713a = spawn_anim_model("player_rig");
  animnode = getStruct("player_infil_animnode", "targetname");
  struct = spawnStruct();
  struct.origin = animnode.origin;
  struct.angles = animnode.angles;
  struct anim_last_frame_solo(var_523a02f756c713a, "infil_shot_3");
  struct.origin = var_523a02f756c713a.origin;
  struct.angles = var_523a02f756c713a.angles;
  var_523a02f756c713a delete();
  return struct;
}

function function_8acd86898c8c6bd9() {
  level.player_rig show();
  level.var_e5f0aa4a3e51ad3 show();
  actors = [level.player_rig, level.hvt, level.var_8b3e280380afbbd, level.var_eef1785b1c5b627f, level.price_cable, level.player_cable, level.var_e5f0aa4a3e51ad3, level.blimp, level.var_133a64079b5e0c25];
  anim_org = function_7a18da6e48b71c35("skyhook_animnode");
  anim_org anim_first_frame_solo(level.hvt, "skyhook_hvt");
  anim_org link_player_to_rig("skyhook_hvt", "stand", 1, 0.4, 0, 0, 0, 0, 0);
  level.hvt function_d947d0b7bffa015e(level.player, 1);
  level.var_8b3e280380afbbd show();
  level.var_8b3e280380afbbd.headmodel show();
  level.var_8b3e280380afbbd.headmodel scriptmodelplayanim("jup_apt_skyhook_hostage_01");
  anim_org anim_single(actors, "skyhook_hvt");
  anim_org unlink_player_from_rig(undefined, undefined, undefined, 1);
  level.player_rig hide();
  level.player.ability_invulnerable = undefined;
  thread namespace_78ef5a12a453ec66::function_f62c9a99dcc80e17();
  level.hvt function_e483413541e6f5cc();
  thread function_e4cf23a09dd51d60(anim_org);
  props = [level.var_eef1785b1c5b627f, level.var_e5f0aa4a3e51ad3];
  level.hvt thread function_f35fe3f392722a65(anim_org);
  thread function_fd2a7d250c8ec9c4(anim_org, props);
  anim_org thread anim_single([level.var_133a64079b5e0c25, level.blimp], "blimp_idle");
  function_b7771cc818b41864(level.player);
}

function function_f35fe3f392722a65(anim_org) {
  self endon("death");
  self endon("stop_attach_loop");

  while(true) {
    level.var_8b3e280380afbbd.headmodel scriptmodelplayanim("jup_apt_skyhook_hostage_idle");
    anim_org thread anim_single_solo(level.var_8b3e280380afbbd, "skyhook_hvt_idle");
    anim_org anim_single_solo(self, "skyhook_hvt_idle");
  }
}

function function_fd2a7d250c8ec9c4(anim_org, props) {
  level.hvt endon("stop_attach_loop");

  while(true) {
    anim_org anim_single(props, "skyhook_hvt_idle");
  }
}

function function_e4cf23a09dd51d60(anim_org) {
  pos = anim_org get_anim_position();
  org = pos["origin"];
  angles = pos["angles"];
  startorg = getstartorigin(org, angles, level.scr_anim[level.hvt.animname]["skyhook_hvt_idle"]);
  startang = getstartangles(org, angles, level.scr_anim[level.hvt.animname]["skyhook_hvt_idle"]);

  for(i = 0; i < 10; i++) {
    level.hvt[[anim.callbacks["TeleportEnt"]]](startorg, startang);
    wait 0.1;
  }
}

function function_7fc28b641bd8f6bd() {
  flag_wait("dungeon_load_finished");

  while(!isDefined(level.hvt)) {
    waitframe();
  }

  anim_org = function_7a18da6e48b71c35("skyhook_animnode");
  level.var_e5f0aa4a3e51ad3 show();
  anim_org anim_last_frame_solo(level.var_eef1785b1c5b627f, "skyhook_hvt");
  anim_org anim_last_frame_solo(level.price_cable, "skyhook_hvt");
  anim_org anim_last_frame_solo(level.player_cable, "skyhook_hvt");
  anim_org anim_last_frame_solo(level.var_e5f0aa4a3e51ad3, "skyhook_hvt");
  level.hvt.origin = anim_org.origin;
  level.hvt.angles = anim_org.angles;
  level.hvt visiblenotsolid();
  level.hvt endon("stop_attach_loop");

  while(true) {
    level.hvt.headmodel scriptmodelplayanim("jup_apt_skyhook_hostage_idle");
    anim_org anim_single_solo(level.hvt, "skyhook_hvt_idle");
  }
}

function play_outro() {
  flag_set("flag_lighting_exfil");
  flag_wait("dungeon_load_finished");
  anim_org = getStruct("skyhook_animnode", "targetname");
  level thread scripts\cp\cp_outofbounds::enableoobimmunity(level.player);
  level.player hidehudenable();
  level.exfil_plane show();
  actors = [level.var_5e84860df880bbce, level.exfil_plane, level.hvt, level.var_8b3e280380afbbd, level.var_eef1785b1c5b627f, level.ally, level.price_cable, level.var_e5f0aa4a3e51ad3, level.spool, level.blimp, level.var_133a64079b5e0c25];
  array_call(actors, &function_af96f7c8819ae854, level.player, 2500);
  level.ally removeriotshield();
  var_e1c977e656804c69 = spawn_anim_model("ally_shield");
  var_e1c977e656804c69.origin = level.ally gettagorigin("tag_weapon_left");
  var_e1c977e656804c69.angles = level.ally gettagangles("tag_weapon_left");
  var_e1c977e656804c69 linkTo(level.ally, "tag_weapon_left");
  anim_org anim_first_frame_solo(level.var_5e84860df880bbce, "skyhook_exfil");
  level.player_cable delete();
  player_cable = spawn("script_model", level.var_5e84860df880bbce gettagorigin("tag_accessory_left"));
  player_cable.angles = level.var_5e84860df880bbce gettagangles("tag_accessory_left");
  player_cable setModel("jup_ee_military_hook_cable_01");
  player_cable linkTo(level.var_5e84860df880bbce, "tag_accessory_left");
  player_carabiner = spawn("script_model", level.var_5e84860df880bbce gettagorigin("tag_accessory_right"));
  player_carabiner.angles = level.var_5e84860df880bbce gettagangles("tag_accessory_right");
  player_carabiner setModel("jup_ee_military_hook_carabiner_01");
  player_carabiner linkTo(level.var_5e84860df880bbce, "tag_accessory_right");
  anim_org link_player_to_rig("skyhook_exfil", "stand", 1, undefined, 1, 0, 0, 0, 0);
  level.player_rig hide();
  level.var_5e84860df880bbce show();
  level.var_5e84860df880bbce.headmodel hide();
  thread function_7b0e0a6476caf64e();
  thread function_6f1fa65447b57a9b(anim_org);
  level.hvt notify("stop_attach_loop");
  level.hvt function_e483413541e6f5cc();
  level.ally function_e483413541e6f5cc();
  anim_org anim_first_frame_solo(level.ally, "skyhook_exfil");
  anim_org anim_first_frame_solo(level.hvt, "skyhook_exfil");
  anim_org anim_first_frame_solo(level.var_8b3e280380afbbd, "skyhook_exfil");
  level.ally.headmodel scriptmodelplayanim("jup_apt_skyhook_price_02");
  level.var_8b3e280380afbbd.headmodel scriptmodelplayanim("jup_apt_skyhook_hostage_02");
  anim_org thread anim_single(actors, "skyhook_exfil");
  anim_org anim_single_solo(level.player_rig, "skyhook_exfil");
}

function function_7b0e0a6476caf64e() {
  targetorigin = level.ally gettagorigin("tag_weapon_left");
  targetangles = level.ally gettagangles("tag_weapon_left");
  var_42d423e36841d3f9 = function_e24293736e639dcf("allies", targetorigin, targetangles);
  var_42d423e36841d3f9 linkTo(level.ally, "tag_weapon_left");
  enemies = function_90d3f7b0c040f569("enemy_roof_exfil_anim");
  array_thread(enemies, &function_f611cfbcca79846e);
  allenemies = getaiarray("axis");

  foreach(enemy in allenemies) {
    enemy.favoriteenemy = var_42d423e36841d3f9;
    enemy.grenadeammo = 0;
  }

  level waittill("exfil_grenade_thrown");
  allenemies = getaiarray("axis");
  array_thread(allenemies, &function_6c6dd91c15b14737);
}

function function_6c6dd91c15b14737() {
  self endon("death");
  self.accuracy = 1;
  self.favoriteenemy = level.player;
  self getenemyinfo(level.player);
  self cleargoalvolume();
  self cleargoalentity();
  self setgoalentity(level.player);
}

function function_6f1fa65447b57a9b(animnode) {
  wait 4;
  startpos = (3086, 1894, 2156);
  endpos = (3388, 1974, 1926);
  vec = vectorNormalize(endpos - startpos);
  time = 3.6;
  magicgrenademanual("semtex_mp", startpos, vec * (500, 500, 0), time);
  level notify("exfil_grenade_thrown");
}

function function_fe981260113da576() {
  flag_wait_either("mid_1_kill_first_guys", "flag_apt_mid_1_complete");
  wait 1;

  while(true) {
    level waittill("player_killed_enemy", loc);

    if(flag("broke_stealth_earlier")) {
      continue;
    }

    closest_guy = function_a44c98e5ec0f3b0c(loc, 1);

    if(isDefined(closest_guy) && distance2d(closest_guy.origin, loc) < 400) {
      continue;
    }

    level notify("player_stealth_kill_callout");
    wait 15;
  }
}

function function_4467fca29549fcaa(var_a66a0bbe9ef0353, var_acba072b7e847a86, endon_string) {
  level endon(endon_string);
  flag_wait("broke_stealth_earlier");
  wait 1;
  enemies = function_c890afce78d098bb(var_a66a0bbe9ef0353);

  while(true) {
    enemies = array_removedead_or_dying(enemies);

    if(enemies.size == 0) {
      break;
    }

    wait 1;
  }

  flag_set(var_acba072b7e847a86);
}

function function_a07a9c680ab79d90(var_75327e74ace93a65, var_634b4b7aea5039c8) {
  tmporigin = (var_634b4b7aea5039c8.origin[0], var_634b4b7aea5039c8.origin[1], var_75327e74ace93a65.origin[2]);
  directionvector = vectorNormalize(var_75327e74ace93a65.origin - tmporigin);
  var_236e078486c73885 = vectordot(directionvector, anglesToForward(var_75327e74ace93a65 getplayerangles()));
  var_2388178486e384bf = vectordot(directionvector, anglestoright(var_75327e74ace93a65 getplayerangles()));

  if(var_236e078486c73885 >= 0.6) {
    return "behind";
  } else if(var_236e078486c73885 <= -0.6) {
    return "ahead";
  } else if(var_2388178486e384bf >= 0.6) {
    return "left";
  } else if(var_2388178486e384bf <= -0.6) {
    return "right";
  }

  iprintln("get_position_relative hit undefined dir, FB=" + var_236e078486c73885 + ", LR=" + var_2388178486e384bf);
  return undefined;
}