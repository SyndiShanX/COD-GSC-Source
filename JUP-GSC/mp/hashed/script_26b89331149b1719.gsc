/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_26b89331149b1719.gsc
*************************************************/

#using script_187e2c28364e465b;
#using script_1bf7efeac8beb6f7;
#using script_634deba174eb64f0;
#using script_7edf952f8921aa6b;
#using scripts\asm\shared\mp\utility;
#using scripts\common\anim;
#using scripts\common\scene;
#using scripts\common\utility;
#using scripts\common\vehicle_code;
#using scripts\common\vehicle_paths;
#using scripts\cp_mp\hostmigration;
#using scripts\cp_mp\killstreaks\airstrike;
#using scripts\cp_mp\killstreaks\hover_jet;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\cp_mp\utility\vision_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_tracking;
#using scripts\engine\utility;
#using scripts\mp\anim;
#using scripts\mp\flags;
#using scripts\mp\gametypes\br_circle;
#using scripts\mp\gametypes\wm_utility;
#using scripts\mp\maps\mp_jup_skydiving\mp_jup_skydiving;
#using scripts\mp\utility\player;
#using scripts\mp\utility\teams;
#namespace namespace_c913f3ca0a6eff19;

function init() {
  while(!isDefined(level.struct_class_names)) {
    waitframe();
  }

  level.scriptevents = [];
  level.scriptevents["zone_1"] = [];
  level.scriptevents["zone_2"] = [];
  level.scriptevents["zone_3"] = [];
  var_8063e641963cd522 = &namespace_e497616c605290a6::function_8063e641963cd522;
  var_1333ca6d92a05a4d = &function_321a91b3f17fe383;
  function_58adcd73bec6efe9("zone_2", "HoverShoot", var_8063e641963cd522, 1, "vtol_shoot_building", &function_ff1f98c5e18a5796);
  function_58adcd73bec6efe9("zone_1", "AttackStronghold", var_8063e641963cd522, 30, "heli_ash_1");
  function_58adcd73bec6efe9("zone_1", "AttackStronghold", var_8063e641963cd522, 40, "heli_ash_2");
  function_58adcd73bec6efe9("zone_1", "AttackStronghold", var_8063e641963cd522, 50, "heli_ash_3");
  function_58adcd73bec6efe9("zone_1", "AttackStronghold", var_8063e641963cd522, 60, "heli_ash_4");
  function_58adcd73bec6efe9("zone_1", "AttackStronghold", var_8063e641963cd522, 70, "heli_ash_5");
  function_58adcd73bec6efe9("zone_1", "AttackStronghold", var_8063e641963cd522, 80, "heli_ash_6");
  function_58adcd73bec6efe9("zone_1", "AttackStronghold", var_8063e641963cd522, 150, "heli_ash_1");
  function_58adcd73bec6efe9("zone_1", "AttackStronghold", var_8063e641963cd522, 110, "heli_ash_2");
  function_58adcd73bec6efe9("zone_1", "AttackStronghold", var_8063e641963cd522, 110, "heli_ash_3");
  function_58adcd73bec6efe9("zone_1", "AttackStronghold", var_8063e641963cd522, 120, "heli_ash_4");
  function_58adcd73bec6efe9("zone_1", "AttackStronghold", var_8063e641963cd522, 130, "heli_ash_5");
  function_58adcd73bec6efe9("zone_1", "AttackStronghold", var_8063e641963cd522, 140, "heli_ash_6");
  function_58adcd73bec6efe9("zone_1", "AttackStronghold", var_8063e641963cd522, 270, "heli_ash_1");
  function_58adcd73bec6efe9("zone_1", "AttackStronghold", var_8063e641963cd522, 180, "heli_ash_2");
  function_58adcd73bec6efe9("zone_1", "AttackStronghold", var_8063e641963cd522, 180, "heli_ash_3");
  function_58adcd73bec6efe9("zone_1", "AttackStronghold", var_8063e641963cd522, 190, "heli_ash_4");
  function_58adcd73bec6efe9("zone_1", "AttackStronghold", var_8063e641963cd522, 200, "heli_ash_5");
  function_58adcd73bec6efe9("zone_1", "AttackStronghold", var_8063e641963cd522, 210, "heli_ash_6");
  function_58adcd73bec6efe9("zone_2", "AttackStronghold", var_8063e641963cd522, 0, "heli_ash_2", undefined, "point_1_hacked");
  function_58adcd73bec6efe9("zone_2", "AttackStronghold", var_8063e641963cd522, 30, "heli_ash_5", undefined, "point_1_hacked");
  function_58adcd73bec6efe9("zone_2", "AttackStronghold", var_8063e641963cd522, 60, "heli_ash_6", undefined, "point_1_hacked");
  function_58adcd73bec6efe9("zone_2", "AttackStronghold", var_8063e641963cd522, 70, "heli_ash_2", undefined, "point_1_hacked");
  function_58adcd73bec6efe9("zone_2", "AttackStronghold", var_8063e641963cd522, 90, "heli_ash_5", undefined, "point_1_hacked");
  function_58adcd73bec6efe9("zone_2", "AttackStronghold", var_8063e641963cd522, 120, "heli_ash_6", undefined, "point_1_hacked");
  function_58adcd73bec6efe9("zone_2", "AttackStronghold", var_8063e641963cd522, 140, "heli_ash_2", undefined, "point_1_hacked");
  function_58adcd73bec6efe9("zone_2", "AttackStronghold", var_8063e641963cd522, 150, "heli_ash_5", undefined, "point_1_hacked");
  function_58adcd73bec6efe9("zone_2", "AttackStronghold", var_8063e641963cd522, 180, "heli_ash_6", undefined, "point_1_hacked");
  level thread function_b3f327a076ec28fc();
  level thread function_b5e7d60de059a277();
  level thread function_e54404c5c9aa0dd4();
  level thread function_42f79acc38370dcb();
  level thread function_6ae5fdf1da1acaa9();
  level thread function_9b0c3dea689f1dc6();
  level thread function_321a91b3f17fe383(1);
  level thread function_312b0d0639bdc36c();
  level thread function_3129b5cf1b77c634();
  level thread function_3a437a470ac2a95b();
  level thread function_e6759ff8a68a63aa();
  level thread function_6f43d06f28248c06();
  level.var_c9c970dce548c506 = &function_9f195261465f1ee0;

  level thread function_fad186e07908db0c();
}

function function_ff1f98c5e18a5796() {
  level endon("game_ended");
  level endon(self.zone + "_objective_end");
  level waittill("wheelson_spawn");
  wheelson = level.escortvehicles[0];
  var_4ae4ee9c1b93e9ef = getEnt(self.context, "script_noteworthy");

  if(!isDefined(var_4ae4ee9c1b93e9ef)) {
    assertmsg("<dev string:x1c>");
    return;
  }

  var_4ae4ee9c1b93e9ef thread function_80015dd551dd42e6();

  while(!ispointinvolume(wheelson.origin, var_4ae4ee9c1b93e9ef)) {
    waitframe();
  }
}

function function_d3312a706552d9ec() {
  level endon("game_ended");
  level endon(self.zone + "_objective_end");
  wheelson = level.escortvehicles[0];
  wheelson waittill("point_2_30_percent");
}

function function_8a26196c96dbf2bf() {
  level endon("game_ended");
  level endon(self.zone + "_objective_end");
  scripts\mp\flags::gameflagwait("wheelson_reach_hack_point_final");
}

function function_c40df3d5b1524ce6() {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("zone_1" + "_objective_start");
  wait 30;
  exploder("aa_fire");
  scripts\mp\flags::gameflagwait("zone_1" + "_objective_end");
  kill_exploder("aa_fire");
}

function function_b5e7d60de059a277() {
  level endon("game_ended");
  var_fb0e23b6defa23b8 = getEntArray("zone2_exploder_plantform", "script_noteworthy");
  var_f3ae99af644576c3 = getentitylessscriptablearray("zone2_exploder_plantform_cover", "script_noteworthy");
  var_21235afcc541ed4 = getEnt("zone1_platform_end", "script_noteworthy");
  var_27ab43987144eb21 = getStruct("exploder_glass", "script_noteworthy");
  reinforceglass = getentitylessscriptablearray("reinforce_glass", "script_noteworthy");
  var_8b95afe6a5b96d2b = getEnt("zone2_exploder_pground", "script_noteworthy");
  var_a46ab5e6047a41c6 = getEntArray("zone2_exploder_line", "script_noteworthy");
  var_d18450a91f2cd9de = getentitylessscriptablearray("ground_glasses", "script_noteworthy");
  var_a75e4d102f726a1c = getEntArray("roof_glass_clip", "script_noteworthy");
  var_c1e6c16e6f5b263f = getEntArray("exploderPlatform_clip", "script_noteworthy");
  var_f8f75cbe3510e8cf = getEnt("falled_platform_area", "script_noteworthy");
  var_b6eedaf432feb7e0 = getEnt("explodered_ai_clips", "script_noteworthy");
  var_a59c6ab999bbc5ec = getentitylessscriptablearray("zone1_exploder_node", "script_noteworthy");
  reinforceglass[0] setscriptablepartstate("base", "init");
  var_fb0e23b6defa23b8[0].moverdoesnotkill = 1;
  var_fb0e23b6defa23b8[0] function_7126c9ace48ce815(1);
  var_b6eedaf432feb7e0 moveTo(var_b6eedaf432feb7e0.origin + (0, 0, -2000), 0.1);

  foreach(ent_clip in var_c1e6c16e6f5b263f) {
    ent_clip.var_c71aed356442f468 = 1;
  }

  scripts\mp\flags::function_1240434f4201ac9d("zone_1" + "_objective_end");
  c4struct = getStruct("zone1_explode", "targetname");
  c4 = spawn("script_model", c4struct.origin);
  c4.angles = c4struct.angles;

  if(isDefined(level.var_2179c46fc54fd9ce)) {
    c4 setModel(level.var_2179c46fc54fd9ce);
  } else {
    c4 setModel("offhand_2h_c4_prop_cp");
  }

  c4 setscriptablepartstate("effects", "explode");
  playFX(getfx("explode_zone1"), c4struct.origin);
  c4 delete();
  scripts\mp\maps\mp_jup_skydiving\mp_jup_skydiving::function_ccd8a337aae472de(var_fb0e23b6defa23b8[0].origin, 300);
  playsoundatpos(c4struct.origin + (0, 0, 15), "jup_wm_bombsite_exp_trans");

  foreach(var_dea4aff71a1db7b6 in var_c1e6c16e6f5b263f) {
    var_dea4aff71a1db7b6 delete();
  }

  foreach(var_2fa40af5b408e3bc in var_a59c6ab999bbc5ec) {
    var_2fa40af5b408e3bc setscriptablepartstate("exploder", "explodered");
    earthquake(0.3, 2, var_2fa40af5b408e3bc.origin, 20000);
  }

  foreach(exploderplatform in var_fb0e23b6defa23b8) {
    exploderplatform function_7126c9ace48ce815(0);
    exploderplatform.moverdoesnotkill = 0;
    exploderplatform.animname = "zone1_heavy_lab_device";
    exploderplatform scripts\common\anim::setanimtree();
    exploderplatform thread scripts\common\anim::anim_single_solo(exploderplatform, "exploded");
    exploderplatform thread function_341cfecee6574068();
  }

  foreach(var_a0191e45fa8d2d51 in var_a46ab5e6047a41c6) {
    var_a0191e45fa8d2d51.animname = "zone1_heavy_lab_device_line";
    var_a0191e45fa8d2d51 scripts\common\anim::setanimtree();
    var_a0191e45fa8d2d51 thread scripts\common\anim::anim_single_solo(var_a0191e45fa8d2d51, "exploded");
  }

  foreach(cover in var_f3ae99af644576c3) {
    if(isDefined(cover)) {
      cover setscriptablepartstate("base", "dead");
    }
  }

  scripts\mp\anim::function_3c8f0102ea5254f3(90);
  earthquake(0.4, 1, reinforceglass[0].origin, 10000);
  reinforceglass[0] setscriptablepartstate("base", "exloder");
  spawnmayhem("reinforceGlass", "vfx_mayh_jup_military_lab_round_roof_glass", reinforceglass[0].origin, reinforceglass[0].angles + (0, -90, 0));

  foreach(var_326855ded5cbe907 in var_a75e4d102f726a1c) {
    var_326855ded5cbe907 delete();
  }

  scripts\mp\anim::function_3c8f0102ea5254f3(38);
  playFX(getfx("exploder_full_smoke"), (-11738, -24320, 3500));
  spawn_model("jup_military_heavy_lab_device_dmg", (-11738, -24320, 3420), (0, 103.599, 0));
  scripts\mp\maps\mp_jup_skydiving\mp_jup_skydiving::function_ccd8a337aae472de(var_8b95afe6a5b96d2b.origin, 200);

  foreach(var_b68fc41d081120a6 in var_d18450a91f2cd9de) {
    var_b68fc41d081120a6 setscriptablepartstate("exploder", "explodered");
  }

  earthquakeorigin = var_fb0e23b6defa23b8[0].origin;
  earthquake(0.4, 1, earthquakeorigin, 10000);
  playsoundatpos((-11787, -24161, 3503), "jup_skydiving_platform_crash_end");
  var_8b95afe6a5b96d2b delete();
  killmayhem("reinforceGlass");
  wait 1;

  if(isDefined(var_f8f75cbe3510e8cf)) {
    foreach(player in level.players) {
      if(player istouching(var_f8f75cbe3510e8cf)) {
        player dodamage(99999, player.origin, player, undefined, "MOD_CRUSH");
      }
    }
  }
}

function function_341cfecee6574068() {
  time = getanimlength(level.scr_anim["zone1_heavy_lab_device"]["exploded"]);
  wait time;
  self delete();
}

function function_42f79acc38370dcb() {
  level endon("game_ended");

  if(!istrue(level.enablezombie)) {
    return;
  }

  level waittill("wheelson_spawn");
  wheelson = level.escortvehicles[0];

  if(!isDefined(wheelson)) {
    return;
  }

  wheelson waittill("point_1_hacked");
  var_d67e307b57f08945 = getdvarint(@ "hash_d7d7cdd2388182d4", 4);
  level thread function_c44237c56a815fbb(var_d67e307b57f08945);
  scripts\mp\flags::gameflagwait("wheelson_reach_hack_point_final");
  var_28c869a533668b3b = getdvarint(@ "hash_d7d7d0d23881896d", 6);
  level thread function_c44237c56a815fbb(var_28c869a533668b3b);
  a_s_spawn_locs = getStructArray("rising_zombie_spawn_loc", "script_noteworthy");
  level thread function_8b9eaf383ec0ba92(a_s_spawn_locs);
}

function function_e54404c5c9aa0dd4() {
  scripts\mp\flags::gameflagwait("zone_2_objective_start");
  var_74a0334cc4be099c = getEntArray("scene_zombie_appear", "targetname");

  foreach(tank in var_74a0334cc4be099c) {
    vfxent = spawn("script_model", tank.origin);
    vfxent setModel("jup_skydiving_container_fog_vfx");
    vfxent.angles = tank.angles;
    vfxent function_3677f2be30fdd581("fx", "init");
    tank.var_e6847d26a9b0dcbd = vfxent;
    tank.moverdoesnotkill = 1;
    doors = getEntArray(tank.target, "targetname");

    foreach(door in doors) {
      door.moverdoesnotkill = 1;
    }
  }
}

function function_c44237c56a815fbb(var_9082bf5c41da807e) {
  var_a67026bbabab5ebd = getEntArray("scene_zombie_appear", "targetname");
  spawnstructs = getStructArray("spawn_zombie_appear", "targetname");
  var_f5d97c4677bfe8e7 = 0;
  var_6318b3a65a662e38 = array_randomize(var_a67026bbabab5ebd);

  foreach(animroot in var_6318b3a65a662e38) {
    if(istrue(animroot.played)) {
      continue;
    }

    doors = getEntArray(animroot.target, "targetname");

    foreach(door in doors) {
      switch (door.script_label) {
        case #"hash_c9b3133a17a3b2d0":
          animroot.leftdoor = door;
          break;
        case #"hash_96815ce4f2a3dbc5":
          animroot.rightdoor = door;
          break;
        default:
          break;
      }
    }

    delay = randomintrange(1, 5) / 10;
    wait delay;
    spawnstruct = getclosest(animroot.origin, spawnstructs);
    spawnorigin = spawnstruct.origin;
    ai_zombie = namespace_bc9acb05ff207ddd::function_4fa29d44e69039cb(spawnorigin, spawnstruct.angles);
    ai_zombie setentitysoundcontext("jup_map", "skydiving_zombie");
    animroot thread scene::play([animroot.leftdoor, animroot.rightdoor], undefined, "jup_scene_wm_skydiving_container_open");
    playFX(getfx("zombie_appear"), animroot.origin);
    animroot.var_e6847d26a9b0dcbd function_3677f2be30fdd581("fx", "open");
    var_f5d97c4677bfe8e7++;
    animroot.played = 1;

    if(var_f5d97c4677bfe8e7 >= var_9082bf5c41da807e) {
      break;
    }
  }
}

function function_6ae5fdf1da1acaa9() {
  level endon("game_ended");

  level thread function_4a0fe25e8ebcf95b();

  level.var_553ca70df436cdca = [];
  level.gastriggers = [];
  level.var_621bdf8262fcf3aa = [];

  for(i = 1; i <= 3; i++) {
    var_3366dabcf2ea89c0 = getStruct("zone_2_explosive_set_" + i, "script_noteworthy");
    var_6257de9bfc4eec4f = getStructArray(var_3366dabcf2ea89c0.target, "targetname");

    foreach(explosive in var_6257de9bfc4eec4f) {
      var_127839184b2a14ca = spawnscriptable("jup_skydiving_lab_explosive_device", explosive.origin, explosive.angles);
      var_127839184b2a14ca function_3677f2be30fdd581("body", "idle");

      if(!isDefined(level.var_621bdf8262fcf3aa[i])) {
        level.var_621bdf8262fcf3aa[i] = [];
      }

      level.var_621bdf8262fcf3aa[i][level.var_621bdf8262fcf3aa[i].size] = var_127839184b2a14ca;
    }

    level thread function_ae810591dcc1e7da(i);
  }

  scripts\mp\flags::gameflagwait("zone_2_objective_start");
  level waittill("wheelson_spawn");
  wheelson = level.escortvehicles[0];
  var_158ae1c93d9fcf79 = getStruct("zone_2_gas_leak_set_1", "script_noteworthy");
  var_f1997dcd52aed3b5 = var_158ae1c93d9fcf79;
  wheelson waittill("point_1_hacked");
  function_c7a87d3f663997c8();
  wait 5;
  level notify("part_1_leak");

  if(istrue(level.enablezombie)) {
    function_5d234a32697f91c(getfx("lab_gas_lobby_fog_zm"), var_158ae1c93d9fcf79.origin);
  } else {
    function_5d234a32697f91c(getfx("lab_gas_lobby_fog"), var_158ae1c93d9fcf79.origin);
  }

  function_97647a54bce1049(var_158ae1c93d9fcf79);
  damagetrigger = getEnt("zone_2_gas_leak_damage_1", "script_noteworthy");
  damagetrigger thread dogasdamage();
  level.gastriggers[level.gastriggers.size] = damagetrigger;

  if(istrue(level.enablezombie)) {
    level thread function_eb2cc55c45f5cdc2();
  } else {
    level thread function_cee76283767d69b3();
  }

  damagetrigger thread function_80015dd551dd42e6();

  var_158ae1c93d9fcf79 = getStruct("zone_2_gas_leak_set_2", "script_noteworthy");
  scripts\mp\flags::gameflagwait("wheelson_reach_hack_point_final");
  wait 5;
  level notify("part_2_leak");

  if(istrue(level.enablezombie)) {
    function_5d234a32697f91c(getfx("lab_gas_center_fog_zm"), var_f1997dcd52aed3b5.origin);
  } else {
    function_5d234a32697f91c(getfx("lab_gas_center_fog"), var_f1997dcd52aed3b5.origin);
  }

  function_97647a54bce1049(var_158ae1c93d9fcf79);
  damagetrigger = getEnt("zone_2_gas_leak_damage_2", "script_noteworthy");
  damagetrigger thread dogasdamage();
  level.gastriggers[level.gastriggers.size] = damagetrigger;

  damagetrigger thread function_80015dd551dd42e6();

  var_158ae1c93d9fcf79 = getStruct("zone_2_gas_leak_set_3", "script_noteworthy");
  wheelson waittill("point_2_hacked");
  wait 5;
  level notify("part_3_leak");
  function_97647a54bce1049(var_158ae1c93d9fcf79);
  level thread function_e3f7efc080d85d4(var_158ae1c93d9fcf79);
  wait 20;
  function_b3b73165b3662f0();
}

function function_4a0fe25e8ebcf95b() {
  level endon("<dev string:x36>");

  while(true) {
    if(!getdvarint(@ "hash_d28a3fe46caf4ac9", 0)) {
      wait 1;
      continue;
    }

    level thread namespace_d99736a82ac4e63b::radiation_start();
    level thread scripts\mp\maps\mp_jup_skydiving\mp_jup_skydiving::function_dce86aec5b302384();
    var_158ae1c93d9fcf79 = getStruct("<dev string:x44>", "<dev string:x5d>");
    var_f1997dcd52aed3b5 = var_158ae1c93d9fcf79;
    function_c7a87d3f663997c8();

    if(istrue(level.enablezombie)) {
      function_5d234a32697f91c(getfx("<dev string:x72>"), var_158ae1c93d9fcf79.origin);
    } else {
      function_5d234a32697f91c(getfx("<dev string:x8a>"), var_158ae1c93d9fcf79.origin);
    }

    function_97647a54bce1049(var_158ae1c93d9fcf79);
    var_158ae1c93d9fcf79 = getStruct("<dev string:x9f>", "<dev string:x5d>");

    if(istrue(level.enablezombie)) {
      function_5d234a32697f91c(getfx("<dev string:xb8>"), var_f1997dcd52aed3b5.origin);
    } else {
      function_5d234a32697f91c(getfx("<dev string:xd1>"), var_f1997dcd52aed3b5.origin);
    }

    function_97647a54bce1049(var_158ae1c93d9fcf79);
    var_158ae1c93d9fcf79 = getStruct("<dev string:xe7>", "<dev string:x5d>");
    function_97647a54bce1049(var_158ae1c93d9fcf79);
    level notify("<dev string:x100>");
    break;
  }
}

function function_80015dd551dd42e6() {
  level endon("<dev string:x36>");
  level endon("<dev string:x11f>");

  while(true) {
    drawtrigger(self);
    waitframe();
  }
}

function function_cee76283767d69b3() {
  level endon("game_ended");
  level endon("zone_2_cleaned_up");

  foreach(player in level.players) {
    player thread function_74fc473dc7badd16();
  }

  while(true) {
    level waittill("connected", player);
    player thread function_74fc473dc7badd16();
  }
}

function function_74fc473dc7badd16() {
  level endon("game_ended");
  level endon("zone_2_cleaned_up");
  self endon("disconnect");

  if(isbot(self)) {
    return;
  }

  while(true) {
    if(!scripts\mp\utility\player::isreallyalive(self)) {
      wait 0.1;
      continue;
    }

    self.ingas = 0;

    foreach(trigger in level.gastriggers) {
      if(ispointinvolume(self.origin, trigger) || istrue(self.var_d56882c72cf670e)) {
        self.ingas = 1;
        break;
      }
    }

    if(istrue(self.ingas)) {
      self playlocalsound("jup_skydiving_geiger_high");
      wait 1.5;
      continue;
    }

    wait 0.1;
  }
}

function function_eb2cc55c45f5cdc2() {
  level endon("game_ended");
  level thread function_d71ae09d6b82eed7();

  while(true) {
    foreach(player in level.players) {
      var_b1c5084dd307e31e = 1;

      foreach(trigger in level.gastriggers) {
        if(ispointinvolume(player.origin, trigger) && isalive(player) || istrue(player.isinradiation) || istrue(player.var_d56882c72cf670e)) {
          player function_7ff7466f14522ce3(1);
          var_b1c5084dd307e31e = 0;
          break;
        }
      }

      if(var_b1c5084dd307e31e) {
        player function_7ff7466f14522ce3(0);
      }
    }

    wait 0.5;
  }
}

function function_7ff7466f14522ce3(var_86af607e7299cc58) {
  player = self;

  if(!player isscriptable()) {
    return;
  }

  if(istrue(var_86af607e7299cc58)) {
    if(!istrue(player.ingas)) {
      player.ingas = 1;
      playfxontagforclients(getfx("vision_in_gas_zm"), player, "j_head", player);
      player scripts\cp_mp\utility\vision_utility::function_27a921508cb04613("mp_jup_skydiving_ob", 0.5);
    }

    return;
  }

  stopfxontagforclients(getfx("vision_in_gas_zm"), player, "j_head", player);

  if(istrue(player.ingas)) {
    player.ingas = 0;
    player scripts\cp_mp\utility\vision_utility::function_9a92ae402e209ecc("mp_jup_skydiving_ob", 0.5);
  }
}

function function_d71ae09d6b82eed7() {
  level waittill("game_ended");
  wait 2;

  foreach(player in level.players) {
    stopfxontagforclients(getfx("vision_in_gas_zm"), player, "j_head", player);
    player scripts\cp_mp\utility\vision_utility::function_9a92ae402e209ecc("mp_jup_skydiving_ob", 0.5);
  }
}

function function_c7a87d3f663997c8() {
  var_8fa8659de63ae044 = getStructArray("vista_gas_origin_lrg", "script_noteworthy");
  var_b6f5e4f9ed52bdf9 = getStructArray("vista_gas_origin_sml", "script_noteworthy");
  var_df7684bfe9d50917 = getStructArray("vista_gas_origin_med", "script_noteworthy");
  var_6ee5f017df7dcfed = getStruct("vista_gas_building_bottom", "script_noteworthy");
  var_ef34c593eb1a7d53 = getStruct("vista_gas_surrounding", "script_noteworthy");

  if(istrue(level.enablezombie)) {
    level thread function_ac66abf0340ea6fd(getfx("vista_gas_leak_1_zm"), var_8fa8659de63ae044);
    level thread function_ac66abf0340ea6fd(getfx("vista_gas_leak_2_zm"), var_b6f5e4f9ed52bdf9);
    level thread function_ac66abf0340ea6fd(getfx("vista_gas_leak_3_zm"), var_df7684bfe9d50917);
    function_5d234a32697f91c(getfx("vista_gas_leak_building_bottom_zm"), var_6ee5f017df7dcfed.origin, var_6ee5f017df7dcfed.angles);
    rand = randomfloatrange(1, 3);
    wait rand;
    playFX(getfx("vista_gas_surrounding_still_zm"), var_ef34c593eb1a7d53.origin);
  } else {
    level thread function_ac66abf0340ea6fd(getfx("vista_gas_leak_1"), var_8fa8659de63ae044);
    level thread function_ac66abf0340ea6fd(getfx("vista_gas_leak_2"), var_b6f5e4f9ed52bdf9);
    level thread function_ac66abf0340ea6fd(getfx("vista_gas_leak_3"), var_df7684bfe9d50917);
    function_5d234a32697f91c(getfx("vista_gas_leak_building_bottom"), var_6ee5f017df7dcfed.origin, var_6ee5f017df7dcfed.angles);
    rand = randomfloatrange(1, 3);
    wait rand;
    playFX(getfx("vista_gas_surrounding_still"), var_ef34c593eb1a7d53.origin);
  }

  level thread function_60952a0bb17f24ea(var_ef34c593eb1a7d53);
}

function function_ac66abf0340ea6fd(fxid, var_e8873fdddc6b637c) {
  level endon("game_ended");

  foreach(struct in var_e8873fdddc6b637c) {
    playFX(fxid, struct.origin);
    rand = randomfloatrange(1, 3);
    wait rand;
  }
}

function function_60952a0bb17f24ea(var_82a1ec83be1be850) {
  level endon("game_ended");
  level endon("zone_3_objective_end");
  level waittill("captureflag_device_deployed");

  if(istrue(level.enablezombie)) {
    fxent = function_5d234a32697f91c(getfx("vista_gas_surrounding_shrink_zm"), var_82a1ec83be1be850.origin, undefined, 1);
  } else {
    fxent = function_5d234a32697f91c(getfx("vista_gas_surrounding_shrink"), var_82a1ec83be1be850.origin, undefined, 1);
  }

  scripts\mp\flags::gameflagwait("zone_3" + "_objective_end");
  killfxontag(fxent.id, fxent, "tag_origin");
  fxent delete();
}

function function_5d234a32697f91c(fxid, origin, angles, var_c5d624014ccd8a06, var_c5610e6e486b6ca) {
  fxent = spawn("script_model", origin);
  fxent setModel("tag_origin");

  if(isDefined(angles)) {
    fxent.angles = angles;
  }

  playFXOnTag(fxid, fxent, "tag_origin");
  fxent.id = fxid;

  if(istrue(var_c5d624014ccd8a06)) {
    return fxent;
  }

  if(isDefined(var_c5610e6e486b6ca)) {
    if(!isDefined(level.var_553ca70df436cdca[var_c5610e6e486b6ca])) {
      level.var_553ca70df436cdca[var_c5610e6e486b6ca] = [];
    }

    level.var_553ca70df436cdca[var_c5610e6e486b6ca][level.var_553ca70df436cdca[var_c5610e6e486b6ca].size] = fxent;
    return;
  }

  if(!isDefined(level.var_553ca70df436cdca["batchKill"])) {
    level.var_553ca70df436cdca["batchKill"] = [];
  }

  level.var_553ca70df436cdca["batchKill"][level.var_553ca70df436cdca["batchKill"].size] = fxent;
}

function function_ae810591dcc1e7da(index) {
  level endon("game_ended");
  level waittill("part_" + index + "_leak");

  if(index != 3) {
    wait 1;
  } else {
    wait 5;
  }

  test = level.var_621bdf8262fcf3aa[index];

  foreach(explosion in level.var_621bdf8262fcf3aa[index]) {
    explosion thread function_953cde29fc23de7f(index);
    rand = randomfloatrange(0.5, 2);
    wait rand;
  }
}

function function_953cde29fc23de7f(index) {
  function_3677f2be30fdd581("body", "count_down");
  var_c7006107ccbc44f9 = spawn("script_model", self.origin);
  var_c7006107ccbc44f9 setModel("tag_origin");
  var_c7006107ccbc44f9 function_37ca9d374de9a848(4);
  var_c7006107ccbc44f9 delete();
  var_bfb9a018b9cce103 = anglesToForward(self.angles);
  playFX(getfx("lab_explosion"), self.origin, var_bfb9a018b9cce103);

  if(index == 3) {
    playsoundatpos(self.origin + var_bfb9a018b9cce103 * 5, "jup_skydiving_lab_explosive_dist");
  }

  function_3677f2be30fdd581("body", "exploded");
  playrumbleonposition("grenade_rumble", self.origin);
  earthquake(0.5, 2, self.origin, 512);
  explosionorigin = spawn("script_model", self.origin);
  explosionorigin setModel("tag_origin");
  explosionorigin.team = "team_hundred_ninety";
  explosionorigin radiusdamage(self.origin, 512, 200, 100, undefined, "MOD_EXPLOSIVE", "bomb_site_mp");
  explosionorigin delaycall(1, &delete);
}

function function_37ca9d374de9a848(var_1a7062ca13af0fb0) {
  level endon("game_ended");
  self endon("death");
  bomb = self;

  if(soundexists("breach_c4_plant_05")) {
    bomb playSound("breach_c4_plant_05");
  }

  var_8adaf4318d8a76e4 = int(var_1a7062ca13af0fb0);
  var_d8da94a475707d63 = var_1a7062ca13af0fb0 - var_8adaf4318d8a76e4;

  if(var_d8da94a475707d63 > 0) {
    wait var_d8da94a475707d63;
    var_1a7062ca13af0fb0 = var_8adaf4318d8a76e4;
  }

  ticktime = 0.5;
  starttime = gettime();
  endtime = starttime + var_1a7062ca13af0fb0 * 1000;
  now = starttime;

  while(now < endtime) {
    now = gettime();
    var_c301d652d9a73075 = endtime - now;

    if(var_c301d652d9a73075 <= 1000 && soundexists("breach_warning_beep_05")) {
      bomb playSound("breach_warning_beep_05");
      ticktime = 0.05;
    } else if(var_c301d652d9a73075 <= 2000 && soundexists("breach_warning_beep_04")) {
      bomb playSound("breach_warning_beep_04");
      ticktime = 0.25;
    } else if(var_c301d652d9a73075 <= 3000 && soundexists("breach_warning_beep_03")) {
      bomb playSound("breach_warning_beep_03");
      ticktime = 0.5;
    } else if(var_c301d652d9a73075 <= 4000 && soundexists("breach_warning_beep_02")) {
      bomb playSound("breach_warning_beep_02");
    } else if(soundexists("breach_warning_beep_01")) {
      bomb playSound("breach_warning_beep_01");
    }

    wait ticktime;
  }
}

function function_b3b73165b3662f0() {
  level thread function_1c9fe3045c4259dc();
  var_5fc131355e6499af = getStruct("explosion_final", "script_noteworthy");
  var_bfb9a018b9cce103 = anglesToForward(var_5fc131355e6499af.angles);

  if(istrue(level.enablezombie)) {
    playFX(getfx("lab_explosion_final_p"), var_5fc131355e6499af.origin, var_bfb9a018b9cce103);
    noself_delaycall(3, &playfx, getfx("lab_gas_final_p"), var_5fc131355e6499af.origin, var_bfb9a018b9cce103);
  } else {
    playFX(getfx("lab_explosion_final"), var_5fc131355e6499af.origin, var_bfb9a018b9cce103);
    noself_delaycall(3, &playfx, getfx("lab_gas_final"), var_5fc131355e6499af.origin, var_bfb9a018b9cce103);
  }

  playsoundatpos(var_5fc131355e6499af.origin + (0, 0, 15), "jup_skydiving_zone3_last_exp_trans");

  foreach(player in level.var_73b072a7ebe7cb17) {
    if(isDefined(player) && isalive(player)) {
      explosionorigin = spawn("script_model", player.origin);
      explosionorigin setModel("tag_origin");
      explosionorigin.team = "team_hundred_ninety";
      explosionorigin radiusdamage(player.origin, 1024, 500, 100, undefined, "MOD_EXPLOSIVE", "bomb_site_mp");
      explosionorigin delaycall(1, &delete);
    }
  }

  level notify("zone_2_cleaned_up");
}

function function_1c9fe3045c4259dc() {
  foreach(fxent in level.var_553ca70df436cdca["batchKill"]) {
    stopFXOnTag(fxent.id, fxent, "tag_origin");
    fxent delete();
  }
}

function function_97647a54bce1049(var_158ae1c93d9fcf79) {
  playsoundatpos(var_158ae1c93d9fcf79.origin + (0, 0, 15), "jup_skydiving_zone2_gas_leak_explosion");

  if(var_158ae1c93d9fcf79.script_noteworthy == "zone_2_gas_leak_set_1") {
    level thread function_1adb1683fc784f99();
  }

  var_ddcda8347e946f2b = getStructArray(var_158ae1c93d9fcf79.target, "targetname");

  foreach(var_7fa9a44c92bd806c in var_ddcda8347e946f2b) {
    if(istrue(level.enablezombie)) {
      if(isDefined(var_7fa9a44c92bd806c.script_noteworthy)) {
        if(var_7fa9a44c92bd806c.script_noteworthy == "exhaust_port_wall") {
          fxent = spawn("script_model", var_7fa9a44c92bd806c.origin);
          fxent setModel("tag_origin");
          fxent.angles = var_7fa9a44c92bd806c.angles;
          fxid = getfx("lab_gas_leak_wall_zm");
          playFXOnTag(fxid, fxent, "tag_origin");
          noself_delaycall(20, &stopfxontag, fxid, fxent, "tag_origin");
          fxent delaycall(21, &delete);
        } else if(var_7fa9a44c92bd806c.script_noteworthy == "exhaust_port_ceil") {
          fxent = spawn("script_model", var_7fa9a44c92bd806c.origin);
          fxent setModel("tag_origin");
          fxent.angles = var_7fa9a44c92bd806c.angles;
          fxid = getfx("lab_gas_leak_ceiling_zm");
          playFXOnTag(fxid, fxent, "tag_origin");
          noself_delaycall(20, &stopfxontag, fxid, fxent, "tag_origin");
          fxent delaycall(21, &delete);
        }
      } else if(var_158ae1c93d9fcf79.script_noteworthy == "zone_2_gas_leak_set_1") {
        function_5d234a32697f91c(getfx("lab_gas_leak_zm"), var_7fa9a44c92bd806c.origin, undefined, 0, "zone_2_set_1_pre_release");
      } else {
        function_5d234a32697f91c(getfx("lab_gas_leak_zm"), var_7fa9a44c92bd806c.origin);
      }

      continue;
    }

    if(isDefined(var_7fa9a44c92bd806c.script_noteworthy)) {
      if(var_7fa9a44c92bd806c.script_noteworthy == "exhaust_port_wall") {
        fxent = spawn("script_model", var_7fa9a44c92bd806c.origin);
        fxent setModel("tag_origin");
        fxent.angles = var_7fa9a44c92bd806c.angles;
        fxid = getfx("lab_gas_leak_wall");
        playFXOnTag(fxid, fxent, "tag_origin");
        noself_delaycall(20, &stopfxontag, fxid, fxent, "tag_origin");
        fxent delaycall(21, &delete);
      } else if(var_7fa9a44c92bd806c.script_noteworthy == "exhaust_port_ceil") {
        fxent = spawn("script_model", var_7fa9a44c92bd806c.origin);
        fxent setModel("tag_origin");
        fxent.angles = var_7fa9a44c92bd806c.angles;
        fxid = getfx("lab_gas_leak_ceiling");
        playFXOnTag(fxid, fxent, "tag_origin");
        noself_delaycall(20, &stopfxontag, fxid, fxent, "tag_origin");
        fxent delaycall(21, &delete);
      }

      continue;
    }

    if(var_158ae1c93d9fcf79.script_noteworthy == "zone_2_gas_leak_set_1") {
      function_5d234a32697f91c(getfx("lab_gas_leak"), var_7fa9a44c92bd806c.origin, undefined, 0, "zone_2_set_1_pre_release");
      continue;
    }

    function_5d234a32697f91c(getfx("lab_gas_leak"), var_7fa9a44c92bd806c.origin);
  }
}

function function_1adb1683fc784f99() {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("wheelson_reach_hack_point_final");
  wait 5;

  foreach(fxent in level.var_553ca70df436cdca["zone_2_set_1_pre_release"]) {
    stopFXOnTag(fxent.id, fxent, "tag_origin");
    fxent delete();
  }
}

function dogasdamage() {
  level endon("game_ended");
  level endon("zone_2" + "_objective_end");

  if(getdvarint(@ "hash_df60becbd4ddb5e0", 0)) {
    return;
  }

  self.var_eed8129f9ef8608a = getdvarint(@ "hash_eb9e984511286374", 5);
  thread function_787d977d35f4f7a1();

  while(true) {
    foreach(player in level.players) {
      if(!isDefined(player.var_6c0135e48bd01bc9)) {
        player.var_6c0135e48bd01bc9 = spawn("script_model", self.origin);
        player.var_6c0135e48bd01bc9.isplaying = 0;
      }

      if(ispointinvolume(player.origin, self) && isalive(player)) {
        player.var_6c0135e48bd01bc9 showonlytoplayer(player);
        player dodamage(self.var_eed8129f9ef8608a, player.origin, player, undefined, "MOD_TRIGGER_HURT", "danger_circle_br");

        if(!istrue(player.var_6c0135e48bd01bc9.isplaying)) {
          player.var_6c0135e48bd01bc9 playLoopSound("amb_skydiving_gas_inside_lp");
          player.var_6c0135e48bd01bc9.isplaying = 1;
        }

        if(randomint(100) < 60) {
          player thread scripts\mp\gametypes\br_circle::tryplaycoughaudio();
        }

        continue;
      }

      if(isDefined(player.var_6c0135e48bd01bc9)) {
        if(istrue(player.var_6c0135e48bd01bc9.isplaying)) {
          player.var_6c0135e48bd01bc9 stoploopsound();
          player playlocalsound("amb_skydiving_gas_inside_stop");
          player.var_6c0135e48bd01bc9.isplaying = 0;
        }
      }
    }

    wait 1;
  }
}

function function_787d977d35f4f7a1() {
  level endon("game_ended");

  while(true) {
    wait 1;
    self.var_eed8129f9ef8608a += 2.5;

    if(self.var_eed8129f9ef8608a >= 30) {
      self.var_eed8129f9ef8608a = 30;
      break;
    }
  }
}

function function_e3f7efc080d85d4(var_23a4823b6d362e71) {
  level endon("game_ended");
  level.var_73b072a7ebe7cb17 = level.players;
  var_eed8129f9ef8608a = 5;

  while(true) {
    foreach(player in level.var_73b072a7ebe7cb17) {
      if(!isDefined(player.var_6c0135e48bd01bc9)) {
        player.var_6c0135e48bd01bc9 = spawn("script_model", player.origin);
        player.var_6c0135e48bd01bc9.isplaying = 0;
      }

      if(isDefined(player) && isalive(player) && abs(player.origin[2] - var_23a4823b6d362e71.origin[2]) < 400) {
        player.var_6c0135e48bd01bc9 showonlytoplayer(player);
        player.var_d56882c72cf670e = 1;
        player dodamage(var_eed8129f9ef8608a, player.origin, player, undefined, "MOD_TRIGGER_HURT", "danger_circle_br");
        player thread scripts\mp\gametypes\br_circle::tryplaycoughaudio();

        if(istrue(player.var_d56882c72cf670e) && player.var_6c0135e48bd01bc9.isplaying == 0) {
          player.var_6c0135e48bd01bc9 playLoopSound("amb_skydiving_gas_inside_lp");
          player.var_6c0135e48bd01bc9.isplaying = 1;
        }

        continue;
      }

      player.var_d56882c72cf670e = 0;
      level.var_73b072a7ebe7cb17 = array_remove(level.var_73b072a7ebe7cb17, player);

      if(!istrue(player.var_d56882c72cf670e) && player.var_6c0135e48bd01bc9.isplaying == 1) {
        player.var_6c0135e48bd01bc9 stoploopsound();
        player playlocalsound("amb_skydiving_gas_inside_stop");
        player.var_6c0135e48bd01bc9.isplaying = 0;
      }
    }

    if(level.var_73b072a7ebe7cb17.size <= 0) {
      break;
    }

    if(var_eed8129f9ef8608a < 30) {
      var_eed8129f9ef8608a += 2.5;
    } else {
      var_eed8129f9ef8608a = 30;
    }

    wait 1;
  }
}

function function_9b0c3dea689f1dc6() {
  level endon("game_ended");
  level endon("zone_2" + "_objective_end");
  scripts\mp\flags::gameflaginit("wheelson_reach_hack_point", 0);
  var_23f505057acf114b = getEntArray("zone2_door", "targetname");
  scripts\mp\flags::gameflagwait("wheelson_reach_hack_point");

  foreach(door in var_23f505057acf114b) {
    door movez(-100, 3);
  }
}

function function_321a91b3f17fe383(preset) {
  level endon("game_ended");

  if(istrue(preset)) {
    var_7ffff8f7c3863920 = getStruct("hover_bomb_pos", "script_noteworthy");
    mappointinfo = [];
    mappointinfo[0] = spawnStruct();
    mappointinfo[0].location = var_7ffff8f7c3863920.origin;
    scripts\mp\flags::gameflagwait("wheelson_reach_hack_point_final");
    function_b2832d5706dc2749(mappointinfo, preset);
    return;
  }

  if(isDefined(self.context)) {
    var_629dbe300301189 = getStructArray(self.context, "script_noteworthy");

    foreach(i, var_7ffff8f7c3863920 in var_629dbe300301189) {
      mappointinfo = [];
      mappointinfo[0] = spawnStruct();
      mappointinfo[0].location = var_7ffff8f7c3863920.origin;
      function_b2832d5706dc2749(mappointinfo, preset);
      level waittill("hover_finish_bombing");

      if(i < var_629dbe300301189.size) {
        timeinterval = randomint(30);
        wait timeinterval;
      }
    }

    return;
  }

  var_629dbe300301189 = getStructArray("hover_bomb_pos_random", "script_noteworthy");
  var_7ffff8f7c3863920 = random(var_629dbe300301189);
  mappointinfo = [];
  mappointinfo[0] = spawnStruct();
  mappointinfo[0].location = var_7ffff8f7c3863920.origin;
  function_b2832d5706dc2749(mappointinfo, preset);
}

function function_b2832d5706dc2749(mappointinfo, preset) {
  attackers = scripts\mp\utility\teams::getteamdata(game["attackers"], "players");

  if(!isDefined(attackers)) {
    return;
  }

  fakeowner = attackers[0];
  level.streakglobals.streakbundles["hover_jet"].lifetime = 0;

  if(!isDefined(fakeowner)) {
    return;
  }

  streakinfo = createstreakinfo("hover_jet", fakeowner);
  fakeowner thread function_faf3d7108ac14849(fakeowner, streakinfo, mappointinfo, preset);
}

function function_faf3d7108ac14849(owner, streakinfo, mappointinfo, preset) {
  level endon("game_ended");
  heightent = scripts\cp_mp\utility\killstreak_utility::getkillstreakairstrikeheightent();
  planehalfdistance = 24000;
  planeflyspeed = 6500;
  planeflyheight = 3250;
  planehoverheight = 1000;
  heightoffset = (0, 0, 0);
  planebombexplodedistance = 1500;
  var_505331ad630bbc6b = 1;

  if(isDefined(heightent)) {
    planeflyheight = heightent.origin[2] + 750;
  }

  var_5ceb15b939485b52 = getdvarint(@ "hash_698613e6c8c52243", 0);
  planeflyheight += var_5ceb15b939485b52;

  maplocation = mappointinfo[0].location;
  direction = (-0.928751, -0.370704, 0);

  if(!istrue(preset)) {
    direction = scripts\cp_mp\killstreaks\airstrike::callstrike_findoptimaldirection(owner, maplocation, planeflyheight, planehalfdistance);
    planeflyheight = maplocation[2] + 750;
    heightent = undefined;
  }

  flightpath = scripts\cp_mp\killstreaks\airstrike::getflightpath(maplocation, direction, planehalfdistance, heightent, planeflyheight, planeflyspeed, planebombexplodedistance, streakinfo.streakname, var_505331ad630bbc6b);
  pathstart = flightpath["startPoint"];
  pathgoal = flightpath["endPoint"];
  bundle = level.streakglobals.streakbundles["hover_jet"];
  scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
  jet = scripts\cp_mp\vehicles\vehicle_tracking::_spawnhelicopter(undefined, pathstart, direction, "veh_hover_jet_mp_phys", "veh9_mil_air_halfa_mp");

  if(!isDefined(jet)) {
    return;
  }

  jetlifetime = bundle.lifetime;
  jet.speed = 250;
  jet.accel = 175;
  jet.health = bundle.maxhealth;
  jet.maxhealth = bundle.maxhealth;
  jet.currenthealth = bundle.maxhealth;
  jet.angles = vectortoangles(direction);
  jet.lifetime = jetlifetime;
  jet.team = owner.team;
  jet.owner = owner;
  jet.streakinfo = streakinfo;
  jet.streakname = streakinfo.streakname;
  jet.flaresreservecount = bundle.maxflares;
  jet.returngoal = maplocation;
  jet.flyheight = planeflyheight;
  jet.hoverheight = planehoverheight;
  jet.missiles = 6;
  jet.pers["team"] = jet.team;
  jet.bestgroundtarget = undefined;
  jet.bestairtarget = undefined;
  jet.flightdir = flightpath["directionAngles"];
  jet setmaxpitchroll(0, 90);
  jet vehicle_setspeed(jet.speed, jet.accel);
  jet sethoverparams(50, 100, 50);
  jet setturningability(0.05);
  jet setyawspeed(45, 25, 25, 0.5);
  jet setotherent(jet.owner);
  jet setCanDamage(1);
  jet setneargoalnotifydist(700);
  jet setvehicleteam(jet.team);
  jet function_247ad6a91f6a4ffe(1);
  jet vehicleshowonminimap(0);
  jet setscriptablepartstate("blinking_lights", "on", 0);
  jet setscriptablepartstate("thrusters", "active", 0);
  jet setscriptablepartstate("contrails", "on", 0);
  level notify("vtol_jet_arrived");
  jet.animname = streakinfo.streakname;
  jet.scenenode = spawn("script_model", jet.returngoal * (1, 1, 0) + (0, 0, planeflyheight));
  jet.scenenode.angles = jet.angles;
  jet.scenenode setModel("tag_origin");
  jet scripts\cp_mp\killstreaks\hover_jet::function_fbda9177c810ff24(maplocation);

  airstrikedebugon = getdvarint(@ "hash_920f0586653a26d4", 0);

  if(isDefined(airstrikedebugon) && airstrikedebugon) {
    jet thread scripts\cp_mp\killstreaks\airstrike::function_fc41f67ef33c00b0(pathstart, pathgoal, (1, 1, 1), 20);
    jet thread scripts\cp_mp\killstreaks\airstrike::function_aca0ec4cab6e6319(planeflyheight, pathgoal);
    sphere(jet.scenenode.origin, 100, (1, 0, 1), 0, 500);
  }

  jet scripts\cp_mp\killstreaks\hover_jet::hoverjet_playflyfx();
  var_c51de0af53e40876 = scripts\cp_mp\killstreaks\hover_jet::function_9f6c5e46080e47dc();
  var_9bc4a52a93594ddd = getanimlength(level.scr_anim[jet.animname][var_c51de0af53e40876]);
  var_2e44aa5689f2db63 = get_notetrack_time(level.scr_anim[jet.animname][var_c51de0af53e40876], "contrail_off");
  jet.scenenode thread scripts\common\anim::anim_single_solo(jet, var_c51de0af53e40876);
  jet thread scripts\cp_mp\killstreaks\hover_jet::hoverjet_delaysetscriptable(var_2e44aa5689f2db63, "contrails", "off");
  jet thread scripts\cp_mp\killstreaks\hover_jet::hoverjet_watchgameend();

  if(issharedfuncdefined("flares", "handleIncomingStinger")) {
    jet thread[[getsharedfunc("flares", "handleIncomingStinger")]](&scripts\cp_mp\killstreaks\hover_jet::hoverjet_handlemissiledetection);
  }

  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_9bc4a52a93594ddd - 13);

  level notify("<dev string:x137>");

  if(!isDefined(jet)) {
    return;
  }

  if(isDefined(jet.scenenode)) {
    jet.scenenode delete();
  }

  level notify("hover_finish_bombing");
  jet delete();
}

function function_6f43d06f28248c06() {
  level endon("game_ended");
  level.var_9e151dadd78097d1 = 3;
  scripts\mp\flags::gameflagwait("zone_3" + "_objective_start");
  level waittill("zone_3_almost_done");

  if(isDefined(level.flagbase)) {
    level.flagbase function_3677f2be30fdd581("model", "deploy");
  }

  scripts\mp\flags::gameflagwait("zone_3" + "_objective_end");

  if(isDefined(level.flagbase)) {
    level.flagbase function_3677f2be30fdd581("model", "blast");
  }

  level thread function_c328dbd7ef72093();
}

function function_c328dbd7ef72093() {
  wait level.var_9e151dadd78097d1 + 2;

  foreach(var_c229310c9f8adb7e in level.var_e0cfb5f49d017c0d.var_c229310c9f8adb7e) {
    foreach(var_5bcae1f7b1155cd5 in var_c229310c9f8adb7e.var_d09fb53f6323062b) {
      var_5bcae1f7b1155cd5 function_3677f2be30fdd581("bbox", "idle");
      var_5bcae1f7b1155cd5 delete();
    }
  }
}

function function_9f195261465f1ee0() {
  var_2e8ba51f803e9ecf = getStruct("elec_1", "targetname");
  var_2e8ba61f803ea102 = getStruct("elec_2", "targetname");
  var_2e8ba71f803ea335 = getStruct("elec_3", "targetname");
  var_2e8ba01f803e93d0 = getStruct("elec_4", "targetname");
  var_2e8ba11f803e9603 = getStruct("elec_5", "targetname");
  var_2e8ba21f803e9836 = getStruct("elec_6", "targetname");
  var_2e8ba31f803e9a69 = getStruct("elec_7", "targetname");
  var_2e8bac1f803eae34 = getStruct("elec_8", "targetname");
  var_2e8bad1f803eb067 = getStruct("elec_9", "targetname");
  playFX(getfx("pds_elec_1"), var_2e8ba51f803e9ecf.origin);
  wait 0.1;
  playFX(getfx("pds_elec_2"), var_2e8ba61f803ea102.origin);
  wait 0.1;
  playFX(getfx("pds_elec_3"), var_2e8ba71f803ea335.origin);
  wait 0.1;
  playFX(getfx("pds_elec_1"), var_2e8ba01f803e93d0.origin);
  wait 0.2;
  playFX(getfx("pds_elec_2"), var_2e8ba11f803e9603.origin);
  wait 0.1;
  playFX(getfx("pds_elec_3"), var_2e8ba21f803e9836.origin);
  wait 0.1;
  playFX(getfx("pds_elec_1"), var_2e8ba31f803e9a69.origin);
  wait 0.1;
  playFX(getfx("pds_elec_2"), var_2e8bac1f803eae34.origin);
  wait 0.1;
  playFX(getfx("pds_elec_3"), var_2e8bad1f803eb067.origin);
  wait 0.1;
  level.flagbase function_3677f2be30fdd581("model", "green");
}

function function_e6759ff8a68a63aa() {
  level endon("game_ended");

  if(!istrue(level.enablezombie)) {
    return;
  }

  scripts\mp\flags::gameflagwait("zone_3" + "_objective_start");
  wait 20;
  level thread function_93ae7e902ff70798();
}

function function_93ae7e902ff70798() {
  level endon("game_ended");
  level endon("zone_3" + "_objective_end");
  a_s_spawn_locs = getStructArray("rising_zombie_spawn_loc", "script_noteworthy");

  while(true) {
    a_s_spawn_locs = array_randomize(a_s_spawn_locs);
    level thread function_8b9eaf383ec0ba92(a_s_spawn_locs);
    wait 30;
  }
}

function function_8b9eaf383ec0ba92(a_s_spawn_locs, str_speed) {
  level endon("game_ended");
  level endon("wm_stop_zombie_spawn");

  foreach(loc in a_s_spawn_locs) {
    a_ai_zombies = getaiarray("team_two_hundred");

    if(a_ai_zombies.size < 15) {
      agent = namespace_bc9acb05ff207ddd::function_4fa29d44e69039cb(loc.origin, loc.angles);
      agent setentitysoundcontext("jup_map", "skydiving_zombie");

      if(isDefined(agent) && agent function_8fa69650e33c84ef("spawn")) {
        agent thread scripts\asm\shared\mp\utility::animscriptedagent("spawn", "spawn_end", undefined, undefined, "spawn_animating");
      }

      if(!isDefined(str_speed)) {
        str_speed = "walk";
      }

      agent namespace_dd16d65e824b8e9::function_f1e5805da192a1ef(str_speed, "default", 26);
    } else {
      return;
    }

    waitframe();
  }
}

function function_312b0d0639bdc36c() {
  level endon("game_ended");
  var_6ccd0224a825f53a = getentitylessscriptablearray("hack_console", "script_noteworthy");

  if(isDefined(level.zone.objective.params["hackObjective"]["openRoofTime"])) {
    openrooftime = level.zone.objective.params["hackObjective"]["openRoofTime"];
  } else {
    openrooftime = 20;
  }

  foreach(var_9836f033f80bfad in var_6ccd0224a825f53a) {
    var_9836f033f80bfad setscriptablepartstate("base", "init");
  }

  level waittill("hack_zone_upload_complete");

  foreach(var_9836f033f80bfad in var_6ccd0224a825f53a) {
    var_9836f033f80bfad setscriptablepartstate("base", "half_opening");
  }

  wait openrooftime;

  foreach(var_9836f033f80bfad in var_6ccd0224a825f53a) {
    var_9836f033f80bfad setscriptablepartstate("base", "half_opened");
  }

  level waittill("hack_zone_upload_full_complete");

  foreach(var_9836f033f80bfad in var_6ccd0224a825f53a) {
    var_9836f033f80bfad setscriptablepartstate("base", "full_opening");
  }

  wait openrooftime;

  foreach(var_9836f033f80bfad in var_6ccd0224a825f53a) {
    var_9836f033f80bfad setscriptablepartstate("base", "full_opened");
  }
}

function function_3129b5cf1b77c634() {
  level endon("game_ended");
  level endon("zone_2" + "_objective_end");
  level waittill("wheelson_spawn", vehicle);

  while(true) {
    if(level.zone.currentphase == "wheelson_capture") {
      vehicle setscriptablepartstate("wm_light", "hacking");
    } else if(vehicle.var_95f2a51e7b487eb2.size == 0 && vehicle.nearbydefenders.size == 0 && !istrue(vehicle.var_5b67ad6d3409a341)) {
      vehicle setscriptablepartstate("wm_light", "stop");
    } else if(vehicle.veh_pathdir == "forward" && !istrue(vehicle.var_5b67ad6d3409a341) && vehicle.nearbydefenders.size == 0) {
      vehicle setscriptablepartstate("wm_light", "forward");
    } else if(vehicle.veh_pathdir == "reverse" || istrue(vehicle.var_5b67ad6d3409a341)) {
      vehicle setscriptablepartstate("wm_light", "reverse");
    } else if(istrue(vehicle.contested)) {
      vehicle setscriptablepartstate("wm_light", "reverse");
    }

    waitframe();
  }
}

function function_909f84add526f679(screenindex) {
  assert(screenindex > 0);
  level endon("game_ended");
  var_f7fe886611767acc = getentitylessscriptablearray("control_terminal", "script_noteworthy");

  foreach(var_e1e2ffc7cc31c677 in var_f7fe886611767acc) {
    if(var_e1e2ffc7cc31c677.targetname == "check_point_" + screenindex) {
      var_e1e2ffc7cc31c677 setscriptablepartstate("base", "hacking");
      setomnvar("ui_wm_launch_console_screen_" + 1, 3);
      var_e1e2ffc7cc31c677 setscriptablepartstate("ui", "hacking");
    }
  }

  while(true) {
    if(scripts\mp\flags::gameflag("point_" + screenindex + "_hacked")) {
      break;
    }

    objective = level.zone.var_3abf844425ac7c00.capture_zones[screenindex - 1];
    progress = objective.curprogress / objective.usetime;
    setomnvar("ui_wm_launch_console_hack_" + 1, progress);
    waitframe();
  }

  setomnvar("ui_wm_launch_console_hack_" + 1, 1);
  wait 1;

  foreach(var_e1e2ffc7cc31c677 in var_f7fe886611767acc) {
    if(screenindex == 1) {
      if(var_e1e2ffc7cc31c677.targetname == "check_point_" + screenindex) {
        var_e1e2ffc7cc31c677 setscriptablepartstate("base", "hacked_" + screenindex);
        setomnvar("ui_wm_launch_console_screen_" + 1, 4);
      } else {
        var_e1e2ffc7cc31c677 setscriptablepartstate("base", "half_hacked");
      }

      continue;
    }

    var_e1e2ffc7cc31c677 setscriptablepartstate("base", "hacked_" + screenindex);
    setomnvar("ui_wm_launch_console_screen_" + 1, 4);
  }
}

function function_3a437a470ac2a95b() {
  level endon("game_ended");
  level waittill("wheelson_spawn", vehicle);
  var_f2dd3805ad08de24 = getentitylessscriptablearray("hack_monito_1", "script_noteworthy");
  var_f2dd3b05ad08e4bd = getentitylessscriptablearray("hack_monito_2", "script_noteworthy");
  scripts\mp\flags::gameflagwait("wheelson_reach_hack_point");
  level thread function_909f84add526f679(1);
  wait 1.5;

  foreach(var_4f4fbf5aa68dae8a in var_f2dd3805ad08de24) {
    if(isDefined(var_4f4fbf5aa68dae8a.targetname) && var_4f4fbf5aa68dae8a.targetname == "1" && var_4f4fbf5aa68dae8a function_35c178c80fa19cbd("base", "dead") == 0) {
      var_4f4fbf5aa68dae8a setscriptablepartstate("base", "hacking");
    }
  }

  level waittill("wheelson_capture_state_2");

  foreach(var_4f4fbf5aa68dae8a in var_f2dd3805ad08de24) {
    if(isDefined(var_4f4fbf5aa68dae8a.targetname) && var_4f4fbf5aa68dae8a.targetname == "2" && var_4f4fbf5aa68dae8a function_35c178c80fa19cbd("base", "dead") == 0) {
      var_4f4fbf5aa68dae8a setscriptablepartstate("base", "hacking");
    }

    if(isDefined(var_4f4fbf5aa68dae8a.targetname) && var_4f4fbf5aa68dae8a.targetname == "1" && var_4f4fbf5aa68dae8a function_35c178c80fa19cbd("base", "dead") == 0) {
      var_4f4fbf5aa68dae8a setscriptablepartstate("base", "hacked");
    }
  }

  level waittill("wheelson_capture_state_3");

  foreach(var_4f4fbf5aa68dae8a in var_f2dd3805ad08de24) {
    if(isDefined(var_4f4fbf5aa68dae8a.targetname) && var_4f4fbf5aa68dae8a.targetname == "3" && var_4f4fbf5aa68dae8a function_35c178c80fa19cbd("base", "dead") == 0) {
      var_4f4fbf5aa68dae8a setscriptablepartstate("base", "hacking");
    }

    if(isDefined(var_4f4fbf5aa68dae8a.targetname) && var_4f4fbf5aa68dae8a.targetname == "2" && var_4f4fbf5aa68dae8a function_35c178c80fa19cbd("base", "dead") == 0) {
      var_4f4fbf5aa68dae8a setscriptablepartstate("base", "hacked");
    }
  }

  level waittill("wheelson_capture_state_4");

  foreach(var_4f4fbf5aa68dae8a in var_f2dd3805ad08de24) {
    if(isDefined(var_4f4fbf5aa68dae8a.targetname) && var_4f4fbf5aa68dae8a.targetname == "4" && var_4f4fbf5aa68dae8a function_35c178c80fa19cbd("base", "dead") == 0) {
      var_4f4fbf5aa68dae8a setscriptablepartstate("base", "hacking");
    }

    if(isDefined(var_4f4fbf5aa68dae8a.targetname) && var_4f4fbf5aa68dae8a.targetname == "3" && var_4f4fbf5aa68dae8a function_35c178c80fa19cbd("base", "dead") == 0) {
      var_4f4fbf5aa68dae8a setscriptablepartstate("base", "hacked");
    }
  }

  level waittill("wheelson_capture_state_5");

  foreach(var_4f4fbf5aa68dae8a in var_f2dd3805ad08de24) {
    if(isDefined(var_4f4fbf5aa68dae8a.targetname) && var_4f4fbf5aa68dae8a.targetname == "5" && var_4f4fbf5aa68dae8a function_35c178c80fa19cbd("base", "dead") == 0) {
      var_4f4fbf5aa68dae8a setscriptablepartstate("base", "hacking");
    }

    if(isDefined(var_4f4fbf5aa68dae8a.targetname) && var_4f4fbf5aa68dae8a.targetname == "4" && var_4f4fbf5aa68dae8a function_35c178c80fa19cbd("base", "dead") == 0) {
      var_4f4fbf5aa68dae8a setscriptablepartstate("base", "hacked");
    }
  }

  level waittill("point_1_hacked");

  foreach(var_4f4fbf5aa68dae8a in var_f2dd3805ad08de24) {
    if(isDefined(var_4f4fbf5aa68dae8a.targetname) && var_4f4fbf5aa68dae8a.targetname == "5" && var_4f4fbf5aa68dae8a function_35c178c80fa19cbd("base", "dead") == 0) {
      var_4f4fbf5aa68dae8a setscriptablepartstate("base", "hacked");
    }
  }

  level.var_56adfa324022c19b = "state_1";
  scripts\mp\flags::gameflagwait("wheelson_reach_hack_point_final");
  level thread function_909f84add526f679(2);
  wait 1.5;

  foreach(var_4f4fbf5aa68dae8a in var_f2dd3b05ad08e4bd) {
    if(isDefined(var_4f4fbf5aa68dae8a.targetname) && var_4f4fbf5aa68dae8a.targetname == "1" && var_4f4fbf5aa68dae8a function_35c178c80fa19cbd("base", "dead") == 0) {
      var_4f4fbf5aa68dae8a setscriptablepartstate("base", "hacking");
    }
  }

  level waittill("wheelson_capture_state_2");

  foreach(var_4f4fbf5aa68dae8a in var_f2dd3b05ad08e4bd) {
    if(isDefined(var_4f4fbf5aa68dae8a.targetname) && var_4f4fbf5aa68dae8a.targetname == "2" && var_4f4fbf5aa68dae8a function_35c178c80fa19cbd("base", "dead") == 0) {
      var_4f4fbf5aa68dae8a setscriptablepartstate("base", "hacking");
    }

    if(isDefined(var_4f4fbf5aa68dae8a.targetname) && var_4f4fbf5aa68dae8a.targetname == "1" && var_4f4fbf5aa68dae8a function_35c178c80fa19cbd("base", "dead") == 0) {
      var_4f4fbf5aa68dae8a setscriptablepartstate("base", "hacked");
    }
  }

  level waittill("wheelson_capture_state_3");

  foreach(var_4f4fbf5aa68dae8a in var_f2dd3b05ad08e4bd) {
    if(isDefined(var_4f4fbf5aa68dae8a.targetname) && var_4f4fbf5aa68dae8a.targetname == "3" && var_4f4fbf5aa68dae8a function_35c178c80fa19cbd("base", "dead") == 0) {
      var_4f4fbf5aa68dae8a setscriptablepartstate("base", "hacking");
    }

    if(isDefined(var_4f4fbf5aa68dae8a.targetname) && var_4f4fbf5aa68dae8a.targetname == "2" && var_4f4fbf5aa68dae8a function_35c178c80fa19cbd("base", "dead") == 0) {
      var_4f4fbf5aa68dae8a setscriptablepartstate("base", "hacked");
    }
  }

  level waittill("wheelson_capture_state_4");

  foreach(var_4f4fbf5aa68dae8a in var_f2dd3b05ad08e4bd) {
    if(isDefined(var_4f4fbf5aa68dae8a.targetname) && var_4f4fbf5aa68dae8a.targetname == "4" && var_4f4fbf5aa68dae8a function_35c178c80fa19cbd("base", "dead") == 0) {
      var_4f4fbf5aa68dae8a setscriptablepartstate("base", "hacking");
    }

    if(isDefined(var_4f4fbf5aa68dae8a.targetname) && var_4f4fbf5aa68dae8a.targetname == "3" && var_4f4fbf5aa68dae8a function_35c178c80fa19cbd("base", "dead") == 0) {
      var_4f4fbf5aa68dae8a setscriptablepartstate("base", "hacked");
    }
  }

  level waittill("wheelson_capture_state_5");

  foreach(var_4f4fbf5aa68dae8a in var_f2dd3b05ad08e4bd) {
    if(isDefined(var_4f4fbf5aa68dae8a.targetname) && var_4f4fbf5aa68dae8a.targetname == "5" && var_4f4fbf5aa68dae8a function_35c178c80fa19cbd("base", "dead") == 0) {
      var_4f4fbf5aa68dae8a setscriptablepartstate("base", "hacking");
    }

    if(isDefined(var_4f4fbf5aa68dae8a.targetname) && var_4f4fbf5aa68dae8a.targetname == "4" && var_4f4fbf5aa68dae8a function_35c178c80fa19cbd("base", "dead") == 0) {
      var_4f4fbf5aa68dae8a setscriptablepartstate("base", "hacked");
    }
  }

  level waittill("wheelson_capture_state_6");

  foreach(var_4f4fbf5aa68dae8a in var_f2dd3b05ad08e4bd) {
    if(isDefined(var_4f4fbf5aa68dae8a.targetname) && var_4f4fbf5aa68dae8a.targetname == "5" && var_4f4fbf5aa68dae8a function_35c178c80fa19cbd("base", "dead") == 0) {
      var_4f4fbf5aa68dae8a setscriptablepartstate("base", "hacking");
    }

    if(isDefined(var_4f4fbf5aa68dae8a.targetname) && var_4f4fbf5aa68dae8a.targetname == "5" && var_4f4fbf5aa68dae8a function_35c178c80fa19cbd("base", "dead") == 0) {
      var_4f4fbf5aa68dae8a setscriptablepartstate("base", "hacked");
    }
  }

  level waittill("point_2_hacked");

  foreach(var_4f4fbf5aa68dae8a in var_f2dd3b05ad08e4bd) {
    if(isDefined(var_4f4fbf5aa68dae8a.targetname) && var_4f4fbf5aa68dae8a.targetname == "6" && var_4f4fbf5aa68dae8a function_35c178c80fa19cbd("base", "dead") == 0) {
      var_4f4fbf5aa68dae8a setscriptablepartstate("base", "hacked");
    }
  }
}

function function_fad186e07908db0c() {
  level endon("<dev string:x36>");

  while(true) {
    num = getdvarint(@ "hash_cd36022ea44b82a", 0);
    setDvar(@ "hash_cd36022ea44b82a", 0);

    if(num > 0 && num <= 10) {
      var_a67026bbabab5ebd = getEntArray("<dev string:x14a>", "<dev string:x161>");

      foreach(animroot in var_a67026bbabab5ebd) {
        animroot.played = 0;
      }

      function_c44237c56a815fbb(num);
    }

    active = getdvarint(@ "hash_446a2f02f1a78ae3", 0);
    setDvar(@ "hash_446a2f02f1a78ae3", 0);

    if(istrue(active)) {
      event = spawnStruct();
      event.zone = "<dev string:x16f>";
      event.eventname = "<dev string:x179>";
      event.delaytime = 1;
      event.context = "<dev string:x182>";
      event thread namespace_e497616c605290a6::function_8063e641963cd522();
    }

    active = getdvarint(@ "hash_6674af9ee46a590c", 0);
    setDvar(@ "hash_6674af9ee46a590c", 0);

    if(istrue(active)) {
      event = spawnStruct();
      event.zone = "<dev string:x16f>";
      event.eventname = "<dev string:x179>";
      event.delaytime = 1;
      event.context = "<dev string:x199>";
      event thread namespace_e497616c605290a6::function_8063e641963cd522();
    }

    active = getdvarint(@ "hash_de40dd963ae8453", 0);
    setDvar(@ "hash_de40dd963ae8453", 0);

    if(istrue(active)) {
      roofs = getEntArray("<dev string:x1ad>", "<dev string:x161>");
      var_797f676eac2f5f5d = getStructArray("<dev string:x1bb>", "<dev string:x161>");
      var_24e1eee4a6f213b7 = getentitylessscriptablearray("<dev string:x1ca>", "<dev string:x5d>");
      var_633452f052c3d4ba = getscriptablearray("<dev string:x1dd>", "<dev string:x5d>");

      if(active == 2) {
        scripts\mp\maps\mp_jup_skydiving\mp_jup_skydiving::function_c8a59331ffa83829(roofs, var_797f676eac2f5f5d, var_24e1eee4a6f213b7, 1, var_633452f052c3d4ba);
      } else if(active == 1) {
        scripts\mp\maps\mp_jup_skydiving\mp_jup_skydiving::function_c8a59331ffa83829(roofs, var_797f676eac2f5f5d, var_24e1eee4a6f213b7, 0.5, var_633452f052c3d4ba);
      }
    }

    wait 5;
  }
}

# /