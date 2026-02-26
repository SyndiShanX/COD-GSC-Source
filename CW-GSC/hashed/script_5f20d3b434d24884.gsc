/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_5f20d3b434d24884.gsc
***********************************************/

#using script_164a456ce05c3483;
#using script_17381cbdd152c031;
#using script_17dcb1172e441bf6;
#using script_1a9763988299e68d;
#using script_1b01e95a6b5270fd;
#using script_1b0b07ff57d1dde3;
#using script_1ce46999727f2f2b;
#using script_1d730eca5a7f1fa8;
#using script_1edff2e0ab8e8655;
#using script_1ee011cd0961afd7;
#using script_22f7f737d389d6e2;
#using script_2440f86f9cd325ac;
#using script_26187f7b449f7b92;
#using script_29362c2d16adb2be;
#using script_2a5bf5b4a00cee0d;
#using script_2c052d834cd7619a;
#using script_2dc29943582f8278;
#using script_350cffecd05ef6cf;
#using script_3d173c89c2828216;
#using script_3d5e6c007c0e2bb1;
#using script_3faf478d5b0850fe;
#using script_40f967ad5d18ea74;
#using script_4611af4073d18808;
#using script_47851dbeea22fe66;
#using script_4d748e58ce25b60c;
#using script_4f80bd5a062c37a8;
#using script_51351e47175c6116;
#using script_544ada140645565d;
#using script_5549681e1669c11a;
#using script_5701633066d199f2;
#using script_5f20d3b434d24884;
#using script_5fa6f3b5786efa65;
#using script_60c2b013c242647;
#using script_6b6510e124bad778;
#using script_717759a5d2a40e63;
#using script_74970cdde0a631ed;
#using script_74a56359b7d02ab6;
#using script_76983b49bef66b2e;
#using script_7aeb0ef28c222444;
#using script_abb3791af68bace;
#using script_afe02542e6c60f5;
#using scripts\core_common\ai\zombie_vortex;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\spawning_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace namespace_dfc652ee;
class class_38f05ef0 {
  var m_angles;
  var m_data;
  var m_entries;
  var m_height;
  var m_scale;
  var m_timeout;
  var m_type;
  var m_variant;
  var m_width;
  var var_3b17d6fc;
  var var_3d570e2e;
  var var_45b48e54;
  var var_480dae1c;
  var var_5d9462ef;
  var var_6269b9a1;
  var var_6b7b10c2;
  var var_6ea99c7a;
  var var_7248a65a;
  var var_9453b0c1;
  var var_b61c7f39;
  var var_cc2e45c1;
  var var_e7c8f3cc;
  var var_edabd2d1;
  var var_f3072bed;
  var var_f360c9a6;
  var var_f7688f8b;

  constructor() {
    var_f7688f8b = "";
    m_variant = 0;
    m_scale = 1;
    m_type = 0;
    m_timeout = 10;
    m_angles = (0, 0, 70);
    var_9453b0c1 = &think;
    var_5d9462ef = &idle;
    m_data = 0;
    var_45b48e54 = 0;
    var_6269b9a1 = &function_91c693d3;
    var_6269b9a1 = &function_91c693d3;
    var_cc2e45c1 = undefined;
    var_6b7b10c2 = 1;
    var_3b17d6fc = 0;
    var_7248a65a = 0;
    var_edabd2d1 = 0;
    var_f3072bed = 0;
    var_e7c8f3cc = 1;
    var_3d570e2e = "evt_doa_pickup_default_spawn";
    var_f360c9a6 = "evt_doa_pickup_default_lp";
    var_480dae1c = "evt_doa_pickup_default_despawn";
    var_6ea99c7a = "evt_doa_pickup_default_consumed";
    m_entries = 1;
    function_f8694033();
  }

  function function_1e4ba7d0() {
    return var_5d9462ef;
  }

  function function_2c127eb5() {
    return var_6b7b10c2;
  }

  function getname() {
    return var_f7688f8b;
  }

  function function_32b47cc3() {
    return var_b61c7f39;
  }

  function function_371cc878() {
    var_f3072bed++;
  }

  function idle() {}

  function function_3e72c5c3(var_41157a40 = &think) {
    var_9453b0c1 = var_41157a40;
  }

  function function_3f40904b() {
    var_f3072bed = 0;
  }

  function function_424c961e() {
    return var_3d570e2e;
  }

  function function_43e11510(var_386c1e5c) {
    var_3b17d6fc = var_386c1e5c;
  }

  function function_526bfcd9() {
    return var_6ea99c7a;
  }

  function function_55b7a101() {
    return m_entries;
  }

  function gettype() {
    return m_type;
  }

  function function_63c67234() {
    return var_9453b0c1;
  }

  function getheight() {
    return m_height;
  }

  function function_755a46e6() {
    if(!is_true(var_edabd2d1)) {
      var_7248a65a = gettime();
    }
  }

  function function_772950ea(onoff) {
    retval = var_edabd2d1;
    var_edabd2d1 = onoff;
    return retval;
  }

  function function_799a63cf(spawn, loop, despawn, consumed) {
    var_3d570e2e = spawn;
    var_f360c9a6 = loop;
    var_480dae1c = despawn;
    var_6ea99c7a = consumed;
  }

  function think() {}

  function function_8fa82fe8() {
    return var_e7c8f3cc;
  }

  function function_91c693d3() {}

  function init(var_49d95ac1, variant, var_44dbff18, rarity, scale, type, timeout, angles = (0, 0, 70), data = 0, entries = 1) {
    var_f7688f8b = var_49d95ac1;
    m_variant = variant;
    var_9453b0c1 = isDefined(var_44dbff18) ? var_44dbff18 : &think;
    m_scale = scale;
    m_type = type;
    m_timeout = timeout;
    m_angles = angles;
    m_data = data;
    var_45b48e54 = rarity;
    var_3b17d6fc = 0;
    var_7248a65a = 0;
    var_f3072bed = 0;
    m_entries = entries;
  }

  function getwidth() {
    return m_width;
  }

  function function_9a8ff4b1(round) {
    var_6b7b10c2 = round;
  }

  function function_a0da66ec() {
    return m_variant;
  }

  function function_a1e5bdf5(blinkf) {
    var_b61c7f39 = blinkf;
  }

  function function_a46e1955(func) {
    var_cc2e45c1 = func;
  }

  function function_a8f2b5de() {
    return var_cc2e45c1;
  }

  function function_ac2eae0a(func) {
    var_6269b9a1 = func;
  }

  function function_b0378495() {
    if(var_3b17d6fc == 0 || var_7248a65a == 0) {
      return true;
    }

    if(gettime() - var_7248a65a >= var_3b17d6fc) {
      return true;
    }

    return false;
  }

  function function_b27f6758() {
    return var_7248a65a;
  }

  function function_b3131904() {
    return var_f3072bed;
  }

  function getangles() {
    return m_angles;
  }

  function function_c1403591(var_dec486a3 = &idle) {
    var_5d9462ef = var_dec486a3;
  }

  function function_c62ea2e6() {
    return var_f360c9a6;
  }

  function function_cd066492() {
    return var_480dae1c;
  }

  function shouldtimeout() {
    return gettimeout() != -1;
  }

  function getrarity() {
    return var_45b48e54;
  }

  function function_e52fe3ad() {
    return var_6269b9a1;
  }

  function function_ea0e8d6d(val) {
    var_e7c8f3cc = val;
  }

  function gettimeout() {
    return m_timeout;
  }

  function function_f49b5612() {
    return var_3b17d6fc;
  }

  function getscale() {
    return m_scale;
  }

  function function_f8694033(width = 42, height = 72) {
    m_width = width;
    m_height = height;
  }

  function getdata() {
    return m_data;
  }
}
class class_a08a1bec {
  var m_data;
  var m_origin;
  var origin;
  var var_9453b0c1;
  var var_a116600e;
  var var_ff66dbc5;

  function destructor() {
    if(isDefined(var_a116600e)) {
      var_a116600e delete();
    }
  }

  function getname() {
    return [[var_ff66dbc5]] - > getname();
  }

  function function_5b9895db() {
    return var_ff66dbc5;
  }

  function gettype() {
    return [[var_ff66dbc5]] - > gettype();
  }

  function private function_65ee50ba(start) {
    s_trace = groundtrace(start + (0, 0, 48), start + (0, 0, -1000), 0, self);
    return s_trace[#"position"];
  }

  function init(itemdef, origin, angles = [[itemdef]] - > getangles(), data = [[itemdef]] - > getdata(), width = [[itemdef]] - > getwidth(), height = [[itemdef]] - > getheight(), scale = [[itemdef]] - > getscale(), clientside = 1) {
    var_ff66dbc5 = itemdef;
    m_origin = function_65ee50ba(origin) + (0, 0, 18);

    if(abs(m_origin[2] - origin[2]) > 40) {
      m_origin = (m_origin[0], m_origin[1], origin[2]);
    }

    m_data = data;
    var_9453b0c1 = [[var_ff66dbc5]] - > function_63c67234();
    var_a116600e = namespace_ec06fe4a::spawnmodel(m_origin);

    if(!isDefined(var_a116600e)) {
      return false;
    }

    var_a116600e.angles = angles;
    var_a116600e.pickup = self;
    var_a116600e.def = itemdef;
    model = [[itemdef]] - > getname();
    var_a116600e.scale = scale;
    var_a116600e setscale(var_a116600e.scale);
    var_a116600e.type = gettype();
    var_a116600e[[[[var_ff66dbc5]] - > function_e52fe3ad()]]();

    if(!clientside || [[var_a116600e.def]] - > function_8fa82fe8() == 0 || is_true(var_a116600e.popup) || !true) {
      if(var_a116600e.type == 6) {
        model = getweaponworldmodel(getweapon(model));
      }

      var_a116600e setModel(model);
    } else {
      var_a116600e setModel("tag_origin");
      var_a116600e clientfield::set("pickupsettype", var_a116600e.type + ([[var_a116600e.def]] - > function_a0da66ec() << 6));
      var_a116600e notsolid();
      var_a116600e.var_9ca559f5 = 1;
    }

    var_a116600e.script_noteworthy = "a_pickup_item";
    var_a116600e.targetname = "a_pickup_item";
    var_a116600e.radius = width;
    var_a116600e.height = height;
    var_a116600e.var_b20c0bc5 = [[itemdef]] - > function_32b47cc3();
    var_a116600e thread[[[[var_ff66dbc5]] - > function_1e4ba7d0()]]();
    var_a116600e thread[[var_9453b0c1]]();
    var_a116600e thread namespace_dfc652ee::pickuptimeout(gettimeout());
    var_a116600e.var_2f0b512f = level.doa.var_3902985f;

    if(isDefined(level.doa.var_a71b0305)) {
      [[level.doa.var_a71b0305]](var_a116600e);
    }

    level.doa.var_cc831548[level.doa.var_cc831548.size] = var_a116600e;
    return true;
  }

  function private drop_to_ground() {
    s_trace = groundtrace(origin + (0, 0, 16), origin + (0, 0, -1000), 0, self);
    origin = s_trace[#"position"] + (0, 0, 24);
  }

  function getrarity() {
    return [[var_ff66dbc5]] - > getrarity();
  }

  function getmodel() {
    return var_a116600e;
  }

  function gettimeout() {
    return [[var_ff66dbc5]] - > gettimeout();
  }

  function getdata(data) {
    return m_data;
  }
}

function init() {
  assert(isDefined(level.doa));
  clientfield::register("scriptmover", "pickuprotate", 1, 1, "int");
  clientfield::register("scriptmover", "pickupsettype", 1, 6 + 3, "int");
  clientfield::register("scriptmover", "pickupvisibility", 1, 1, "int");
  clientfield::register("scriptmover", "pickuptimeout", 1, 1, "int");
  clientfield::register("scriptmover", "pickupmoveto", 1, 4, "int");
  level.doa.pickups = spawnStruct();
  level.doa.pickups.var_79d6391f = 0;
  level.doa.var_271e8e25 = [];
  level.doa.pickups.itemdefs = [];
  level.doa.var_f99feb1e = [];
  level.doa.var_cc831548 = [];
  level.doa.active_attractors = [];
  level.doa.pickups.var_d11c709 = [];
  level.doa.pickups.var_a81bed69 = [];
  level.doa.var_50a26b4f = 1;
  level.doa.var_54c5c3e6 = undefined;
  namespace_c501aa2e::init();
  level.doa.pickups.var_92a02b26 = getent("zombietron_siegebot_spawner", "targetname");
  level.doa.pickups.var_f20eb59f = getent("zombietron_tank_spawner", "targetname");
  level.doa.pickups.var_4480248f = getent("zombietron_hind_spawner", "targetname");
  level.doa.pickups.var_ef3f4447 = getent("zombietron_sentry_spawner", "targetname");
  level.doa.pickups.var_9eec57e8 = getent("zombietron_grenade_spawner", "targetname");
  function_8cf6a668(13, {
    #var_d266c0d8: "evt_doa_pickup_gem_spawn", #var_2aa68449: "evt_doa_pickup_gem_lp", #var_860ac8be: undefined, #var_9f6d7ee9: "evt_doa_pickup_gem_consumed"});
  function_8cf6a668(1, {
    #var_d266c0d8: "evt_doa_pickup_money_spawn", #var_2aa68449: "evt_doa_pickup_money_lp", #var_860ac8be: undefined, #var_9f6d7ee9: "evt_doa_pickup_money_consumed"});
  function_8cf6a668(6, {
    #var_d266c0d8: "evt_doa_pickup_weapon_spawn", #var_2aa68449: undefined, #var_860ac8be: undefined, #var_9f6d7ee9: "evt_doa_pickup_weapon_consumed"});
  function_8cf6a668(15, {
    #var_d266c0d8: "evt_doa_pickup_chicken_spawn", #var_2aa68449: "evt_doa_pickup_chicken_lp", #var_860ac8be: "evt_doa_pickup_chicken_despawn", #var_9f6d7ee9: "evt_doa_pickup_chicken_consumed"});
  function_8cf6a668(14, {
    #var_d266c0d8: "evt_doa_pickup_key_spawn", #var_2aa68449: "evt_doa_pickup_default_lp", #var_860ac8be: "evt_doa_pickup_default_despawn", #var_9f6d7ee9: "evt_doa_pickup_key_consumed"});
  function_8cf6a668(8, {
    #var_d266c0d8: "evt_doa_pickup_default_spawn", #var_2aa68449: "evt_doa_pickup_default_lp", #var_860ac8be: "evt_doa_pickup_default_despawn", #var_9f6d7ee9: "evt_doa_powerup_nuke_consumed"});
  function_8cf6a668(9, {
    #var_d266c0d8: "evt_doa_pickup_default_spawn", #var_2aa68449: "evt_doa_pickup_default_lp", #var_860ac8be: "evt_doa_pickup_default_despawn", #var_9f6d7ee9: "evt_doa_powerup_boost_consumed"});
  function_8cf6a668(17, {
    #var_d266c0d8: "evt_doa_pickup_barrel_spawn", #var_2aa68449: "evt_doa_pickup_default_lp", #var_860ac8be: "evt_doa_pickup_default_despawn", #var_9f6d7ee9: "evt_doa_pickup_barrel_consumed"});
  function_8cf6a668(24, {
    #var_d266c0d8: "evt_doa_pickup_boots_spawn", #var_2aa68449: "evt_doa_pickup_default_lp", #var_860ac8be: "evt_doa_pickup_default_despawn", #var_9f6d7ee9: "evt_doa_pickup_boots_consumed"});
  function_8cf6a668(18, {
    #var_d266c0d8: "evt_doa_pickup_boxers_spawn", #var_2aa68449: "evt_doa_pickup_default_lp", #var_860ac8be: "evt_doa_pickup_default_despawn", #var_9f6d7ee9: "evt_doa_pickup_boxers_consumed"});
  function_8cf6a668(25, {
    #var_d266c0d8: "evt_doa_pickup_clock_spawn", #var_2aa68449: "evt_doa_pickup_default_lp", #var_860ac8be: "evt_doa_pickup_default_despawn", #var_9f6d7ee9: "evt_doa_pickup_clock_consumed"});
  function_8cf6a668(26, {
    #var_d266c0d8: "evt_doa_pickup_coatofarms_spawn", #var_2aa68449: "evt_doa_pickup_default_lp", #var_860ac8be: "evt_doa_pickup_default_despawn", #var_9f6d7ee9: "evt_doa_pickup_default_consumed"});
  function_8cf6a668(16, {
    #var_d266c0d8: "evt_doa_pickup_extralife_spawn", #var_2aa68449: "evt_doa_pickup_default_lp", #var_860ac8be: "evt_doa_pickup_default_despawn", #var_9f6d7ee9: "evt_doa_pickup_extralife_consumed"});
  function_8cf6a668(3, {
    #var_d266c0d8: "evt_doa_pickup_firstperson_spawn", #var_2aa68449: "evt_doa_pickup_default_lp", #var_860ac8be: "evt_doa_pickup_default_despawn", #var_9f6d7ee9: "evt_doa_pickup_firstperson_consumed"});
  function_8cf6a668(11, {
    #var_d266c0d8: "evt_doa_pickup_giftbox_spawn", #var_2aa68449: undefined, #var_860ac8be: "evt_doa_pickup_default_despawn", #var_9f6d7ee9: undefined
  });
  function_8cf6a668(31, {
    #var_d266c0d8: "evt_doa_pickup_magichat_spawn", #var_2aa68449: "evt_doa_pickup_default_lp", #var_860ac8be: "evt_doa_pickup_default_despawn", #var_9f6d7ee9: "evt_doa_pickup_magichat_consumed"});
  function_8cf6a668(10, {
    #var_d266c0d8: "evt_doa_pickup_healthpotion_spawn", #var_2aa68449: "evt_doa_pickup_default_lp", #var_860ac8be: "evt_doa_pickup_default_despawn", #var_9f6d7ee9: "evt_doa_pickup_healthpotion_consumed"});
  function_8cf6a668(23, {
    #var_d266c0d8: "evt_doa_pickup_magnet_spawn", #var_2aa68449: "evt_doa_pickup_default_lp", #var_860ac8be: "evt_doa_pickup_default_despawn", #var_9f6d7ee9: "evt_doa_pickup_magnet_consumed"});
  function_8cf6a668(27, {
    #var_d266c0d8: "evt_doa_pickup_monkeybomb_spawn", #var_2aa68449: "evt_doa_pickup_default_lp", #var_860ac8be: "evt_doa_pickup_default_despawn", #var_9f6d7ee9: "evt_doa_pickup_monkeybomb_consumed"});
  function_8cf6a668(19, {
    #var_d266c0d8: "evt_doa_pickup_sawblade_spawn", #var_2aa68449: "evt_doa_pickup_default_lp", #var_860ac8be: "evt_doa_pickup_default_despawn", #var_9f6d7ee9: "evt_doa_pickup_sawblade_consumed"});
  function_8cf6a668(22, {
    #var_d266c0d8: "evt_doa_pickup_sentry_spawn", #var_2aa68449: "evt_doa_pickup_default_lp", #var_860ac8be: "evt_doa_pickup_default_despawn", #var_9f6d7ee9: "evt_doa_pickup_sentry_consumed"});
  function_8cf6a668(45, {
    #var_d266c0d8: "evt_doa_pickup_sentry_spawn", #var_2aa68449: "evt_doa_pickup_default_lp", #var_860ac8be: "evt_doa_pickup_default_despawn", #var_9f6d7ee9: "evt_doa_pickup_sentry_consumed"});
  function_8cf6a668(34, {
    #var_d266c0d8: "evt_doa_pickup_skeleton_spawn", #var_2aa68449: "evt_doa_pickup_default_lp", #var_860ac8be: "evt_doa_pickup_default_despawn", #var_9f6d7ee9: "evt_doa_pickup_skeleton_consumed"});
  function_8cf6a668(30, {
    #var_d266c0d8: "evt_doa_pickup_sprinkler_spawn", #var_2aa68449: "evt_doa_pickup_default_lp", #var_860ac8be: "evt_doa_pickup_default_despawn", #var_9f6d7ee9: "evt_doa_pickup_sprinkler_consumed"});
  function_8cf6a668(28, {
    #var_d266c0d8: "evt_doa_pickup_teddybear_spawn", #var_2aa68449: "evt_doa_pickup_default_lp", #var_860ac8be: "evt_doa_pickup_default_despawn", #var_9f6d7ee9: "evt_doa_pickup_teddybear_consumed"});
  function_8cf6a668(29, {
    #var_d266c0d8: "evt_doa_pickup_teslaball_spawn", #var_2aa68449: "evt_doa_pickup_default_lp", #var_860ac8be: "evt_doa_pickup_default_despawn", #var_9f6d7ee9: "evt_doa_pickup_teslaball_consumed"});
  function_8cf6a668(21, {
    #var_d266c0d8: "evt_doa_pickup_umbrella_spawn", #var_2aa68449: "evt_doa_pickup_default_lp", #var_860ac8be: "evt_doa_pickup_default_despawn", #var_9f6d7ee9: "evt_doa_pickup_umbrella_consumed"});
  function_8cf6a668(4, {
    #var_d266c0d8: "evt_doa_pickup_mech_spawn", #var_2aa68449: "evt_doa_pickup_default_lp", #var_860ac8be: "evt_doa_pickup_default_despawn", #var_9f6d7ee9: "evt_doa_pickup_mech_consumed"});
  function_8cf6a668(5, {
    #var_d266c0d8: "evt_doa_pickup_tank_spawn", #var_2aa68449: "evt_doa_pickup_default_lp", #var_860ac8be: "evt_doa_pickup_default_despawn", #var_9f6d7ee9: "evt_doa_pickup_tank_consumed"});
  function_8cf6a668(40, {
    #var_d266c0d8: "evt_doa_pickup_hind_spawn", #var_2aa68449: "evt_doa_pickup_default_lp", #var_860ac8be: "evt_doa_pickup_default_despawn", #var_9f6d7ee9: "evt_doa_pickup_hind_consumed"});
  function_8cf6a668(44, {
    #var_d266c0d8: "evt_doa_pickup_arcade_spawn", #var_2aa68449: "evt_doa_pickup_default_lp", #var_860ac8be: "evt_doa_pickup_default_despawn", #var_9f6d7ee9: "evt_doa_pickup_arcade_consumed"});
  function_8cf6a668(43, {
    #var_d266c0d8: "evt_doa_pickup_vortex_spawn", #var_2aa68449: "evt_doa_pickup_default_lp", #var_860ac8be: "evt_doa_pickup_default_despawn", #var_9f6d7ee9: "evt_doa_pickup_vortex_consumed"});
  function_51ab3213();
  namespace_4ff32993::init();
  namespace_5d515bd5::init();
  level.doa.var_9a6327ee = function_6265bde4("zombietron_beryl");
  level.doa.var_4b113826 = function_6265bde4("zombietron_ruby");
}

function function_8cf6a668(type, itemdata) {
  items = [];

  foreach(def in level.doa.pickups.itemdefs) {
    if([[def]] - > gettype() == type) {
      items[items.size] = def;
    }
  }

  foreach(itemdef in items) {
    [[itemdef]] - > function_799a63cf(itemdata.var_d266c0d8, itemdata.var_2aa68449, itemdata.var_860ac8be, itemdata.var_9f6d7ee9);
  }
}

function function_72e8509(def) {
  if(isDefined(def)) {
    return [[def]] - > function_b3131904();
  }

  count = 0;

  foreach(def in level.doa.pickups.itemdefs) {
    count += [[def]] - > function_b3131904();
  }

  return count;
}

function function_b950ecde() {
  foreach(def in level.doa.pickups.itemdefs) {
    [[def]] - > function_3f40904b();
  }
}

function function_c1018360(var_49d95ac1, type, variant, rarity, modelscale, angles = (0, 0, 70), data, entries = 1) {
  assert(type <= (1 << 6) - 1, "<dev string:x38>");
  assert(variant <= (1 << 3) - 1, "<dev string:x58>");
  timeout = 10;

  switch (type) {
    case 32:
      timeout = 2;
      break;
    case 33:
      timeout = 6;
      break;
  }

  pickupdef = new class_38f05ef0();
  [[pickupdef]] - > init(var_49d95ac1, variant, &function_2ebebd0c, rarity, modelscale, type, timeout, angles, data, entries);
  level.doa.pickups.itemdefs[level.doa.pickups.itemdefs.size] = pickupdef;
  [[pickupdef]] - > function_c1403591(&pickuprotate);

  switch (type) {
    case 6:
      namespace_41cb996::function_377d91b2(var_49d95ac1, data);
      break;
    case 13:
      [[pickupdef]] - > function_c1403591(&function_2cfd5616);
      [[pickupdef]] - > function_ac2eae0a(&function_2c64b1c7);
      [[pickupdef]] - > function_a46e1955(&function_b8f6a8cd);
      level.doa.pickups.var_a81bed69[level.doa.pickups.var_a81bed69.size] = pickupdef;
      break;
    case 1:
      level.doa.pickups.var_d11c709[level.doa.pickups.var_d11c709.size] = pickupdef;
      break;
    case 14:
      [[pickupdef]] - > function_c1403591(&function_594c2e4e);
      [[pickupdef]] - > function_ea0e8d6d(0);
      break;
    case 15:
      [[pickupdef]] - > function_c1403591(&namespace_4ff32993::chicken_idle);
      [[pickupdef]] - > function_ea0e8d6d(0);
      break;
    case 32:
    case 33:
      [[pickupdef]] - > function_3e72c5c3(&namespace_3a8e4a3::function_98acc465);
      [[pickupdef]] - > function_a1e5bdf5(&namespace_3a8e4a3::function_22c4e231);
      [[pickupdef]] - > function_c1403591(undefined);
      [[pickupdef]] - > function_ea0e8d6d(0);
      break;
  }

  switch (type) {
    case 3:
      [[pickupdef]] - > function_9a8ff4b1(5);
      [[pickupdef]] - > function_43e11510(3 * 60000);
      break;
    case 17:
    case 24:
    case 19:
    case 20:
    case 29:
    case 22:
    case 27:
    case 15:
    case 42:
      [[pickupdef]] - > function_9a8ff4b1(1);
      [[pickupdef]] - > function_43e11510(3 * 60000);
      break;
    case 26:
    case 30:
    case 31:
    case 9:
    case 11:
    case 34:
    case 45:
    case 18:
    case 25:
      [[pickupdef]] - > function_43e11510(15 * 60000);
      [[pickupdef]] - > function_9a8ff4b1(7);
      break;
    case 4:
    case 5:
    case 8:
    case 28:
    case 32:
    case 21:
    case 40:
    case 43:
    case 23:
      [[pickupdef]] - > function_43e11510(30 * 60000);
      [[pickupdef]] - > function_9a8ff4b1(7);
      break;
    case 44:
      [[pickupdef]] - > function_43e11510(60 * 60000);
      [[pickupdef]] - > function_9a8ff4b1(20);
      break;
    case 33:
    case 16:
    case 46:
      [[pickupdef]] - > function_43e11510(30 * 60000);
      [[pickupdef]] - > function_9a8ff4b1(7);
      break;
    case 14:
      [[pickupdef]] - > function_43e11510(30 * 60000);
      [[pickupdef]] - > function_9a8ff4b1(9);
      break;
    case 12:
    case 36:
    case 37:
    case 38:
    case 39:
    case 41:
      [[pickupdef]] - > function_9a8ff4b1(999999);
      break;
  }
}

function function_51ab3213() {
  level.doa.pickups.loottable = [];
  level.doa.pickups.loottable[0] = [];
  level.doa.pickups.loottable[1] = [];
  level.doa.pickups.loottable[2] = [];
  level.doa.pickups.loottable[3] = [];
  level.doa.pickups.loottable[4] = [];
  level.doa.pickups.var_2a93b19 = [];
  level.doa.pickups.var_2a93b19[0] = [];
  level.doa.pickups.var_2a93b19[1] = [];
  level.doa.pickups.var_2a93b19[2] = [];
  level.doa.pickups.var_2a93b19[3] = [];
  level.doa.pickups.var_2a93b19[4] = [];
  level.doa.pickups.var_3031eb5c = [];

  foreach(item in level.doa.pickups.itemdefs) {
    entries = [[item]] - > function_55b7a101();
    assert(entries > 0, "<dev string:x7c>");

    while(entries) {
      entries--;

      if([[item]] - > gettype() == 6) {
        if(!isDefined(level.doa.pickups.var_3031eb5c)) {
          level.doa.pickups.var_3031eb5c = [];
        } else if(!isarray(level.doa.pickups.var_3031eb5c)) {
          level.doa.pickups.var_3031eb5c = array(level.doa.pickups.var_3031eb5c);
        }

        level.doa.pickups.var_3031eb5c[level.doa.pickups.var_3031eb5c.size] = item;
        continue;
      }

      if([[item]] - > gettype() == 1 || [[item]] - > gettype() == 13) {
        if(!isDefined(level.doa.pickups.var_2a93b19[[[item]] - > getrarity()])) {
          level.doa.pickups.var_2a93b19[[[item]] - > getrarity()] = [];
        } else if(!isarray(level.doa.pickups.var_2a93b19[[[item]] - > getrarity()])) {
          level.doa.pickups.var_2a93b19[[[item]] - > getrarity()] = array(level.doa.pickups.var_2a93b19[[[item]] - > getrarity()]);
        }

        level.doa.pickups.var_2a93b19[[[item]] - > getrarity()][level.doa.pickups.var_2a93b19[[[item]] - > getrarity()].size] = item;
        continue;
      }

      if(!isDefined(level.doa.pickups.loottable[[[item]] - > getrarity()])) {
        level.doa.pickups.loottable[[[item]] - > getrarity()] = [];
      } else if(!isarray(level.doa.pickups.loottable[[[item]] - > getrarity()])) {
        level.doa.pickups.loottable[[[item]] - > getrarity()] = array(level.doa.pickups.loottable[[[item]] - > getrarity()]);
      }

      level.doa.pickups.loottable[[[item]] - > getrarity()][level.doa.pickups.loottable[[[item]] - > getrarity()].size] = item;
    }
  }
}

function function_f9ae7957() {
  type = [[self]] - > gettype();

  if(type == 32 || type == 33) {
    return undefined;
  }

  if(type == 14) {
    return "glow_yellow";
  }

  if(type == 6) {
    return "glow_weapon";
  }

  if(type == 10) {
    return "glow_red";
  }

  if(type == 46) {
    return "glow_yellow";
  }

  if(type == 13) {
    name = [[self]] - > getname();

    switch (name) {
      case # "zombietron_diamond":
        self.var_4212fdee = "gem_trail_white";
        return "glow_white";
      case # "zombietron_ruby":
        self.var_4212fdee = "gem_trail_red";
        return "glow_red";
      case # "zombietron_beryl":
        self.var_4212fdee = "gem_trail_yellow";
        return "glow_yellow";
      case # "zombietron_sapphire":
        self.var_4212fdee = "gem_trail_blue";
        return "glow_blue";
      case # "zombietron_emerald":
        self.var_4212fdee = "gem_trail_green";
        return "glow_green";
    }
  }

  if([[self]] - > getrarity() >= 2) {
    return "glow_yellow";
  }

  if(type == 1) {
    data = [[self]] - > getdata();

    if(isDefined(data)) {
      switch (data) {
        case 3:
        case 4:
        case 5:
          return "glow_yellow";
        case 6:
        case 7:
          return "glow_white";
      }
    }
  }

  return "glow_item";
}

function function_7e4e4b8a(player, height = 1200) {
  self endon(#"picked_up", #"death");
  player endon(#"disconnect");
  self thread namespace_ec06fe4a::function_ae010bb4(player);
  var_eaf9387b = gettime() + 3500;
  self.origin += (0, 0, height);

  while(isDefined(self) && gettime() < var_eaf9387b) {
    if(self.origin[2] <= player.origin[2]) {
      self.origin = player.origin;
      break;
    }

    var_c23d5e93 = (player.origin[0], player.origin[1], self.origin[2] - 32);
    self.origin = var_c23d5e93;
    waitframe(1);
  }

  if(isDefined(self)) {
    self notify(#"bombsaway");
  }
}

function itemspawn(pickupdef, origin, angles, data, forced = 0, glow, width, height, owner, dropheight, clientside = 1) {
  if(!namespace_ec06fe4a::function_a8975c67()) {
    return;
  }

  type = [[pickupdef]] - > gettype();

  if(type == 46 && is_true(level.doa.var_318aa67a)) {
    type = 10;
    pickupdef = function_2c9923d7(type);
  }

  if(isDefined(level.doa.var_d5fbd3)) {
    if([[level.doa.var_d5fbd3]](pickupdef, origin) == 0) {
      return;
    }
  }

  if(!is_true(forced) && !function_ae609287(pickupdef, origin)) {
    return;
  }

  if(function_4821dfcf(type)) {
    level.doa.var_4b491c02 = gettime() + 300000;
  }

  pickup = new class_a08a1bec();
  assert(isDefined(pickup));

  if(!isDefined(pickup)) {
    return;
  }

  if(![[pickup]] - > init(pickupdef, origin, angles, data, width, height, undefined, clientside)) {
    pickup = undefined;
    return;
  }

  model = [[pickup]] - > getmodel();

  if(!isDefined(glow)) {
    glow = pickup function_f9ae7957();
  }

  model.glowfx = glow;

  if(isDefined(model.glowfx)) {
    model namespace_83eb6304::function_3ecfde67(model.glowfx);
  }

  if(isDefined(pickup.var_4212fdee)) {
    model namespace_83eb6304::function_3ecfde67(pickup.var_4212fdee);
  }

  if(isDefined(owner)) {
    model.var_54dddc17 = owner;
    model thread function_7e4e4b8a(owner, dropheight);
  }

  var_c5fd79c8 = [[pickupdef]] - > function_424c961e();
  var_2b2c2c96 = [[pickupdef]] - > function_c62ea2e6();
  model thread function_7347b447(var_c5fd79c8, var_2b2c2c96);

  if(!forced) {
    [[pickupdef]] - > function_371cc878();
    [[pickupdef]] - > function_755a46e6();
  }

  if(type == 39) {
    model clientfield::set("set_icon", 9);
  }

  level notify(#"hash_6b1b7f8f320c0d3b", {
    #pickup: model, #type: type
  });
  return model;
}

function function_7347b447(var_c5fd79c8, var_2b2c2c96) {
  self endon(#"death");
  self endon(#"picked_up");

  if(isDefined(var_c5fd79c8)) {
    self namespace_e32bb68::function_3a59ec34(var_c5fd79c8);
  }

  if(isDefined(var_2b2c2c96)) {
    util::wait_network_frame();
    self namespace_e32bb68::function_3a59ec34(var_2b2c2c96);
  }
}

function function_ad7ac41b(origin, numitems = 10, radius = 256, itemtype = 0, forced = 0, data) {
  while(numitems > 0) {
    pickupdef = function_57160cba(itemtype);
    function_83aea294(origin, 1, radius, pickupdef, data, forced);
    numitems--;
  }
}

function function_83aea294(origin, numitems = 10, radius = 256, pickupdef, data, forced) {
  radius = int(radius);

  while(numitems) {
    spawner::global_spawn_throttle();
    spot = origin;

    if(radius > 0) {
      spot += (randomintrange(radius * -1, radius), randomintrange(radius * -1, radius), 0);
    }

    spawnfunc = [[pickupdef]] - > function_a8f2b5de();

    if(isDefined(spawnfunc)) {
      [[spawnfunc]](pickupdef, spot, data, forced);
    } else {
      itemspawn(pickupdef, spot, undefined, data, forced);
    }

    numitems--;
  }
}

function function_68442ee7(origin, numitems = 10, radius = 256, rare = 0, data, forced = 0) {
  while(numitems) {
    if(rare) {
      pickupdef = function_57160cba(2);
    } else {
      pickupdef = function_57160cba(1);
    }

    function_83aea294(origin, 1, radius, pickupdef, data, forced);
    numitems--;
  }
}

function function_d06cbfe8(origin, numitems = 10, radius = 256, popup = 0, pickupdef, forced = 0, scale) {
  radius = int(radius);

  while(numitems) {
    spawner::global_spawn_throttle();
    spot = origin + (randomintrange(radius * -1, radius), randomintrange(radius * -1, radius), 0);
    function_b8f6a8cd(pickupdef, spot, popup, forced, scale);
    numitems--;
  }
}

function function_b8f6a8cd(pickupdef = function_57160cba(13), origin, popup = 0, forced, scale, angles) {
  data = (popup ? 1 : 0) << 16;

  if(!isDefined(scale)) {
    rnd = randomint(100);

    if(rnd < 90) {
      scale = randomfloatrange(1, 2);
    } else if(rnd < 96) {
      scale = randomfloatrange(1, 3 * 2);
    } else {
      scale = randomfloatrange(1, 10);
    }
  }

  if(scale < 1) {
    scale = 1;
  }

  width = (scale < 3 ? 1 : 2) * 42;
  height = (scale < 3 ? 1 : 2) * 72;
  scale = int(scale / 10 * 65535);
  data += scale;
  return itemspawn(pickupdef, origin, angles, data, forced, undefined, width, height);
}

function function_57160cba(type = 0) {
  assert(level.doa.pickups.itemdefs.size);

  if(type == 6) {
    return level.doa.pickups.var_3031eb5c[randomint(level.doa.pickups.var_3031eb5c.size)];
  }

  if(type == 13) {
    return level.doa.pickups.var_a81bed69[randomint(level.doa.pickups.var_a81bed69.size)];
  }

  if(type == 1 || type == 2) {
    roll = randomint(100);

    if(type == 2) {
      roll -= 50;
    }

    itemtype = 0;

    if(roll < 50 && level.doa.pickups.var_2a93b19[1].size) {
      itemtype = 1;
    }

    if(roll < 23 && level.doa.pickups.var_2a93b19[2].size) {
      itemtype = 2;
    }

    if(roll < 5 && level.doa.pickups.var_2a93b19[3].size) {
      itemtype = 3;
    }

    if(roll < 1 && level.doa.pickups.var_2a93b19[4].size) {
      itemtype = 4;
    }

    return level.doa.pickups.var_2a93b19[itemtype][randomint(level.doa.pickups.var_2a93b19[itemtype].size)];
  }

  if(type == 0) {
    roll = randomint(100);
    itemtype = 0;

    if(roll < 1 && level.doa.pickups.loottable[4].size) {
      itemtype = 4;
    } else if(roll < 5 && level.doa.pickups.loottable[3].size) {
      itemtype = 3;
    } else if(roll < 23 && level.doa.pickups.loottable[2].size) {
      itemtype = 2;
    } else if(roll < 50 && level.doa.pickups.loottable[1].size) {
      itemtype = 1;
    }

    var_c2433b2a = [];

    foreach(item in level.doa.pickups.loottable[itemtype]) {
      if(function_ae609287(item)) {
        if(!isDefined(var_c2433b2a)) {
          var_c2433b2a = [];
        } else if(!isarray(var_c2433b2a)) {
          var_c2433b2a = array(var_c2433b2a);
        }

        var_c2433b2a[var_c2433b2a.size] = item;
      }
    }

    if(var_c2433b2a.size > 0) {
      return var_c2433b2a[randomint(var_c2433b2a.size)];
    }

    return level.doa.pickups.loottable[itemtype][randomint(level.doa.pickups.loottable[itemtype].size)];
  }

  return function_2c9923d7(type);
}

function function_6265bde4(name) {
  foreach(def in level.doa.pickups.itemdefs) {
    if([[def]] - > getname() == name) {
      return def;
    }
  }
}

function function_2c9923d7(type) {
  items = [];

  foreach(def in level.doa.pickups.itemdefs) {
    if([[def]] - > gettype() == type) {
      items[items.size] = def;
    }
  }

  if(items.size > 0) {
    return items[randomint(items.size)];
  }
}

function function_ae609287(pickupdef, origin) {
  if(!isDefined(pickupdef)) {
    return 0;
  }

  if(!namespace_ec06fe4a::function_a8975c67()) {
    return 0;
  }

  if([[pickupdef]] - > function_2c127eb5() > level.doa.roundnumber) {
    return 0;
  }

  if([[pickupdef]] - > function_b0378495() == 0) {
    return 0;
  }

  type = [[pickupdef]] - > gettype();

  if(type == 10 && level.doa.world_state != 4) {
    return 0;
  }

  if(type == 3 && isDefined(origin)) {
    if(is_true(level.doa.var_318aa67a)) {
      return 0;
    }

    var_d94778ea = getEntArray("a_pickup_item", "script_noteworthy");

    foreach(item in var_d94778ea) {
      if(!isDefined(item)) {
        continue;
      }

      thistype = [[item.pickup]] - > gettype();

      if(thistype === 3 || thistype === 5 || thistype === 4 || thistype === 40) {
        distsq = distancesquared(origin, item.origin);

        if(distsq < sqr(80)) {
          return 0;
        }
      }
    }
  }

  if(type == 42) {
    if(!isDefined(level.doa.var_182fb75a)) {
      return 0;
    }

    foreach(player in getplayers()) {
      if(is_true(player.doa.var_deaabc77)) {
        return 0;
      }
    }
  }

  if(type == 44) {
    if(is_true(level.doa.var_41adf604)) {
      return 0;
    }

    if(level.doa.roundnumber === 64 || level.doa.roundnumber === 65) {
      return 0;
    }

    if(isDefined(level.doa.var_54c5c3e6)) {
      return 0;
    }

    if(level.doa.var_4cfbc260 <= 1) {
      return 0;
    }
  }

  if(function_4821dfcf(type)) {
    if(isDefined(level.doa.var_182fb75a)) {
      return 0;
    }

    if(level.doa.var_4b491c02 > gettime()) {
      return 0;
    }
  }

  if(type == 39 && !isDefined(level.doa.var_182fb75a)) {
    return 0;
  }

  if(isDefined(origin)) {
    return validateorigin(origin);
  }

  return 1;
}

function function_4821dfcf(type) {
  if(type == 5 || type == 4 || type == 40) {
    return true;
  }

  return false;
}

function function_5bcfaaa1(type, player) {
  if(player hasdobj() == 0) {
    return false;
  }

  if(is_true(player.laststand)) {
    return false;
  }

  if(type == 1) {
    return true;
  }

  if(type == 13) {
    return true;
  }

  if(type == 32 || type == 33) {
    return false;
  }

  if(type == 8) {
    return (player.doa.score.bombs < player namespace_eccff4fb::function_4091beb5());
  }

  if(type == 14) {
    return (player.doa.score.keys < player namespace_eccff4fb::function_9d6bf0a9());
  }

  if(type == 9) {
    return (player.doa.score.boosts < player namespace_eccff4fb::function_fd3d9ee0());
  }

  if(type == 16) {
    return true;
  }

  if(isDefined(player.doa.vehicle) || is_true(player.usingvehicle)) {
    return false;
  }

  if(type == 39 && !isDefined(level.doa.var_182fb75a)) {
    return false;
  }

  if(type == 46 && player.doa.var_ccd8393c > 0) {
    return false;
  }

  if(type == 41 && is_true(player.doa.var_82fb5d17)) {
    return false;
  }

  if(type == 34) {
    var_1c446dd6 = namespace_ec06fe4a::function_38de0ce8();

    if(var_1c446dd6 >= 44) {
      return false;
    }
  }

  return true;
}

function function_f759a457() {
  return level.doa.var_50a26b4f;
}

function function_2ebebd0c() {
  self notify("41411da9073792ea");
  self endon("41411da9073792ea");
  self endon(#"death", #"hash_6749c13ce29143f7");
  self thread namespace_7da86f3c::function_77af9e81();
  wait 0.4;

  while(true) {
    waitresult = self waittill(#"hash_221d94db078860dd");
    player = waitresult.activator;
    type = [[self.def]] - > gettype();

    if(isPlayer(player)) {
      if(isDefined(self.var_54dddc17) && self.var_54dddc17 !== player) {
        continue;
      }

      if(isvehicle(player) && isDefined(player.owner) && isPlayer(player.owner) && !is_true(player.autonomous)) {
        player = player.owner;
      }

      if(!isPlayer(player)) {
        continue;
      }

      if(!isDefined(player.doa) || !isDefined(player.doa.score)) {
        continue;
      }

      if(!function_5bcfaaa1(type, player)) {
        continue;
      }
    }

    self.pickedup = 1;
    arrayremovevalue(level.doa.var_cc831548, self);
    var_2b2c2c96 = [[self.def]] - > function_c62ea2e6();

    if(isDefined(var_2b2c2c96)) {
      self namespace_e32bb68::function_ae271c0b(var_2b2c2c96);
    }

    var_5750296b = [[self.def]] - > function_526bfcd9();

    if(isDefined(var_5750296b)) {
      self namespace_e32bb68::function_3a59ec34(var_5750296b);
    }

    if(isai(player)) {
      player notify(#"picked_up", {
        #item: self
      });
      self function_4ecd84a8(player);
      self namespace_ec06fe4a::function_8c808737();

      if(isDefined(self.glowfx)) {
        self thread namespace_83eb6304::turnofffx(self.glowfx);
      }

      util::wait_network_frame();
      self notify(#"picked_up");
      self.pickup = undefined;
      return;
    }

    if(isDefined(self.var_2f0b512f)) {
      [[self.var_2f0b512f]](self);
    }

    if(isDefined(level.doa.var_d5e9e183)) {
      level[[level.doa.var_d5e9e183]](player, self, type);
    } else {
      switch (type) {
        case 1:
        case 13:
          player namespace_eccff4fb::function_9e8690e0(self, [[self.def]] - > getdata());
          self function_4ecd84a8(player);
          break;
        case 6:
          player namespace_6e90e490::showhint(3);
          player namespace_41cb996::function_6c4d9896([[self.def]] - > getname(), 1);
          break;
        case 15:
          if(isDefined(player.revives)) {
            player.revives++;
          }

          level thread namespace_9fc66ac::announce(31, 1 << player.entnum);
          player namespace_4ff32993::function_f69400ca(self.model);
          break;
        case 3:
          level thread namespace_9fc66ac::announce(37, 1 << player.entnum);
          player thread namespace_a4bedd45::function_1f704cee();
          break;
        case 4:
          level thread namespace_9fc66ac::announce(56, 1 << player.entnum);
          player thread namespace_6e90e490::function_47e11416(19);
          player namespace_6e90e490::showhint(2);
          level thread namespace_78792ce8::function_b974aa72(self.origin, player);
          break;
        case 5:
          level thread namespace_9fc66ac::announce(57, 1 << player.entnum);
          player thread namespace_6e90e490::function_47e11416(19);
          player namespace_6e90e490::showhint(2);
          level thread namespace_2889c797::function_9c1c5551(self.origin + (0, 0, 72), player);
          break;
        case 40:
          level thread namespace_9fc66ac::announce(42, 1 << player.entnum);
          player thread namespace_6e90e490::function_47e11416(19);
          player namespace_6e90e490::showhint(2);
          level thread namespace_56b772a5::function_ee81f2ca(self.origin, player);
          break;
        case 8:
          if(isDefined(player.doa.score)) {
            if(player.doa.score.bombs < player namespace_eccff4fb::function_4091beb5()) {
              if(!isDefined(self.var_54dddc17) && player namespace_1c2a96f9::function_8a19ece() && level.doa.var_6c58d51 > 0) {
                players = namespace_7f5aeb59::function_23e1f90f();

                foreach(guy in players) {
                  if(guy.doa.score.bombs < guy namespace_eccff4fb::function_4091beb5()) {
                    guy thread namespace_6e90e490::function_47e11416(4);
                    guy.doa.score.bombs++;
                    model = namespace_ec06fe4a::spawnmodel(self.origin, "zombietron_nuke");

                    if(isDefined(model)) {
                      model.angles = self.angles;
                      model setscale(self.scale);
                      model thread namespace_ec06fe4a::deletemeonnotify("movedone", 2.5);
                      model thread function_401a53c4(guy);
                    }
                  }
                }
              } else {
                player.doa.score.bombs++;
              }

              level thread namespace_9fc66ac::announce(28, 1 << player.entnum);
            }
          }

          self function_4ecd84a8(player);
          break;
        case 9:
          if(isDefined(player.doa.score)) {
            if(player.doa.score.boosts < player namespace_eccff4fb::function_fd3d9ee0()) {
              player.doa.score.boosts++;
              level thread namespace_9fc66ac::announce(27, 1 << player.entnum);
            }
          }

          self function_4ecd84a8(player);
          break;
        case 14:
          if(isDefined(player.doa.score)) {
            if(player.doa.score.keys < player namespace_eccff4fb::function_9d6bf0a9()) {
              player namespace_eccff4fb::function_6c15a74e();

              if(!isDefined(self.var_54dddc17)) {
                player thread namespace_6e90e490::function_47e11416(20, undefined, 1);
                level thread namespace_9fc66ac::announce(49, 1 << player.entnum);
              }
            }
          }

          self function_4ecd84a8(player);
          break;
        case 10:
          level thread namespace_9fc66ac::announce(41, 1 << player.entnum);
        case 12:
        case 46:
          player thread namespace_b754744b::function_b784c6bd(type);
          break;
        case 42:
          level thread namespace_9fc66ac::announce(43, 1 << player.entnum);
          player thread function_32370b0d();
          break;
        case 16:
          self namespace_ec06fe4a::function_8c808737();

          if(isDefined(self.var_54dddc17)) {
            player thread namespace_6e90e490::function_47e11416(4);

            if(player.doa.score.lives < player namespace_eccff4fb::function_77cbfb85()) {
              player.doa.score.lives++;
              level thread namespace_9fc66ac::announce(36, 1 << player.entnum);
            }
          } else {
            level thread namespace_9fc66ac::announce(36);
            players = namespace_7f5aeb59::function_23e1f90f();

            foreach(guy in players) {
              if(guy.doa.score.lives < guy namespace_eccff4fb::function_77cbfb85()) {
                guy thread namespace_6e90e490::function_47e11416(4);
                guy.doa.score.lives++;
                model = namespace_ec06fe4a::spawnmodel(self.origin, "zombietron_extra_life");

                if(isDefined(model)) {
                  model.angles = self.angles;
                  model setscale(self.scale);
                  model thread namespace_ec06fe4a::deletemeonnotify("movedone", 2.5);
                  model thread function_401a53c4(guy);
                }
              }
            }
          }

          break;
        case 17:
          level thread namespace_9fc66ac::announce(26, 1 << player.entnum);
          player thread namespace_bf41daf8::barrelupdate();
          break;
        case 18:
          level thread namespace_9fc66ac::announce(30, 1 << player.entnum);
          player thread namespace_dcd37093::function_d28e9b17();
          break;
        case 19:
          level thread namespace_9fc66ac::announce(46, 1 << player.entnum);
          player thread namespace_52ba5a8a::sawbladeupdate();
          break;
        case 20:
          level thread namespace_9fc66ac::announce(24, 1 << player.entnum);
          player namespace_41cb996::ui_menu_ftue_itemshop(8);
          player namespace_41cb996::function_d5bd34b4();
          break;
        case 21:
          level thread namespace_9fc66ac::announce(53, 1 << player.entnum);
          player thread namespace_6e90e490::function_47e11416(18);
          level thread function_2735024b();
          break;
        case 22:
          level thread namespace_9fc66ac::announce(47, 1 << player.entnum);
          level thread namespace_7fdfcd5b::function_86bd7962(player);
          break;
        case 45:
          level thread namespace_9fc66ac::announce(58, 1 << player.entnum);
          level thread namespace_7fdfcd5b::function_86bd7962(player, undefined, 0);
          break;
        case 11:
          level thread namespace_9fc66ac::announce(39, 1 << player.entnum);
          level thread namespace_14f8bd8f::function_32160152(player, "zombietron_gift_box", self.origin, self.angles, self.scale);
          break;
        case 23:
          level thread namespace_9fc66ac::announce(44, 1 << player.entnum);
          player thread namespace_6e90e490::function_47e11416(16);
          level thread namespace_7da86f3c::function_eeb092f5(player);
          break;
        case 24:
          level thread namespace_9fc66ac::announce(29, 1 << player.entnum);
          player thread namespace_7f5aeb59::function_a99cfd4f();
          break;
        case 25:
          level thread namespace_9fc66ac::announce(32, 1 << player.entnum);
          level thread namespace_e7f07a2a::timeshifterupdate(player, self.origin);
          break;
        case 26:
          level thread namespace_9fc66ac::announce(33, 1 << player.entnum);
          level thread namespace_ad27dfd8::function_8dbbde01(player, self.origin);
          break;
        case 27:
          level thread namespace_9fc66ac::announce(45, 1 << player.entnum);
          level thread namespace_e8bada13::function_a53db30e(player, self.origin);
          break;
        case 28:
          level thread namespace_9fc66ac::announce(51, 1 << player.entnum);
          player thread namespace_5f74ac47::function_f44fbe7c();
          break;
        case 29:
          level thread namespace_9fc66ac::announce(52, 1 << player.entnum);
          player thread namespace_9038b9d9::function_6ec0595a();
          break;
        case 30:
          level thread namespace_9fc66ac::announce(50, 1 << player.entnum);
          level thread namespace_b0e844dd::function_d275f769(player, self.origin);
          break;
        case 31:
          level thread namespace_9fc66ac::announce(40, 1 << player.entnum);
          player thread namespace_5d515bd5::function_60c2247c();
          break;
        case 34:
          level thread namespace_9fc66ac::announce(48, 1 << player.entnum);
          player thread namespace_6e90e490::function_47e11416(17);
          player thread namespace_545df111::function_90cdf7ba(type, self.origin);
          break;
        case 36:
        case 38:
        case 37:
          player namespace_41cb996::function_51e99bc7(2);
          self function_401a53c4(player);
          break;
        case 39:
          level notify(#"ladder_up", {
            #pickup: self
          });
          self notify(#"ladder_up");

          foreach(player in getplayers()) {
            player notify(#"hash_279998c5df86c04d");
            player thread namespace_7f5aeb59::turnplayershieldon();
          }

          break;
        case 41:
          level thread namespace_9fc66ac::announce(38, 1 << player.entnum);
          player.doa.var_82fb5d17 = 1;
          player namespace_6e90e490::showhint(5);
          break;
        case 43:
          level thread namespace_9fc66ac::announce(54, 1 << player.entnum);
          level thread zombie_vortex::start_timed_vortex(2, self.origin, 128, 128, player);
          break;
        case 44:
          level thread namespace_9fc66ac::announce(25, 1 << player.entnum);
          level thread namespace_6d0b8a1a::function_465aaf09(player, self.origin);
          break;
        default:
          assert(0, "<dev string:x91>");
          break;
      }
    }

    self namespace_ec06fe4a::function_8c808737();

    if(isDefined(self.glowfx)) {
      self thread namespace_83eb6304::turnofffx(self.glowfx);
    }

    util::wait_network_frame();
    self notify(#"unlink");
    self notify(#"picked_up");
    self.pickup = undefined;
    return;
  }
}

function function_d936944a() {
  time = gettime();

  if(self.doa.var_6b4163f1 > time) {
    return;
  }

  if(!is_true(self.doa.var_c026f7c9)) {
    self.doa.var_6b4163f1 = time + 250;
  } else {
    self.doa.var_6b4163f1 = time;
  }

  if(level.doa.var_cc831548.size) {
    arrayremovevalue(level.doa.var_cc831548, undefined, 0);
    self.doa.var_ad888d1f = arraysortclosest(level.doa.var_cc831548, self.origin, 16, 0, 1024);
    return;
  }

  self.doa.var_ad888d1f = [];
}

function function_cbae9ca3() {
  if(self.doa.var_ad888d1f.size == 0) {
    return;
  }

  playerx = self.origin[0];
  playery = self.origin[1];
  playerz = self.origin[2];

  if(isDefined(self.doa.vehicle) && isDefined(self.doa.var_baad518e)) {
    playerz = self.doa.var_baad518e[2];
  }

  playerh = 72;
  playerw = 25;
  var_b2876baf = playerz + playerh;
  var_4eae5a61 = playerx - playerw;
  playerright = playerx + playerw;
  var_a2eaa855 = playery - playerw;
  var_ec175a2f = playery + playerw;

  foreach(pickup in self.doa.var_ad888d1f) {
    if(!isDefined(pickup)) {
      continue;
    }

    if(false) {
      pickup thread namespace_1e25ad94::function_e8f2d12c(pickup.origin + (0, 0, -16), pickup.radius, pickup.height, 1, (0, 0, 1));
    }

    var_f0dd222e = pickup.height;
    pickupz = pickup.origin[2] - 16;

    if(pickupz + var_f0dd222e < playerz || pickupz - var_f0dd222e > var_b2876baf) {
      continue;
    }

    var_ed781dc = pickup.radius;
    var_acf65447 = pickup.origin[0];
    minx = var_acf65447 - var_ed781dc;
    maxx = var_acf65447 + var_ed781dc;

    if(maxx < var_4eae5a61 || minx > playerright) {
      continue;
    }

    var_7fe7fa2b = pickup.origin[1];
    minx = var_7fe7fa2b - var_ed781dc;
    maxx = var_7fe7fa2b + var_ed781dc;

    if(maxx < var_a2eaa855 || minx > var_ec175a2f) {
      continue;
    }

    pickup notify(#"hash_221d94db078860dd", {
      #activator: self
    });
  }
}

function function_594c2e4e() {
  self endon(#"death");
  self.origin += (0, 0, 12);
  self thread namespace_ec06fe4a::function_f506b4c7();
  self thread namespace_ec06fe4a::function_8b1ae345(undefined, 12, "stopIdle");
  self waittill(#"hash_221d94db078860dd");
  self notify(#"stopidle");
}

function function_a12517b() {
  self endon(#"death");
  self waittill(#"stopidle");

  if(is_true(self.var_9ca559f5)) {
    self clientfield::set("pickuprotate", 0);
  }
}

function pickuprotate() {
  self endon(#"death", #"stopidle");

  if(is_true(self.var_9ca559f5)) {
    util::wait_network_frame();
    self thread function_a12517b();
    self clientfield::set("pickuprotate", 1);
    return;
  }

  dir = 180;

  if(randomint(100) > 50) {
    dir = -180;
  }

  time = randomfloatrange(3, 7);

  while(isDefined(self)) {
    self rotateto(self.angles + (0, dir, 0), time);
    wait time;
  }
}

function function_4ecd84a8(player, entnum = player.entnum, var_a3046af4, time = 2) {
  self endon(#"death");
  self notify(#"picked_up");
  self notify(#"unlink");
  waitframe(1);

  if(isDefined(self)) {
    if(!isDefined(var_a3046af4)) {
      if(isDefined(player) && isPlayer(player)) {
        x = 2000;
        y = 3000;
        z = 1000;

        if(is_true(level.doa.var_ecff3871)) {
          x = 0 - x;
          y = 0 - y;
        }

        var_a3046af4 = player.origin;

        if(entnum == 0 || entnum > 3) {} else if(entnum == 1) {
          y = 0 - y;
        } else if(entnum == 2) {
          x = 0 - x;
        } else if(entnum == 3) {
          y = 0 - y;
          x = 0 - x;
        }

        var_a3046af4 += (x, y, z);
      } else {
        var_a3046af4 = self.origin + (0, 0, 3000);
      }
    }

    self function_469baf4a();

    if(is_true(self.var_9ca559f5)) {
      entmask = 0;

      if(isDefined(player) && isPlayer(player)) {
        entmask = 1 + player.entnum << 1;
        val = entmask + 1;
      } else {
        val = 15;
      }

      self clientfield::set("pickupmoveto", val);
    } else {
      self moveto(var_a3046af4, time, 0, 0);
    }

    wait time;
  }
}

function function_401a53c4(player) {
  self endon(#"death");

  if(isDefined(self)) {
    if(isDefined(player)) {
      var_bead1873 = 13500;
      topy = 30000;
      var_d7e22d96 = 20000;
      bottomy = 30000;

      if(is_true(level.doa.var_ecff3871)) {
        var_bead1873 *= -1;
        topy *= -1;
        var_d7e22d96 *= -1;
        bottomy *= -1;
      }

      var_a3046af4 = player.origin;

      if(player.entnum == 0) {
        offset = (var_bead1873, topy, 10000);
      } else if(player.entnum == 1) {
        offset = (var_bead1873, topy * -1, 10000);
      } else if(player.entnum == 2) {
        offset = (var_d7e22d96 * -1, bottomy, 10000);
      } else if(player.entnum == 3) {
        offset = (var_d7e22d96 * -1, bottomy * -1, 10000);
      }

      var_a3046af4 += offset;
    } else {
      var_a3046af4 = self.origin + (0, 0, 3000);
    }

    self function_4ecd84a8(player, undefined, var_a3046af4, 20);
  }
}

function function_2cfd5616(var_35526169) {
  if(isDefined(self.popup) && self.popup == 0) {
    self thread pickuprotate();
    return;
  }

  if(!isDefined(var_35526169)) {
    target_point = self.origin + (randomfloatrange(-0.1, 0.1), randomfloatrange(-0.1, 0.1), 20);
  } else {
    target_point = self.origin + var_35526169;
  }

  self solid();
  vel = target_point - self.origin;
  self.origin += 4 * vel;
  vel *= randomfloatrange(0.5, 3);
  self physicslaunch(self.origin, vel);
}

function function_2c64b1c7() {
  data = [[self.pickup]] - > getdata();
  self.scale = (data & 65535) / 65535 * 10;
  self.popup = data >> 16;
  self setscale(self.scale);
  self.var_d34e5888 = self.scale * 2;

  if(self.scale == 10) {
    self.var_d34e5888 += 50;
  }

  self solid();
}

function function_93de1cd5() {
  if(is_true(self.var_9ca559f5)) {
    self clientfield::set("pickupvisibility", 1);
    return;
  }

  self ghost();
}

function function_469baf4a() {
  if(is_true(self.var_9ca559f5)) {
    self clientfield::set("pickupvisibility", 0);
    return;
  }

  self namespace_ec06fe4a::function_4f72130c();
}

function function_c2b49bb2() {
  self endon(#"death");
  self waittill(#"hash_2a866f50cc161ca8");

  if(is_true(self.var_9ca559f5)) {
    self clientfield::set("pickuptimeout", 0);
  }
}

function pickuptimeout(timetowait) {
  if(timetowait <= 0) {
    return;
  }

  self endon(#"death", #"hash_2a866f50cc161ca8");
  wait randomint(5);

  if(is_true(level.doa.var_dcb11150)) {
    return;
  }

  if(is_true(self.var_9ca559f5)) {
    self clientfield::set("pickuptimeout", 1);
    self thread function_c2b49bb2();
  }

  wait timetowait;

  for(i = 0; i < 40; i++) {
    if(!isDefined(self)) {
      break;
    }

    if(isDefined(self.var_b20c0bc5)) {
      [[self.var_b20c0bc5]](i % 2);
    } else if(!is_true(self.var_9ca559f5)) {
      if(i % 2) {
        self function_93de1cd5();
      } else {
        self function_469baf4a();
      }
    }

    if(i < 15) {
      wait 0.5;
      continue;
    }

    if(i < 25) {
      wait 0.25;
      continue;
    }

    wait 0.1;
  }

  var_2b2c2c96 = [[self.def]] - > function_c62ea2e6();

  if(isDefined(var_2b2c2c96)) {
    self namespace_e32bb68::function_ae271c0b(var_2b2c2c96);
  }

  var_779128e2 = [[self.def]] - > function_cd066492();

  if(isDefined(var_779128e2)) {
    self namespace_e32bb68::function_3a59ec34(var_779128e2);
    util::wait_network_frame();
  }

  self notify(#"pickup_timeout");
  wait 0.2;

  if(isDefined(self) && !is_true(self.nodelete)) {
    self.pickup = undefined;
  }
}

function function_18372b20() {
  function_19fa261e();

  foreach(orb in level.doa.active_attractors) {
    if(isDefined(orb)) {
      orb delete();
    }
  }

  function_b950ecde();
  level.doa.active_attractors = [];
  level.doa.var_4b491c02 = 0;
}

function function_19fa261e() {
  level notify(#"hash_1dcd524f9d61c731");
  util::wait_network_frame();
  var_d94778ea = getEntArray("a_pickup_item", "script_noteworthy");

  for(i = 0; i < var_d94778ea.size; i++) {
    item = var_d94778ea[i];

    if(isDefined(item)) {
      item.pickup = undefined;
    }
  }

  level notify(#"hash_7eba5f3243b496b8");
}

function function_69cafbe0() {
  var_d94778ea = getEntArray("a_pickup_item", "script_noteworthy");
  return var_d94778ea.size;
}

function function_2735024b() {
  ent = namespace_ec06fe4a::spawnmodel((0, 0, 0));

  if(isDefined(ent)) {
    ent namespace_e32bb68::function_3a59ec34("evt_doa_pickup_umbrella_storm_2d_lp");
  }

  amount = randomintrange(namespace_7f5aeb59::function_23e1f90f().size * 3 + 4, namespace_7f5aeb59::function_23e1f90f().size * 5 + 6);

  while(amount) {
    if(isDefined(level.doa.var_39e3fa99)) {
      spot = [[level.doa.var_39e3fa99]] - > function_70fb5745().origin;
      spot += (0, 0, 1000);
      function_b8f6a8cd(undefined, spot, 1);
      amount--;
      wait randomintrange(1, 3);
      continue;
    }

    break;
  }

  if(isDefined(ent)) {
    ent namespace_e32bb68::function_ae271c0b("evt_doa_pickup_umbrella_storm_2d_lp");
    ent namespace_e32bb68::function_3a59ec34("evt_doa_pickup_umbrella_storm_2d_end");
    ent thread namespace_ec06fe4a::function_52afe5df(1);
  }
}

function function_32370b0d(timeout = 120) {
  timeout = self namespace_1c2a96f9::function_4808b985(timeout);
  timeleft = gettime() + timeout * 1000;
  self.doa.var_d320bb5d = timeleft - 15000;

  if(isDefined(self.doa.var_ad639ebd)) {
    return;
  }

  self.doa.var_ad639ebd = namespace_ec06fe4a::spawnmodel(self.origin, "tag_origin", self.angles, "player lanternOrg");

  if(isDefined(self.doa.var_ad639ebd)) {
    self.doa.var_ad639ebd thread namespace_ec06fe4a::function_d55f042c(self, "lantern_terminated");
  }

  self.doa.var_ad639ebd linkto(self);
  self endon(#"lantern_terminated", #"disconnect");
  self.doa.var_ad639ebd namespace_83eb6304::turnofffx("lantern_fade");
  self.doa.var_ad639ebd namespace_83eb6304::function_3ecfde67("lantern");

  while(gettime() < self.doa.var_d320bb5d && !is_true(self.laststand)) {
    wait 1;
  }

  if(!is_true(self.laststand)) {
    self namespace_83eb6304::function_3ecfde67("lantern_fade");
  }

  self.doa.var_ad639ebd namespace_83eb6304::turnofffx("lantern");
  self.doa.var_ad639ebd delete();
  self.doa.var_ad639ebd = undefined;
}