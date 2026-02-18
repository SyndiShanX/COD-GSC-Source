/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: cp\cp_rus_kgb.gsc
***********************************************/

#using script_1c9985482fdb98fa;
#using script_1cdcb9e0e5c220f6;
#using script_1d1f270080269ee3;
#using script_1fd2c6e5fc8cb1c3;
#using script_2856038948e153b5;
#using script_29b2775606111b4b;
#using script_44aef2868ad2e317;
#using script_47734f62e0b3b388;
#using script_4c90e79630523e91;
#using script_4ec222619bffcfd1;
#using script_4fdb32cc1d125464;
#using script_6c0510483f3bae37;
#using script_744ba1f2f99cf072;
#using script_775d261b6ae76718;
#using script_779f525443585713;
#using script_7901e9dc8618be8a;
#using script_798f7d52f57a9c40;
#using script_d463fa0083062ba;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\damage;
#using scripts\core_common\flag_shared;
#using scripts\core_common\load_shared;
#using scripts\core_common\perks;
#using scripts\core_common\player\player_role;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\cp_common\skipto;
#using scripts\cp_common\util;
#namespace cp_rus_kgb;

function event_handler[level_init] main(eventstruct) {
  setclearanceceiling(16);
  init_flags();
  init_clientfields();
  function_37dfd679();
  namespace_e77bf565::function_26312171();
  namespace_e77bf565::function_85d3a678();
  namespace_e77bf565::function_95feac9c();
  kgb_aslt_exfil_escape::function_8346d62f();
  level thread kgb_aslt_vault::vault_close_player_clip();
  load::main();
  function_22b7fffd();
  init_callbacks();
  level thread kgb_aslt_exfil_escape::function_3253f5dc();
  level thread kgb_aslt_vault::function_de62c0a0();
  level thread namespace_e77bf565::placed_suspended_weapons();
  level thread function_4f53a5d1();
  level thread namespace_99e99ffa::function_fb149e45();
  setDvar(#"hash_76c0d7e6385ee6de", 0.3);
  setDvar(#"hash_4466b01c6d8d7307", 4);
  setDvar(#"hash_252e699c41531f1a", 2);
  setDvar(#"r_motionblurstrength", 0.2);
  setDvar(#"hash_7fb1be9520b9a725", 100);
  setDvar(#"hash_6b57212fd4fcdd3a", 350);
  setDvar(#"hash_4ad75035d6026ea2", 0.819);
}

function function_37dfd679() {
  skipto::function_eb91535d("kgb_ins_activation", &kgb_ins_activation::main, &kgb_ins_activation::starting, undefined, &kgb_ins_activation::cleanup, ["kgb_hq_front_04"]);
  skipto::function_eb91535d("kgb_ins_briefing", &kgb_ins_briefing::main, &kgb_ins_briefing::starting, undefined, &kgb_ins_briefing::cleanup, ["kgb_hq_front_04", "kgb_hq_intersection", "kgb_hq_east_wing", "kgb_hq_prison_stairs", "kgb_hq_elevator", "kgb_hq_armory_wing", "kgb_hq_courtyard", "kgb_hq_second_floor", "kgb_hq_conference_v2"]);
  skipto::function_eb91535d("kgb_ins_tutorial", &kgb_ins_prepare::function_79e00661, &kgb_ins_prepare::function_a79c8909, undefined, &kgb_ins_prepare::function_b791ea12, ["kgb_hq_front_04", "kgb_hq_intersection", "kgb_hq_east_wing", "kgb_hq_prison_stairs", "kgb_hq_elevator", "kgb_hq_armory_wing", "kgb_hq_courtyard", "kgb_hq_second_floor", "kgb_hq_conference_v2"]);
  skipto::function_eb91535d("kgb_ins_prepare", &kgb_ins_prepare::main, &kgb_ins_prepare::starting, undefined, &kgb_ins_prepare::cleanup, ["kgb_hq_front_04", "kgb_hq_intersection", "kgb_hq_east_wing", "kgb_hq_prison_stairs", "kgb_hq_elevator", "kgb_hq_armory_wing", "kgb_hq_courtyard", "kgb_hq_second_floor"]);
  skipto::function_eb91535d("kgb_ins_rv", &kgb_ins_rv::main, &kgb_ins_rv::starting, undefined, &kgb_ins_rv::cleanup, ["kgb_hq_front_04", "kgb_hq_intersection", "kgb_hq_east_wing", "kgb_hq_prison_stairs", "kgb_hq_elevator", "kgb_hq_armory_wing", "kgb_hq_courtyard", "kgb_hq_second_floor", "kgb_hq_basement"]);
  skipto::function_eb91535d("kgb_aslt_entry", &kgb_aslt_entry::main, &kgb_aslt_entry::starting, undefined, &kgb_aslt_entry::cleanup, ["kgb_hq_front_04", "kgb_hq_intersection", "kgb_hq_east_wing", "kgb_hq_prison_stairs", "kgb_hq_elevator", "kgb_hq_armory_wing", "kgb_hq_courtyard", "kgb_hq_second_floor", "kgb_hq_basement"]);
  skipto::function_eb91535d("kgb_aslt_elev_down", &kgb_aslt_elev_down::main, &kgb_aslt_elev_down::starting, undefined, &kgb_aslt_elev_down::cleanup, ["kgb_hq_front_04", "kgb_hq_intersection", "kgb_hq_east_wing", "kgb_hq_prison_stairs", "kgb_hq_elevator", "kgb_hq_armory_wing", "kgb_hq_courtyard", "kgb_hq_second_floor"]);
  skipto::function_eb91535d("kgb_aslt_bunker", &kgb_aslt_bunker::main, &kgb_aslt_bunker::starting, undefined, &kgb_aslt_bunker::cleanup, ["kgb_und_vault_bunker_main"]);
  skipto::function_eb91535d("kgb_aslt_vault_approach", &kgb_aslt_vault_approach::main, &kgb_aslt_vault_approach::starting, undefined, &kgb_aslt_vault_approach::cleanup, ["kgb_und_vault_bunker_main", "kgb_und_vault_red_tunnels_and_vault_area"]);
  skipto::function_eb91535d("kgb_aslt_vault_breach", &kgb_aslt_vault_breach::main, &kgb_aslt_vault_breach::starting, undefined, &kgb_aslt_vault_breach::cleanup, ["kgb_und_vault_bunker_main", "kgb_und_vault_red_tunnels_and_vault_area"]);
  skipto::function_eb91535d("kgb_aslt_vault", &kgb_aslt_vault::main, &kgb_aslt_vault::starting, undefined, &kgb_aslt_vault::cleanup, ["kgb_und_vault_bunker_main", "kgb_und_vault_red_tunnels_and_vault_area"]);
  skipto::function_eb91535d("kgb_aslt_bunker_escape", &kgb_aslt_bunker_escape::main, &kgb_aslt_bunker_escape::starting, undefined, &kgb_aslt_bunker_escape::cleanup, ["kgb_und_vault_bunker_main", "kgb_und_vault_red_tunnels_and_vault_area"]);
  skipto::function_eb91535d("kgb_aslt_escape_lights_out", &kgb_aslt_escape_lights_out::main, &kgb_aslt_escape_lights_out::starting, undefined, &kgb_aslt_escape_lights_out::cleanup, ["kgb_und_vault_bunker_main", "kgb_und_vault_red_tunnels_and_vault_area"]);
  skipto::function_eb91535d("kgb_aslt_escape_deploy_gas", &kgb_aslt_escape_deploy_gas::main, &kgb_aslt_escape_deploy_gas::starting, undefined, &kgb_aslt_escape_deploy_gas::cleanup, ["kgb_und_vault_bunker_main"]);
  skipto::function_eb91535d("kgb_aslt_exfil", &kgb_aslt_exfil::main, &kgb_aslt_exfil::starting, undefined, &kgb_aslt_exfil::cleanup, ["kgb_und_vault_bunker_main"]);
  skipto::function_eb91535d("kgb_aslt_exfil_escape", &kgb_aslt_exfil_escape::main, &kgb_aslt_exfil_escape::starting, undefined, &kgb_aslt_exfil_escape::cleanup, ["kgb_hq_front_04", "kgb_hq_intersection", "kgb_hq_east_wing", "kgb_hq_elevator", "kgb_hq_armory_wing", "kgb_hq_courtyard", "kgb_hq_second_floor"]);
  skipto::function_46d8992a("kgb_ins_activation");

  skipto::add_dev("<dev string:x38>", &function_1d4d824f);
  skipto::add_dev("<dev string:x49>", &function_1d4d824f);
  skipto::add_dev("<dev string:x62>", &kgb_ins_rv::function_ce801c8b);
  skipto::add_dev("<dev string:x76>", &function_ff99024a);
}

function function_1d4d824f(var_d3440450, var_50cc0d4f) {}

function init_flags() {
  level flag::init("elevator_clips_ready");
  level flag::init("player_picked_up_flashlight");
  level flag::init("player_flashlight_off");
  level thread kgb_ins_activation::init_flags();
  level thread kgb_ins_briefing::init_flags();
  level thread kgb_ins_prepare::init_flags();
  level thread kgb_ins_rv::init_flags();
  level thread kgb_aslt_entry::init_flags();
  level thread kgb_aslt_elev_down::init_flags();
  level thread kgb_aslt_bunker::init_flags();
  level thread kgb_aslt_vault_approach::init_flags();
  level thread kgb_aslt_vault_breach::init_flags();
  level thread kgb_aslt_vault::init_flags();
  level thread kgb_aslt_bunker_escape::init_flags();
  level thread kgb_aslt_escape_lights_out::init_flags();
  level thread kgb_aslt_escape_deploy_gas::init_flags();
  level thread kgb_aslt_exfil::init_flags();
}

function init_clientfields() {
  level thread namespace_e77bf565::init_clientfields();
  level thread kgb_ins_activation::init_clientfields();
  level thread kgb_ins_briefing::init_clientfields();
  level thread kgb_ins_prepare::init_clientfields();
  level thread kgb_ins_rv::init_clientfields();
  level thread kgb_aslt_entry::init_clientfields();
  level thread kgb_aslt_elev_down::init_clientfields();
  level thread kgb_aslt_bunker::init_clientfields();
  level thread kgb_aslt_vault_approach::init_clientfields();
  level thread kgb_aslt_vault_breach::init_clientfields();
  level thread kgb_aslt_vault::init_clientfields();
  level thread kgb_aslt_bunker_escape::init_clientfields();
  level thread kgb_aslt_escape_lights_out::init_clientfields();
  level thread kgb_aslt_escape_deploy_gas::init_clientfields();
  level thread kgb_aslt_exfil::init_clientfields();
  level thread kgb_aslt_exfil_escape::init_clientfields();
}

function function_22b7fffd() {
  level thread namespace_e77bf565::function_22b7fffd();
  level thread kgb_ins_activation::function_22b7fffd();
  level thread kgb_ins_briefing::function_22b7fffd();
  level thread kgb_ins_prepare::function_22b7fffd();
  level thread kgb_ins_rv::function_22b7fffd();
  level thread kgb_aslt_entry::function_22b7fffd();
  level thread kgb_aslt_elev_down::function_22b7fffd();
  level thread kgb_aslt_bunker::function_22b7fffd();
  level thread kgb_aslt_vault_approach::function_22b7fffd();
  level thread kgb_aslt_vault_breach::function_22b7fffd();
  level thread kgb_aslt_vault::function_22b7fffd();
  level thread kgb_aslt_bunker_escape::function_22b7fffd();
  level thread kgb_aslt_escape_lights_out::function_22b7fffd();
  level thread kgb_aslt_escape_deploy_gas::function_22b7fffd();
  level thread kgb_aslt_exfil::function_22b7fffd();
  level thread kgb_aslt_exfil_escape::function_22b7fffd();
}

function init_callbacks() {
  callback::on_connect(&function_7b24434e);
  callback::on_spawned(&function_39e4a7a9);
}

function function_7b24434e() {
  if(isDefined(level.var_28c22d88) && isinarray(level.var_28c22d88, "kgb_ins_activation") || level.var_28c22d88.size == 0) {
    util::function_f3cadc9a("cp_rus_kgb_player_ready");
  }
}

function function_39e4a7a9() {
  if(!isDefined(level.var_28c22d88[0])) {
    return;
  }

  outfit = "inside_man";

  switch (level.var_28c22d88[0]) {
    case # "kgb_aslt_entry":
    case # "kgb_aslt_elev_down":
      outfit = "kgb_officer";
    case # "kgb_ins_briefing":
    case # "hash_779fbd44d1ba455":
    case # "kgb_ins_rv":
    case # "kgb_ins_prepare":
    case # "kgb_ins_activation":
    case # "kgb_ins_tutorial":
    case # "hash_49b0ecdad010a134":
      function_9ebc1f37(outfit);
      break;
    case # "kgb_aslt_bunker_escape":
    case # "kgb_aslt_vault_breach":
    case # "kgb_aslt_exfil":
    case # "kgb_aslt_vault":
    case # "kgb_aslt_escape_lights_out":
    case # "kgb_aslt_bunker":
    case # "kgb_aslt_escape_deploy_gas":
    case # "kgb_aslt_vault_approach":
      function_69e3b754(undefined, "kgb_officer_exfil");
      break;
    case # "kgb_aslt_exfil_escape":
      function_69e3b754(undefined, "kgb_officer_exfil", 1, 1);
      break;
    case # "hash_798e519e29335c89":
      function_9ebc1f37();
      break;
    default:
      function_69e3b754();
      break;
  }
}

function function_9ebc1f37(outfit) {
  self thread function_e876a652(outfit);
  self setcinematicmotionoverride("cinematicmotion_kgb");
  var_4f2ba130 = self getweaponslist(1);

  foreach(e_w in var_4f2ba130) {
    self takeweapon(e_w);
  }

  w_pistol = getweapon(#"hash_5dbab0bd6a78c6e5");
  self giveweapon(w_pistol);
  self switchtoweapon(w_pistol);
  self val::set(#"hash_5fa17b60e571053a", "disable_aim_assist", 1);
  self val::set(#"hash_5fa17b60e571053a", "allow_sprint", 0);
  self val::set(#"hash_5fa17b60e571053a", "allow_jump", 0);
  self val::set(#"hash_5fa17b60e571053a", "allow_prone", 0);
  self val::set(#"hash_5fa17b60e571053a", "allow_mantle", 0);
  self allowslide(0);
  self setmovespeedscale(0.85);
  self val::set(#"hash_192dddd4b6f92f9", "show_weapon_hud", 0);
}

function function_69e3b754(var_e11cdcc2, outfit = "kgb_officer_exfil", var_7aefd93 = 0, var_98e6cf4 = 0, var_62e299fa) {
  self thread function_e876a652(outfit);
  self setcinematicmotionoverride("default_cinematicmotion");

  if(is_true(var_98e6cf4)) {
    self namespace_e77bf565::function_622fd34b();
    self.overrideplayerdamage = &armor_player_damage;
    self perks::perk_setperk("specialty_fastads");
    self perks::perk_setperk("specialty_fastweaponswitch");
    self util::blend_movespeedscale(0.75, 1);
    self val::set(#"hash_21a54a8e9cb54363", "allow_jump", 0);
    self val::set(#"hash_21a54a8e9cb54363", "allow_prone", 0);
    self val::set(#"hash_21a54a8e9cb54363", "allow_mantle", 0);
    self allowslide(0);
  }

  self function_c235774c(var_7aefd93);

  if(is_true(var_e11cdcc2)) {
    self val::set(#"hash_609b80fee0e38db3", "disable_weapons", 1);
  }

  if(is_true(var_62e299fa)) {
    self val::set(#"hash_1a95faa94687eb0c", "low_ready", 1);
  }
}

function armor_player_damage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, var_fd90b0bb, vpoint, vdir, shitloc, modelindex, psoffsettime) {
  damage = vdir;
  var_a8843f5e = 0.25;
  var_f694330a = 0.5;

  if(isDefined(vpoint) && !damage::friendlyfirecheck(self, vpoint)) {
    damage = 0;
    return damage;
  }

  if(isDefined(shitloc) && shitloc == "MOD_GRENADE_SPLASH") {
    if(isDefined(var_fd90b0bb) && is_true(var_fd90b0bb.var_83323dfb)) {
      screenshake(modelindex, 0.5, 0.5, 0.5, 0.5);
      self playrumbleonentity("damage_heavy");
      damage = 0;
      return damage;
    } else {
      damage = vdir * var_f694330a;
      return damage;
    }
  }

  if(isDefined(psoffsettime) && (psoffsettime == "head" || psoffsettime == "helmet" || psoffsettime == "torso_upper" || psoffsettime == "torso_lower" || psoffsettime == "torso_mid" || psoffsettime == "neck")) {
    screenshake(modelindex, randomfloatrange(0.05, 0.5), randomfloatrange(0.05, 0.5), randomfloatrange(0.05, 0.5), randomfloatrange(0.05, 0.2));
    self playrumbleonentity("damage_light");
    damage = 0;
    return damage;
  }

  return damage;
}

function function_c235774c(var_7aefd93) {
  var_6f805071 = getweapon(#"lmg_light_t9", "extclip2", "grip");
  var_ec227e6e = getweapon(#"shotgun_semiauto_t9", "extclip2", "fastreload");
  var_5ca6956f = getweapon(#"smg_standard_t9", "holo", "steadyaim", "extclip2", "quickdraw");
  var_4f2ba130 = self getweaponslist(1);

  foreach(e_w in var_4f2ba130) {
    self takeweapon(e_w);
  }

  if(is_true(var_7aefd93)) {
    self giveweapon(var_6f805071);
    self givemaxammo(var_6f805071);
    self giveweapon(var_ec227e6e);
    self givemaxammo(var_ec227e6e);
    self switchtoweaponimmediate(var_6f805071, 1);
  } else {
    self giveweapon(var_5ca6956f);
    self givemaxammo(var_5ca6956f);
    self giveweapon(var_ec227e6e);
    self givemaxammo(var_ec227e6e);
    self switchtoweaponimmediate(var_5ca6956f, 1);
  }

  grenade = getweapon(#"frag_grenade");
  self giveweapon(grenade);
  self givemaxammo(grenade);
  flash = getweapon(#"eq_flash_grenade");
  self giveweapon(flash);
  self givemaxammo(flash);
}

function function_e876a652(var_18cf1709, var_79a934ad = 1) {
  var_f846e9bf = 1;
  self setcharacterbodytype(9);
  var_6fa12df4 = 0;

  switch (var_18cf1709) {
    case # "inside_man":
      self setcharacteroutfit(24);
      var_f846e9bf = 0;
      break;
    case # "civilian":
      var_6fa12df4 = 2;
      break;
    case # "kgb_officer":
      var_6fa12df4 = 0;
      break;
    case # "kgb_officer_exfil":
      var_6fa12df4 = 1;
      break;
  }

  if(var_f846e9bf) {
    self util::function_a5318821(var_79a934ad, var_6fa12df4, undefined, 0);
  }
}

function function_ff99024a(var_d3440450, var_50cc0d4f) {
  car = getent("escape_vehicle", "targetname");
  car delete();
  level.adler = namespace_e77bf565::function_52fe0eb3(var_50cc0d4f);
  waitframe(1);
  tag = spawn("script_model", level.adler.origin);
  tag setModel("tag_origin");
  level.adler linkto(tag);
}

function function_4f53a5d1() {
  spawncollision("collision_clip_wall_64x64x10", "collider", (-4512, 3328, -1696), (352.799, 0, 0));
  spawncollision("collision_clip_wall_64x64x10", "collider", (-4512, 3232, -1696), (352.799, 0, 0));
  spawncollision("collision_clip_wall_64x64x10", "collider", (-4512, 3136, -1696), (352.799, 0, 0));
  spawncollision("collision_clip_wall_64x64x10", "collider", (-4512, 3040, -1696), (352.799, 0, 0));
  spawncollision("collision_clip_wall_64x64x10", "collider", (-4512, 2944, -1696), (352.799, 0, 0));
  spawncollision("collision_clip_wall_64x64x10", "collider", (-4512, 2848, -1696), (352.799, 0, 0));
}