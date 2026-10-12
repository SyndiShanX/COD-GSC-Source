/**************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_jup_bigmap\mp_jup_bigmap_ob.gsc
**************************************************************/

#using script_1107d6250762b72b;
#using script_1342099cdbdb5641;
#using script_137b22598c1ad811;
#using script_13eadf38c1765896;
#using script_1404745c166293f3;
#using script_145988baae67fded;
#using script_147577981b989310;
#using script_16d4334743faa893;
#using script_184b38de3c45592;
#using script_1bed1c59f6ac9525;
#using script_1c4e7ceadc8c8367;
#using script_2047cdbf5176ba0;
#using script_20ec388dddf52c04;
#using script_221e4f7ccdd70004;
#using script_222f62686867436a;
#using script_22ab685624290457;
#using script_2322b42c4dbbfaf0;
#using script_277259cfc5f60311;
#using script_2816a042b9f7996;
#using script_2878b0fb2a3cab6;
#using script_2a034f13291a84e;
#using script_2a73cf62256b4021;
#using script_2b1265118e6716f1;
#using script_2b15a0bac31ce30;
#using script_2d28a28173247bad;
#using script_2d709776a2721cc1;
#using script_2e0d8cb6cbb13e4d;
#using script_2f13226050ca9657;
#using script_3144ea076c4e15d5;
#using script_31b70210f1726bd2;
#using script_321340ad43fc7adf;
#using script_3351a966a784edc0;
#using script_3528ab11b04f7bac;
#using script_35658e6ec63e0a84;
#using script_358f9185e1be9115;
#using script_360bdc3db602212b;
#using script_369ec26a4522e639;
#using script_36b7b4e4089e73a3;
#using script_3a1fff407627c77b;
#using script_4112b9259c9e0b23;
#using script_4178611df309502c;
#using script_43ff2abb883f6e70;
#using script_46e6439866901eb5;
#using script_479c151825f9bd25;
#using script_497daeb2d962570d;
#using script_4b719cd8c8fde14c;
#using script_4c1b5c23b42630d0;
#using script_525d800963056427;
#using script_528320cb3630530d;
#using script_562c63b9ec124fc2;
#using script_569b2ddf002e61a3;
#using script_59d78740cd3cf59f;
#using script_5afc75cfb0ab3afb;
#using script_5cc103e78831ad9f;
#using script_5d7db869db3bbbd2;
#using script_5d813d45c6b1b1be;
#using script_5f1c5742c93821a4;
#using script_61f40b593adbb56b;
#using script_624397dc74b139e0;
#using script_627452def335a90b;
#using script_62a4f7a62643fe8;
#using script_65d738fd8a2862a5;
#using script_69a720c9d6e76eaf;
#using script_6c49326fa248a5f;
#using script_6cacd83c740d5239;
#using script_6ccb901b5b948f50;
#using script_6dc57213a3e095eb;
#using script_704ba57fc06b1040;
#using script_71eca06c29041e9e;
#using script_7245d37edd0c3aa9;
#using script_732954a6c48898ac;
#using script_7479df52350a3e0;
#using script_74ac33cd58178715;
#using script_753b4a4b3342bfeb;
#using script_77160c42302194c7;
#using script_77cff22e154e94df;
#using script_79de05378402bed1;
#using script_7b1a097c3912e1bb;
#using script_7b492ad38de0100d;
#using script_7b9e48f3351e24e7;
#using script_7cb35f89ed0ca240;
#using script_7d2eb9bc7e01ecaf;
#using script_7dc8e85b881c90f9;
#using script_7ff1c5399d2d9500;
#using script_893e61d2d5b599;
#using script_91e5727a9d1442d;
#using script_92b815b18f0ba61;
#using script_9b5cabd1a0468a9;
#using script_9ceb376db23527;
#using script_abd44f8525c25c2;
#using script_b887ac99ebc3e1f;
#using script_badad75eef11559;
#using script_bce65b6f60fa5a1;
#using script_df078f814c869a1;
#using script_fc3b3ba6dd4e0ce;
#using scripts\common\callbacks;
#using scripts\cp_mp\agents\ai_spawn_director;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\utility;
#namespace mp_jup_bigmap_ob;

function autoexec init() {
  level.var_cd52e517ad96566d = &main;
}

function main() {
  level thread cleanup_map();
  level callback::add("register_activities", &function_d0ffb4e404349b30);
  level callback::add("register_objectives", &function_83ecb01b31530309);
  level callback::add("register_features", &function_c4ca7f1cd743b5d2);
  function_70ed29a8f9257bb3();
  namespace_d38a1af3e02dea2f::function_48e697a59457ec45();
  namespace_9300a7e57b81fb7a::main();
  namespace_7535ac2674e02eca::main();
  namespace_1aa66c587558caa6::main();
  namespace_4be0f30df9c8e846::main();
  namespace_eaf2d79326b082fa::main();
  namespace_a8cf1dfd1cca638a::main();
  namespace_48ff7197845e919e::main();
  namespace_c8b461a622dcfe::main();
  namespace_686a0ecf75007cca::main();
  namespace_92f8a210c3f60bd9::main();
  namespace_c670458343d549::main();
  namespace_644f62ff38e6df05::main();
  namespace_22ec60f51e713465::main();
  namespace_46bab6a1c7f2b759::main();
  namespace_9a0d4e1a2d76ab09::main();
  namespace_68e5e24beb101ffd::main();
  namespace_d5ad875f8028fe1d::main();
  namespace_ebb067ffc73349::main();
  namespace_c1984ad5d2c85b81::main();
  namespace_33b40b2604afd299::main();
  namespace_2469fcf354bc890d::main();
  namespace_9661b1840de4663d::main();
  namespace_168ecff99ee1ba99::main();
  namespace_e999d8dfe317a9c1::main();
  namespace_2ca3dad2d6898e0d::main();
  namespace_db64ae640647c5cd::main();
  namespace_f2713faa50431351::main();
  scripts\engine\utility::flag_set("gas_station_create_script_initialized");
  namespace_981841431137dfcc::main();
  namespace_e03919da9578d3dc::main();
  namespace_2fd4af9f8020b5a0::main();
  namespace_a6c913548fa9600::main();
  namespace_900b5c2f06237e4c::main();
  namespace_7a1eecd8c2a5b9c::main();
  namespace_f19749db1ea23f08::main();
  namespace_bf8452379047a828::main();
  namespace_9e7d5c0658c6dddc::main();
  thread namespace_6776e8e74ed64842::init();

  if(getDvar(@ "hash_dffbbb2b70b78aee", "0") == "1") {
    function_3dfc24cbac6795be();
  } else {
    thread function_a39aa470df6cd578();
  }

  if(getDvar(@ "hash_6e5464e5ee3bd77d", "1") == "1") {
    function_9fb88526b60e2e45();
  } else {
    thread function_6ad85f8d5c683ce4();
  }

  if(getDvar(@ "hash_6ffd9adb060c50c9", "0") == "1") {
    function_78795efa67a421b();
  } else {
    thread function_67ce1aff066faf12();
  }

  thread function_cc66dbf966dfae8a();
  thread function_ce4bae9d68c21731();
  level thread function_bc95ea3a25ee0024();

  if(getdvarint(@ "hash_f0651f120dc9412d", 0)) {
    namespace_8f52b12ca3af49b1::main();
    namespace_609a42b1d504aad6::quest_init();
  } else {
    namespace_609a42b1d504aad6::clip_handler();
  }

  if(getdvarint(@ "hash_f0651c120dc93a94", 0)) {
    namespace_6d31e91c26415292::main();
    namespace_609a41b1d504a8a3::function_429e921f8ad411ff();
  }

  if(getdvarint(@ "hash_f0651d120dc93cc7", 0)) {
    namespace_25a0f0fe5a85d32b::main();
    namespace_609a40b1d504a670::quest_act3_init();
  } else {
    namespace_609a40b1d504a670::function_aa1b5db86c89322d(0);
  }

  if(getdvarint(@ "hash_c5b7e4fbc3c4ae1a", 0) == 1) {
    namespace_c7a042a866083b3e::main();
    namespace_212266c75b256f0e::main();
    namespace_8f0ca3b07985e0b2::main();
    namespace_1469258a73fe4c92::main();
    namespace_30cb5b88514b09be::main();
    namespace_a242de5912325773::main();
    namespace_a124517d0940760a::main();
    namespace_339d4216c02163aa::main();
    namespace_9b600bf111be390e::main();
    thread namespace_fc8edd9c56ed42bb::main();
  }

  createnavlink("red_zone_emergency_link_1", (6642, 30, 2099), (6720, 62, 2300));
  createnavlink("red_zone_emergency_link_2", (6720, 62, 2300), (6642, 30, 2099));
  createnavlink("tile_a_emergency_link_1", (-31176, 27956, 1434), (-31263, 28030, 1582));
  createnavlink("tile_a_emergency_link_1", (-31993, 27646, 1434), (-32093, 27607, 1588));
}

function private cleanup_map() {
  for(index = 1; index < 13; index++) {
    number = "";

    if(index < 10) {
      number += "0";
    }

    number += index;
    train = "train_jup_" + number;
    entity = getEnt(train, "script_noteworthy");

    if(isDefined(entity)) {
      entity delete();
    }

    entity = getEnt(train + "_train_front_hurt", "script_noteworthy");

    if(isDefined(entity)) {
      entity delete();
    }

    entity = getEnt(train + "_train_rear_hurt", "script_noteworthy");

    if(isDefined(entity)) {
      entity delete();
    }

    entity = getEnt("train_jup_model_" + number, "script_noteworthy");

    if(isDefined(entity)) {
      entity delete();
    }
  }

  waitframe();
  entity = getEnt("train_jump_ramp", "script_noteworthy");

  if(isDefined(entity)) {
    entity delete();
  }

  mapname = getmapname();

  if(isDefined(mapname)) {
    if(mapname == "mp_jup_bigmap") {
      entitynames = ["clip_zombie_container", "clip_zombie_container_opening", "clip_zombie_container_door", "clip_zombie_container_floor"];

      foreach(entityname in entitynames) {
        entities = getEntArray(entityname, "targetname");

        for(index = 0; index < entities.size; index++) {
          entities[index] delete();
        }
      }

      waitframe();
    }
  }
}

function function_a39aa470df6cd578() {
  while(true) {
    if(getDvar(@ "hash_dffbbb2b70b78aee", "0") == "1") {
      function_3dfc24cbac6795be();
      return;
    }

    wait 2;
  }
}

function function_3dfc24cbac6795be() {
  namespace_4597ddd9bb212a8d::main();
  namespace_41e286eb58854fdd::main();
  namespace_e24377ec41c40379::main();
  namespace_b4e88912baf6dbd9::main();
  namespace_9d8a0d87664fb20d::main();
  namespace_783ecb4f239cb69d::main();
  namespace_80a6cea44cc77a91::main();
  namespace_c57b756a50b879b1::main();
  namespace_3516e99458a59ddd::main();
  thread namespace_a07f20e9740e52::init();
}

function function_6ad85f8d5c683ce4() {
  while(true) {
    if(getDvar(@ "hash_6e5464e5ee3bd77d", "0") == "1") {
      function_9fb88526b60e2e45();
      return;
    }

    wait 2;
  }
}

function function_9fb88526b60e2e45() {
  namespace_7d12a25cf603c57b::main();
  namespace_76dff16242afc74b::main();
  namespace_1909e1088cfbc807::main();
  namespace_ba51c223aee60827::main();
  namespace_7505bd48eaef63fb::main();
  namespace_b5c9c60f5f50fa0b::main();
  namespace_cb801b91b274f79f::main();
  namespace_cedbec4febf11dff::main();
  namespace_3524338e05fdd14b::main();
  thread namespace_d0c78bdaf71b04f6::init();
}

function function_67ce1aff066faf12() {
  while(true) {
    if(getDvar(@ "hash_6ffd9adb060c50c9", "0") == "1") {
      function_78795efa67a421b();
      return;
    }

    wait 2;
  }
}

function function_78795efa67a421b() {
  namespace_63e54e5e8c51a163::main();
  namespace_6200cd97cd5820b3::main();
  namespace_e8816c886fe0a5f7::main();
  namespace_58885d92b6809057::main();
  namespace_17c4e2e0152618e3::main();
  namespace_b543cbaf1e32456f::main();
  namespace_215b3df3d99b060f::main();
  namespace_5b92d94106f62eb3::main();
  thread namespace_d7e80b14e1130dc4::init();
}

function function_bc95ea3a25ee0024() {
  if(!getdvarint(@ "hash_53e8929882e78ac6", 1)) {
    return;
  }

  if(getdvarint(@ "hash_6dfc320987b819", 0)) {
    var_dabe5dc8a76998e8 = ["vehicle_group_a", "vehicle_group_b", "vehicle_group_c", "vehicle_group_d", "vehicle_group_e", "vehicle_group_f", "vehicle_group_g", "vehicle_group_h", "vehicle_group_i"];
    a_s_spawns = [];

    foreach(vehicle_group in var_dabe5dc8a76998e8) {
      var_43392d5f952613b6 = getStructArray(vehicle_group, "script_noteworthy");
      a_s_spawns = array_combine(a_s_spawns, namespace_f9b6a4254d2d8100::function_48f13f47907a7e67(var_43392d5f952613b6));
      waitframe();
    }
  } else {
    a_s_spawns = namespace_f9b6a4254d2d8100::function_c7028a51e2858e73();
  }

  level.var_eacc36c62b779c30 = a_s_spawns;

  if(a_s_spawns.size > 0 && isDefined(level.var_c383b967aa7e551b)) {
    [[level.var_c383b967aa7e551b]]("vehicle", a_s_spawns, &namespace_f9b6a4254d2d8100::spawn_vehicle);
  }

  callback::callback("ob_vehicles_create_script_done");
}

function function_ce4bae9d68c21731() {
  waitframe();
  function_9b8829ab4092a7d7("ob_zombie_ambient", 1);
  setDvar(@ "hash_f1d095735ac37f33", 1);
}

function function_cc66dbf966dfae8a() {
  namespace_38c12a9e6798f1cb::function_f2a6094e2bc9028();
  namespace_cd249032b49ee5a3::function_54df6f4695546973();
  namespace_dd1b81793708120f::function_23e93ef99a6c16e2();
  namespace_26354c9b66d272ff::function_dc9fcecace9cff65();
  namespace_26f5b9f025c6ef83::function_678622c552cadad4();
  namespace_b2033386a8301a0b::function_4486c88d950ef33f();
  namespace_f14d97da70ba358f::function_95dc47abc9ef28ae();
  namespace_dd96b963491cdbaf::function_ff6d5421a485cc11();
  namespace_722ce752470892b::function_699dd374c113c360();
  scripts\cp_mp\agents\ai_spawn_director::process_create_script();
}