/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_7eab314a5c18ea10.gsc
*************************************************/

#using script_17dc47fb18ded931;
#using script_185660037b9236c1;
#using script_2707474774db34b;
#using script_33135cb7affb7992;
#using script_39d11000e476a42a;
#using script_3d3d1ef33cecfb62;
#using script_41387eecc35b88bf;
#using script_482376d10f69832c;
#using script_5815a7cb4d944542;
#using script_5f71ed065b9cea1e;
#using script_6b684505b9959a08;
#using script_6d16894933fe11bb;
#using scripts\common\devgui;
#using scripts\cp_mp\loot\common_cache;
#using scripts\cp_mp\loot\common_item;
#using scripts\engine\utility;
#namespace namespace_e190ad01ec038043;

function function_3424378c10c301fb() {
  function_6bbe26534b23bb81();
  thread function_a5dc5dd6143b0c2e();
}

function private function_6bbe26534b23bb81() {
  devgui::function_6e7290c8ee4f558b("<dev string:x1c>");
  devgui::function_a9a864379a098ad6("<dev string:x3a>", "<dev string:x62>", &function_17cdab7c9e667af1, 1);
  devgui::function_a9a864379a098ad6("<dev string:x80>", "<dev string:xaf>", &function_5999bbd46eb60a67, 1);
  devgui::function_a9a864379a098ad6("<dev string:xdf>", "<dev string:x113>", &function_ee7d561776755da0, 1);
  devgui::function_fe953f000498048f();
  devgui::function_6e7290c8ee4f558b("<dev string:x134>");
  devgui::function_a9a864379a098ad6("<dev string:x15f>", "<dev string:x191>", &function_1d6fde9c84af8229);
  devgui::function_a9a864379a098ad6("<dev string:x1c1>", "<dev string:x1db>", &function_92f87dba4058fb48);
  devgui::function_a9a864379a098ad6("<dev string:x203>", "<dev string:x21d>", &function_c914b873f680b584);
  devgui::function_a9a864379a098ad6("<dev string:x23e>", "<dev string:x25b>", &function_a9d48cab10e470f0);
  devgui::function_a9a864379a098ad6("<dev string:x282>", "<dev string:x293>", &function_ec623faf77071b55);
  devgui::function_fe953f000498048f();
  devgui::function_6e7290c8ee4f558b("<dev string:x2b0>");
  devgui::function_a9a864379a098ad6("<dev string:x2ea>", "<dev string:x31b>", &function_5cf355e8a2e39acf, 1);
  devgui::function_a9a864379a098ad6("<dev string:x351>", "<dev string:x37b>", &function_b58335ee87dc0782, 1);
  devgui::function_fe953f000498048f();
  devgui::function_6e7290c8ee4f558b("<dev string:x3ac>");
  devgui::function_b23a59dfb4ca49a1("<dev string:x3f5>", "<dev string:x417>", &function_54f49ba0c0e779a8, 1);
  devgui::function_b23a59dfb4ca49a1("<dev string:x454>", "<dev string:x483>", &function_3e599a727dc23cff, 1);
  devgui::function_fe953f000498048f();
  devgui::function_6e7290c8ee4f558b("<dev string:x4c8>");
  devgui::function_a9a864379a098ad6("<dev string:x506>", "<dev string:x535>", &function_8d27329ae0daf827, 1);
  devgui::function_a9a864379a098ad6("<dev string:x558>", "<dev string:x587>", &function_b00d1f4332da2f82, 1);
  devgui::function_b23a59dfb4ca49a1("<dev string:x5ad>", "<dev string:x5d1>" + "<dev string:x5f0>", &function_45447176e70e6964, 1);
  devgui::function_b23a59dfb4ca49a1("<dev string:x606>", "<dev string:x5d1>" + "<dev string:x62c>", &function_45447176e70e6964, 1);
  devgui::function_b23a59dfb4ca49a1("<dev string:x644>", "<dev string:x5d1>" + "<dev string:x669>", &function_45447176e70e6964, 1);
  devgui::function_a9a864379a098ad6("<dev string:x680>", "<dev string:x6b6>", &function_698216eddc4dcd80, 1);
  devgui::function_a9a864379a098ad6("<dev string:x6de>", "<dev string:x711>", &function_f29e71bce0677ffa, 1);
  devgui::function_a9a864379a098ad6("<dev string:x736>", "<dev string:x769>", &function_24afaf27f07f9eaf, 1);
  devgui::function_fe953f000498048f();
  devgui::function_6e7290c8ee4f558b("<dev string:x78e>");
  devgui::function_b23a59dfb4ca49a1("<dev string:x7d9>", "<dev string:x7fb>" + 6, &function_da8dd7e0115a7063, 1);
  devgui::function_b23a59dfb4ca49a1("<dev string:x827>", "<dev string:x852>" + 6, &function_da8dd7e0115a7063, 1);
  devgui::function_b23a59dfb4ca49a1("<dev string:x87e>", "<dev string:x8ab>" + 6, &function_da8dd7e0115a7063, 1);
  devgui::function_b23a59dfb4ca49a1("<dev string:x8db>", "<dev string:x7fb>" + 7, &function_da8dd7e0115a7063, 1);
  devgui::function_b23a59dfb4ca49a1("<dev string:x8fb>", "<dev string:x852>" + 7, &function_da8dd7e0115a7063, 1);
  devgui::function_b23a59dfb4ca49a1("<dev string:x924>", "<dev string:x94e>" + 7, &function_da8dd7e0115a7063, 1);
  devgui::function_b23a59dfb4ca49a1("<dev string:x980>", "<dev string:x7fb>" + 5, &function_da8dd7e0115a7063, 1);
  devgui::function_b23a59dfb4ca49a1("<dev string:x9aa>", "<dev string:x852>" + 5, &function_da8dd7e0115a7063, 1);
  devgui::function_b23a59dfb4ca49a1("<dev string:x9dd>", "<dev string:xa12>" + 5, &function_da8dd7e0115a7063, 1);
  devgui::function_fe953f000498048f();
  devgui::function_6e7290c8ee4f558b("<dev string:xa45>");
  devgui::function_a9a864379a098ad6("<dev string:xa71>", "<dev string:xa97>", &function_873ab38b86db5af6);
  devgui::function_a9a864379a098ad6("<dev string:xaaf>", "<dev string:xac8>", &function_1b049047564ba81f);
  devgui::function_a9a864379a098ad6("<dev string:xadf>", "<dev string:xaf9>", &function_e0aeb6bf6a39a440);
  devgui::function_a9a864379a098ad6("<dev string:xb10>", "<dev string:xb2e>", &function_b6a7c1b7984c9819);
  devgui::function_a9a864379a098ad6("<dev string:xb49>", "<dev string:xb65>", &function_4a0df56ed43e0bbb);
  devgui::function_a9a864379a098ad6("<dev string:xb7e>", "<dev string:xb9b>", &function_f569e14f7ec1cd87);
  devgui::function_a9a864379a098ad6("<dev string:xbb5>", "<dev string:xbce>", &function_ff21ac1bf3912ce7);
  devgui::function_a9a864379a098ad6("<dev string:xbe4>", "<dev string:xc08>", &function_ac2b833e8fa2bd3e);
  devgui::function_fe953f000498048f();
  devgui::function_6e7290c8ee4f558b("<dev string:xc28>");
  devgui::function_a9a864379a098ad6("<dev string:xc6b>", "<dev string:xc99>", &function_3583d52b2b2d8866);
  devgui::function_a9a864379a098ad6("<dev string:xcc0>", "<dev string:xcef>", &function_ee2b27cbec4d7d91);
  devgui::function_fe953f000498048f();
  devgui::function_6e7290c8ee4f558b("<dev string:xd17>");
  devgui::function_a9a864379a098ad6("<dev string:xd6d>", "<dev string:xd9d>", &function_80769efb00130194);
  devgui::function_a9a864379a098ad6("<dev string:xdc8>", "<dev string:xdf9>", &function_8d13377b510a0d07);
  devgui::function_a9a864379a098ad6("<dev string:xe25>", "<dev string:xe56>", &function_fa399987cca698bf);
  devgui::function_fe953f000498048f();
  devgui::function_6e7290c8ee4f558b("<dev string:xe6f>");
  devgui::function_a9a864379a098ad6("<dev string:xedb>", "<dev string:xef5>", &function_2af907e3a31b7e83);
  devgui::function_a9a864379a098ad6("<dev string:xf0f>", "<dev string:xf2a>", &function_722e153f02e13ef2);
  devgui::function_fe953f000498048f();
  devgui::function_6e7290c8ee4f558b("<dev string:xf45>");
  devgui::function_a9a864379a098ad6("<dev string:xfba>", "<dev string:xfd2>", &function_e35881eb9a9e79ae);
  devgui::function_a9a864379a098ad6("<dev string:xff7>", "<dev string:x100e>", &function_39660a1bd27ed1f1);
  devgui::function_fe953f000498048f();
  devgui::function_6e7290c8ee4f558b("<dev string:x1034>");
  devgui::function_b23a59dfb4ca49a1("<dev string:x10ad>", "<dev string:x10b6>", &function_93dd3a0e566cf68f);
  devgui::function_b23a59dfb4ca49a1("<dev string:x10d5>", "<dev string:x10dc>", &function_93dd3a0e566cf68f);
  devgui::function_b23a59dfb4ca49a1("<dev string:x10f9>", "<dev string:x1100>", &function_93dd3a0e566cf68f);
  devgui::function_fe953f000498048f();
  devgui::function_6e7290c8ee4f558b("<dev string:x111d>");
  devgui::function_b23a59dfb4ca49a1("<dev string:x10ad>", "<dev string:x1188>", &function_5d733649a75294ba);
  devgui::function_b23a59dfb4ca49a1("<dev string:x11a5>", "<dev string:x11ab>", &function_5d733649a75294ba);
  devgui::function_b23a59dfb4ca49a1("<dev string:x10d5>", "<dev string:x11c5>", &function_5d733649a75294ba);
  devgui::function_b23a59dfb4ca49a1("<dev string:x11e0>", "<dev string:x11e7>", &function_5d733649a75294ba);
  devgui::function_fe953f000498048f();
  devgui::function_6e7290c8ee4f558b("<dev string:x1202>");
  devgui::function_b23a59dfb4ca49a1("<dev string:x10ad>", "<dev string:x127a>", &function_85c67db3f5bb38ad);
  devgui::function_b23a59dfb4ca49a1("<dev string:x129b>", "<dev string:x12a1>", &function_85c67db3f5bb38ad);
  devgui::function_b23a59dfb4ca49a1("<dev string:x12bf>", "<dev string:x12c5>", &function_85c67db3f5bb38ad);
  devgui::function_b23a59dfb4ca49a1("<dev string:x12e3>", "<dev string:x12e9>", &function_85c67db3f5bb38ad);
  devgui::function_fe953f000498048f();
}

function function_da8dd7e0115a7063(params) {
  option = params[0];
  var_8f07c7b330e08f30 = int(params[1]);
  newfunction = undefined;

  switch (option) {
    case #"hash_7038dec66d8275be":
      newfunction = activity_common::function_35c9943414b3e6ed(var_8f07c7b330e08f30);
      break;
    case #"hash_f43afb7b1b11f010":
      newfunction = &function_cc447c65d0cb6dec;
      break;
    case #"hash_bb5bf3da71cceeb6":
      newfunction = &function_b77759c4dc1c9af5;
      break;
    case #"hash_30f1c77a303828ff":
      newfunction = &function_722036690769e7d4;
      break;
    case #"hash_16ce513c547213e7":
      newfunction = &function_2000a89cef04193a;
      break;
    default:
      break;
  }

  if(!isDefined(newfunction)) {
    return;
  }

  instance = namespace_cde84ab88f41f1a5::function_deb5a4d2a7bda5e9(level.player);

  if(!isDefined(instance)) {
    iprintlnbold("<dev string:x134f>");
    return;
  }

  activitytype = namespace_4fda5d7358015a06::function_de53ed8e35d0ed7a(instance);
  activity_common::function_89384091f7a2dbd(activitytype, var_8f07c7b330e08f30, newfunction);

  if(option == "<dev string:x1307>") {
    iprintln("<dev string:x138e>");
    return;
  }

  iprintln("<dev string:x13a9>");
}

function private function_cc447c65d0cb6dec(var_ed118e6dd8c246) {
  return undefined;
}

function private function_b77759c4dc1c9af5(var_6f8af5eb76deac21) {
  group = [];
  return [group];
}

function private function_722036690769e7d4() {
  activityinstance = self;
  cache = spawnStruct();
  activityinstance namespace_e8853d3344e33cf6::function_d67ffd8ae22bf637(cache);
  contents = [];
  contents[0] = structcopy(cache.contents[0]);
  contents[1] = structcopy(cache.contents[0]);
  contents[2] = structcopy(cache.contents[0]);
  contents[3] = structcopy(cache.contents[0]);
  return contents;
}

function private function_2000a89cef04193a() {
  return function_cafea350b590ead9();
}

function function_17cdab7c9e667af1() {
  rewardgroup = [level.players[0]];
  rewardgroups = [rewardgroup];
  placement = function_cafea350b590ead9();
  function_8051570293371e2e(rewardgroups, placement);
}

function function_5999bbd46eb60a67() {
  rewardgroup = [level.players[0]];
  rewardgroups = [rewardgroup];
  placement = function_cafea350b590ead9();
  function_8051570293371e2e(rewardgroups, placement, 1);
}

function function_ee7d561776755da0() {
  rewardgroup = [];
  rewardgroups = [rewardgroup];
  placement = function_cafea350b590ead9();
  function_8051570293371e2e(rewardgroups, placement);
}

function private function_cafea350b590ead9() {
  placement = spawnStruct();
  placement.origin = level.players[0].origin + (100, 0, 0);
  placement.angles = level.players[0].angles;
  return placement;
}

function private function_aaecaf3c5ebb48d4(args) {
  cache = spawnStruct();
  namespace_e8853d3344e33cf6::function_d67ffd8ae22bf637(cache);
  return cache.contents;
}

function function_8051570293371e2e(playergroups, placementstruct, var_62f5b2662f131620) {
  var_2903e6c44924f6ec = getscriptbundle(hashcat(%"hash_3e3429260ba62549", "<dev string:x13c9>"));
  [var_167a6a2fafb71948] = namespace_e81b1392df0afa31::function_956d43b7266a97d9(var_2903e6c44924f6ec);
  var_dddc9860f82c0df0 = function_18a04da230bdecbb(var_167a6a2fafb71948);

  if(default_to(var_62f5b2662f131620, 0)) {
    var_f07d96bc912b9e7b = namespace_81b7e1672a7e54da::function_2d81488c136e7154(undefined);
  } else {
    var_f07d96bc912b9e7b = namespace_55960efed51f8481::function_9e1216d6f33a3c78(var_dddc9860f82c0df0);
  }

  var_bae6a1d8f73bc001 = namespace_55960efed51f8481::function_e7c2ecccbf00007e(var_dddc9860f82c0df0);
  var_ce0e8fe5ee941ba9 = &namespace_71ca15b739deab72::function_69406b22706f2162;
  var_5110040e4247ddb8 = &function_aaecaf3c5ebb48d4;
  function_75e180b08f394748(var_bae6a1d8f73bc001, var_f07d96bc912b9e7b, playergroups, placementstruct, var_ce0e8fe5ee941ba9, var_5110040e4247ddb8);
}

function function_1d6fde9c84af8229() {
  if(isDefined(level.var_b7886ea73702cf1b)) {
    namespace_6d633d94b557096d::function_f1c1ef5a544c2add(level.var_b7886ea73702cf1b);
    namespace_6d633d94b557096d::function_6099c5a2ad80e231(level.var_b7886ea73702cf1b);
    waitframe();
  }

  var_262870a606179376 = function_800fca52b91a419c();
  var_262870a606179376 waittill("<dev string:x13e0>", var_3c5ef6d979d35982);
  level.var_b7886ea73702cf1b = var_3c5ef6d979d35982;
  thread function_1f57a3b46d10fa99(var_3c5ef6d979d35982);
  namespace_6d633d94b557096d::function_a52e804f95d8ef78(var_3c5ef6d979d35982);
}

function function_1f57a3b46d10fa99(var_90fb64f0224fa64d) {
  var_90fb64f0224fa64d waittill("<dev string:x1403>");

  if(level.var_b7886ea73702cf1b == var_90fb64f0224fa64d) {
    level.var_b7886ea73702cf1b = undefined;
  }
}

function function_92f87dba4058fb48() {
  if(isDefined(level.var_b7886ea73702cf1b)) {
    namespace_6d633d94b557096d::function_f1c1ef5a544c2add(level.var_b7886ea73702cf1b);
  }
}

function function_ec623faf77071b55() {
  if(isDefined(level.var_b7886ea73702cf1b)) {
    cache = spawnStruct();
    items = common_item::function_bc2f4857c90f5344("<dev string:x1425>", 1);
    common_cache::function_fd95ef820bb2b980(items, cache);
    namespace_6d633d94b557096d::function_b6ffbbaf23178f9b(level.var_b7886ea73702cf1b, level.players[0], cache.contents);
  }
}

function function_c914b873f680b584() {
  if(isDefined(level.var_b7886ea73702cf1b)) {
    level.var_7e64537d346dd9ac = function_805de4f236be02cc(level.var_b7886ea73702cf1b, level.players[0]);
  }
}

function function_a9d48cab10e470f0() {
  if(isDefined(level.var_b7886ea73702cf1b) && isDefined(level.var_7e64537d346dd9ac)) {
    cache = spawnStruct();
    items = common_item::function_bc2f4857c90f5344("<dev string:x1425>", 1);
    common_cache::function_fd95ef820bb2b980(items, cache);
    var_90fb64f0224fa64d = level.var_b7886ea73702cf1b;
    player = level.players[0];
    var_a52f80b73fc2a002 = level.var_7e64537d346dd9ac;
    item = cache.contents[0];
    function_8b4f7ed65818ac99(var_90fb64f0224fa64d, player, var_a52f80b73fc2a002, item);
  }
}

function function_b58335ee87dc0782() {
  thread function_6862c88a80e4b3b0();
}

function function_6862c88a80e4b3b0() {
  var_262870a606179376 = function_800fca52b91a419c(1);
  var_262870a606179376 waittill("<dev string:x13e0>", var_3c5ef6d979d35982);

  if(!isDefined(var_3c5ef6d979d35982)) {
    iprintln("<dev string:x1451>");
    return;
  }

  iprintln("<dev string:x146d>");
}

function function_5cf355e8a2e39acf() {
  thread function_2deca7eff98e67a9();
}

function function_2deca7eff98e67a9() {
  var_262870a606179376 = function_800fca52b91a419c();
  var_262870a606179376 waittill("<dev string:x13e0>", var_e10194ca6271ac0a);
  iprintln("<dev string:x14bc>");

  if(isDefined(var_e10194ca6271ac0a)) {
    var_e10194ca6271ac0a waittill("<dev string:x1403>");
    iprintln("<dev string:x14d3>");
    return;
  }

  iprintln("<dev string:x14ec>");
}

function function_800fca52b91a419c(var_8d3bc2cdb73e80ae, spawnnearby) {
  if(!isDefined(var_8d3bc2cdb73e80ae)) {
    var_8d3bc2cdb73e80ae = 0;
  }

  if(!isDefined(spawnnearby)) {
    spawnnearby = 0;
  }

  nearbyposition = function_cafea350b590ead9();
  placement = namespace_bd7428f3122be80f::function_3ae7f99339b96499(nearbyposition.origin, spawnnearby);
  reward_group = var_8d3bc2cdb73e80ae ? undefined : [level.players[0]];
  reward_groups = [reward_group];
  var_3c99a2a84c4b850f = spawnStruct();
  lootfunc = &function_aaecaf3c5ebb48d4;
  var_f7f66a8bcca0ac73 = undefined;
  var_42f5a7aef7be50f9 = undefined;
  var_a1bdf2e1fd12ffc = &namespace_71ca15b739deab72::function_aae7d234bf6eaaa9;
  var_bae6a1d8f73bc001 = reward_cache_settings::function_ec54b8019f59c0ef("<dev string:x153b>");
  despawndistance = 500;
  var_d9c7c84351cf42df = 10;
  var_d99131f23781644f = 5;
  var_dcbc42d7f8d81f9a = 1;
  spawndelayseconds = 0;
  var_228c0115e2e06985 = 7500;
  var_f07d96bc912b9e7b = namespace_81b7e1672a7e54da::function_3db94080a2ab11a4(despawndistance, var_d9c7c84351cf42df, var_d99131f23781644f, var_dcbc42d7f8d81f9a, var_228c0115e2e06985, spawndelayseconds);
  var_ce0e8fe5ee941ba9 = &namespace_3dd7203b843229f9::function_885b8eee6652a555;
  namespace_6d633d94b557096d::function_75e180b08f394748(var_bae6a1d8f73bc001, var_f07d96bc912b9e7b, [reward_group], placement, var_ce0e8fe5ee941ba9, lootfunc, var_f7f66a8bcca0ac73, var_42f5a7aef7be50f9, var_a1bdf2e1fd12ffc, var_3c99a2a84c4b850f);
  return var_3c99a2a84c4b850f;
}

function function_54f49ba0c0e779a8(params) {
  instance = namespace_cde84ab88f41f1a5::function_deb5a4d2a7bda5e9(level.player);

  if(!isDefined(instance)) {
    iprintlnbold("<dev string:x134f>");
    return;
  }

  activitymoment = params[0];
  namespace_68dc261109a9503f::function_735ee8e9d0f1b00b(instance, activitymoment);
}

function function_3e599a727dc23cff(params) {
  instance = namespace_cde84ab88f41f1a5::function_deb5a4d2a7bda5e9(level.player);

  if(!isDefined(instance)) {
    iprintlnbold("<dev string:x134f>");
    return;
  }

  var_cf0473fe83bf0bc1 = params[0];
  namespace_68dc261109a9503f::function_ce906635a152d2d0(instance, var_cf0473fe83bf0bc1);
}

function function_8d27329ae0daf827() {
  payload = [#"teamselect", level.players[0] getentitynumber()];
  function_83741f7e29789c4a(payload);
}

function function_b00d1f4332da2f82() {
  if(isDefined(level.players[1])) {
    entnum = level.players[1] getentitynumber();
  } else {
    entnum = level.players[0] getentitynumber() + 1;
  }

  payload = [#"teamselect", entnum];
  function_83741f7e29789c4a(payload);
}

function private function_83741f7e29789c4a(payload) {
  if(isDefined(level.var_80e29d48c4a0151a)) {
    level.var_80e29d48c4a0151a freescriptable();
    level.var_80e29d48c4a0151a = undefined;
  }

  placement = function_cafea350b590ead9();
  level.var_80e29d48c4a0151a = spawnscriptable("<dev string:x1552>", placement.origin, placement.angles, undefined, payload);
  wait 120;

  if(isDefined(level.var_80e29d48c4a0151a)) {
    level.var_80e29d48c4a0151a freescriptable();
    level.var_80e29d48c4a0151a = undefined;
  }
}

function function_45447176e70e6964(params) {
  scriptable = level.var_80e29d48c4a0151a;

  if(!isDefined(scriptable)) {
    iprintln("<dev string:x1583>");
    return;
  }

  part = "<dev string:x15b0>";
  state = params[0];
  scriptable setscriptablepartstate(part, state);
}

function function_698216eddc4dcd80() {
  scriptable = level.var_80e29d48c4a0151a;

  if(!isDefined(scriptable)) {
    iprintln("<dev string:x1583>");
    return;
  }

  part = "<dev string:x15b8>";
  scriptable setscriptablepartstate(part, "<dev string:x15c7>");
  waitframe();
  scriptable setscriptablepartstate(part, "<dev string:x62c>");
}

function function_f29e71bce0677ffa() {
  scriptable = level.var_80e29d48c4a0151a;

  if(!isDefined(scriptable)) {
    iprintln("<dev string:x1583>");
    return;
  }

  part = "<dev string:x15e2>";
  scriptable setscriptablepartstate(part, "<dev string:x15ee>");
  waitframe();
  scriptable setscriptablepartstate(part, "<dev string:x62c>");
}

function function_24afaf27f07f9eaf() {
  scriptable = level.var_80e29d48c4a0151a;

  if(!isDefined(scriptable)) {
    iprintln("<dev string:x1583>");
    return;
  }

  part = "<dev string:x1606>";
  scriptable setscriptablepartstate(part, "<dev string:x1612>");
  waitframe();
  scriptable setscriptablepartstate(part, "<dev string:x62c>");
}

function private function_a5dc5dd6143b0c2e() {
  while(true) {
    if(getdvarint(@ "hash_64bf749bc2b9f5ac", 0) == 1) {
      iprintlnbold("<dev string:x162a>");
      function_60b2c5a368ca7cf9();
      setDvar(@ "hash_64bf749bc2b9f5ac", 0);
    }

    if(getdvarint(@ "hash_b223ecf5093e1dc3", 0) == 1) {
      iprintlnbold("<dev string:x1661>");
      function_91c520c9c65c4cc2();
      setDvar(@ "hash_b223ecf5093e1dc3", 0);
    }

    if(getdvarint(@ "hash_7d4c31ff1a097c23", 0) == 1) {
      iprintlnbold("<dev string:x1698>");
      function_fc9048b1ef40fe75();
      setDvar(@ "hash_7d4c31ff1a097c23", 0);
    }

    if(getdvarint(@ "hash_9ae7f603389004dd", 0) == 1) {
      iprintlnbold("<dev string:x16c3>");
      function_92b72f67535d00d1();
      setDvar(@ "hash_9ae7f603389004dd", 0);
    }

    if(getdvarint(@ "hash_382caba4283fac9d", 0) == 1) {
      iprintlnbold("<dev string:x16f5>");
      function_5933af1712e80c14();
      setDvar(@ "hash_382caba4283fac9d", 0);
    }

    waitframe();
  }
}

function private function_60b2c5a368ca7cf9() {
  playergroups = [];

  foreach(player in level.players) {
    playergroups[playergroups.size] = [player];
  }

  placement = spawnStruct();
  placement.origin = level.players[0].origin;
  placement.angles = level.players[0].angles;
  function_8051570293371e2e(playergroups, placement);
}

function private function_91c520c9c65c4cc2() {
  playergroups = [level.players];
  placement = spawnStruct();
  placement.origin = level.players[0].origin;
  placement.angles = level.players[0].angles;
  function_8051570293371e2e(playergroups, placement);
}

function private function_fc9048b1ef40fe75() {
  group = [level.players[0]];
  playergroups = [group];
  placement = spawnStruct();
  placement.origin = level.players[0].origin;
  placement.angles = level.players[0].angles;
  function_8051570293371e2e(playergroups, placement);
}

function private function_92b72f67535d00d1() {
  if(level.players.size > 2) {
    group = [level.players[0], level.players[1]];
    playergroups = [group];
  } else {
    iprintln("<dev string:x173a>");
    return;
  }

  placement = spawnStruct();
  placement.origin = level.players[0].origin;
  placement.angles = level.players[0].angles;
  function_8051570293371e2e(playergroups, placement);
}

function private function_5933af1712e80c14() {
  if(level.players.size > 2) {
    group1 = [level.players[0]];
    group2 = [level.players[1]];
    playergroups = [group1, group2];
  } else {
    iprintln("<dev string:x173a>");
    return;
  }

  placement = spawnStruct();
  placement.origin = level.players[0].origin;
  placement.angles = level.players[0].angles;
  function_8051570293371e2e(playergroups, placement);
}

function function_fa399987cca698bf() {
  setDvar(@ "test_spawn", 1);
}

function function_3583d52b2b2d8866() {
  setDvar(@ "hash_eff5e2218caf8354", 1);
  var_1a48dd0636cd4ac2 = 24;
  var_a11a5c873a8159a1 = 180;
  setDvar(@ "hash_1ed3e490fb83235e", var_1a48dd0636cd4ac2 * var_a11a5c873a8159a1);
}

function function_ee2b27cbec4d7d91() {
  setDvar(@ "hash_eff5e2218caf8354", 0);
}

function function_80769efb00130194() {
  function_8d13377b510a0d07();
  function_3583d52b2b2d8866();
  thread function_75fd2f4e60f7fa69();
}

function function_8d13377b510a0d07() {
  setDvar(@ "hash_eff5e2218caf8354", 0);
  function_ee2b27cbec4d7d91();
  level notify("<dev string:x1773>");
}

function function_93dd3a0e566cf68f(params) {
  setDvar(@ "test_distance", function_8ba86866b46be578(params, 80));
}

function function_5d733649a75294ba(params) {
  setDvar(@ "test_radius", function_8ba86866b46be578(params, 120));
}

function function_85c67db3f5bb38ad(params) {
  setDvar(@ "test_fov", function_8ba86866b46be578(params, 0.5));
}

function function_8ba86866b46be578(params, default_value) {
  if(params[0] == "<dev string:x179e>") {
    int_val = default_value;
  } else {
    int_val = int(params[0]);
  }

  return int_val;
}

function function_2af907e3a31b7e83() {
  setDvar(@ "hash_c64fb3f1e87bb1fd", 1);
}

function function_722e153f02e13ef2() {
  setDvar(@ "hash_c64fb3f1e87bb1fd", 0);
}

function function_e35881eb9a9e79ae() {
  iprintlnbold("<dev string:x17a7>");
  setDvar(@ "hash_ed4e1c3ec7fb385d", 1);
}

function function_39660a1bd27ed1f1() {
  iprintlnbold("<dev string:x17e8>");
  setDvar(@ "hash_ed4e1c3ec7fb385d", 0);
}

function function_75fd2f4e60f7fa69() {
  level endon("<dev string:x1773>");

  while(!isDefined(level.player)) {
    waitframe();
  }

  while(true) {
    var_44abc2142cbaf028 = (0, 100, 100);
    var_eb66e42880eb990b = (0, 0, 255);
    var_7b08892f10fff3b4 = (0, 255, 0);
    var_c36aacc7880bb472 = getdvarint(@ "test_distance", 80);
    offset_radius = getdvarint(@ "test_radius", 120);
    var_754a8d693fcd91fa = getdvarint(@ "hash_a648b26bf386318b", 2);
    var_85507f88aefabcf8 = getdvarint(@ "hash_88de563635d1c8f4", 22);
    var_bdddd54b5215d262 = getdvarint(@ "hash_14a76d70faf5b5de", 36);
    var_6c100a7b08956c0 = getdvarint(@ "hash_631bc888d0a9d40c", 0.5);
    var_ff35512e43399552 = cos(getdvarint(@ "test_fov", 60));
    var_53fa59172b1a5af3 = getdvarint(@ "hash_115f84e0712dc11", 16);
    var_6a92292682f42b7d = getdvarint(@ "test_spawn", 0);
    var_6e6fc2a91d9973cf = getdvarint(@ "hash_ed4e1c3ec7fb385d", 0);
    var_c4cf0e3e67a24f23 = getdvarint(@ "hash_c64fb3f1e87bb1fd", 0);
    var_cb6bd5684b8d4a58 = var_6a92292682f42b7d ? 9999 : ceil(8 / var_754a8d693fcd91fa);
    setDvar(@ "hash_1ed3e490fb83235e", var_cb6bd5684b8d4a58);
    var_51787f3e30576093 = level.player getvieworigin();
    var_afaade40dced5e4d = level.player getplayerangles();
    var_b9f9b692fc3709e8 = var_51787f3e30576093 + anglesToForward(var_afaade40dced5e4d) * var_c36aacc7880bb472;
    var_e4592b88c9fe6650 = level;
    var_ca4164eb3768e67c = var_6e6fc2a91d9973cf ? var_b9f9b692fc3709e8 : level.player.origin;
    var_c921b7b980aae8e6 = namespace_7e4700be8ab64610::function_ab7db46b3325436(var_85507f88aefabcf8, var_bdddd54b5215d262, var_6c100a7b08956c0, var_ca4164eb3768e67c, level.player getplayerangles(), var_ff35512e43399552, var_53fa59172b1a5af3);
    scoreamountsettings = var_c4cf0e3e67a24f23 ? namespace_7e4700be8ab64610::function_e683a4069caa308a() : namespace_7e4700be8ab64610::function_48d03a548cabbbaa();
    namespace_7e4700be8ab64610::findnearbyspawnpointguaranteed(var_b9f9b692fc3709e8, offset_radius, var_c921b7b980aae8e6, scoreamountsettings, var_e4592b88c9fe6650);
    var_e4592b88c9fe6650 waittill("<dev string:x1828>", selected_position);

    if(!isDefined(selected_position)) {
      iprintlnbold("<dev string:x184f>");
      continue;
    }

    if(var_6a92292682f42b7d) {
      setDvar(@ "test_spawn", 0);
      var_8413510412a61b93 = setDvar(@ "hash_1ed3e490fb83235e", 2);
      placement = namespace_bd7428f3122be80f::function_3ae7f99339b96499(selected_position, 0);
      group = [level.player];
      namespace_e8853d3344e33cf6::function_863be9e39e19fe2f([group], placement, &function_aaecaf3c5ebb48d4);
    }

    waitframe();
  }
}

function function_873ab38b86db5af6() {
  reward_cache::function_1c972fc13937297c("<dev string:x1872>");
  reward_cache::function_1c5f030d48fdff4c("<dev string:x1886>");
  reward_cache::function_469b7ea0b94baae6("<dev string:x189d>");
  reward_cache::function_e02e37e34dec2042("<dev string:x18b2>");
  iprintlnbold("<dev string:x18c8>");
}

function function_1b049047564ba81f() {
  function_d75df7cc6aa84b6d(@ "hash_9a8fd13708d50583");
}

function function_e0aeb6bf6a39a440() {
  function_d75df7cc6aa84b6d(@ "hash_9d0c095771c6026d");
}

function function_b6a7c1b7984c9819() {
  function_d75df7cc6aa84b6d(@ "hash_813ebb2dc2b30d1c");
}

function function_4a0df56ed43e0bbb() {
  function_d75df7cc6aa84b6d(@ "hash_693c22d6aae40d2e");
}

function function_f569e14f7ec1cd87() {
  function_d75df7cc6aa84b6d(@ "hash_176196b9a9745584");
}

function function_ff21ac1bf3912ce7() {
  function_d75df7cc6aa84b6d(@ "hash_56641085422a272c");
}

function function_ac2b833e8fa2bd3e() {
  function_d75df7cc6aa84b6d(@ "hash_bd0e9311e61ffefa");
}

function function_d75df7cc6aa84b6d(dvar) {
  value = getdvarint(dvar, 0);

  if(istrue(value)) {
    iprintln("<dev string:x1914>");
    setDvar(dvar, 0);
    return;
  }

  iprintln("<dev string:x1928>");
  setDvar(dvar, 1);
}

# /