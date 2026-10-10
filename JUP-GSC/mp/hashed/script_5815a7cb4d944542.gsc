/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_5815a7cb4d944542.gsc
*************************************************/

#using script_17dc47fb18ded931;
#using script_185660037b9236c1;
#using script_33135cb7affb7992;
#using script_3d3d1ef33cecfb62;
#using script_41387eecc35b88bf;
#using script_5f71ed065b9cea1e;
#using script_6b684505b9959a08;
#using script_7956d56c4922bd1;
#using scripts\engine\utility;
#namespace activity_rewards;

function function_49f447d3531edf7e(activityinstance, activitymoment, var_8436ec5bdd7c457d, var_e0a0dc78cd0e70f3, var_44fadde66021a763) {
  assert(isDefined(activitymoment));
  assert(isDefined(activityinstance));

  if(activitymoment == "RewardsSpawned") {
    return;
  }

  var_aee75dab5275be5a = function_7f791aa5f22cda77(activityinstance, activitymoment, var_8436ec5bdd7c457d);
  assert(isDefined(var_aee75dab5275be5a));
  var_df8cbcdead13c58f = [];

  foreach(var_7ff959e229d749c3 in var_aee75dab5275be5a) {
    var_3c99a2a84c4b850f = spawnStruct();
    var_df8cbcdead13c58f[var_df8cbcdead13c58f.size] = var_3c99a2a84c4b850f;
    var_40bdc956443135c6 = namespace_55960efed51f8481::function_18a04da230bdecbb(var_7ff959e229d749c3);
    function_efd24b6185b08515(activityinstance, var_40bdc956443135c6, var_e0a0dc78cd0e70f3, var_3c99a2a84c4b850f);
  }

  function_b1a35db845047ecc(var_44fadde66021a763, var_df8cbcdead13c58f, activityinstance, activitymoment, var_8436ec5bdd7c457d);
}

function function_efd24b6185b08515(activityinstance, var_40bdc956443135c6, var_e0a0dc78cd0e70f3, var_3c99a2a84c4b850f) {
  var_bae6a1d8f73bc001 = function_e7c2ecccbf00007e(var_40bdc956443135c6);
  var_f07d96bc912b9e7b = function_9e1216d6f33a3c78(var_40bdc956443135c6);
  var_5f30aa3845e26983 = function_ca5f5e4bcc7eeb6b(activityinstance, var_40bdc956443135c6);
  rewardspawnlocation = default_to(var_e0a0dc78cd0e70f3, function_b62ec8e6a3683859(activityinstance, var_40bdc956443135c6));
  var_78ffc9208217131a = &function_885b8eee6652a555;
  lootfunction = &function_bb5549431bc6e2db;
  var_ed118e6dd8c246 = function_46cf871ea6373933(activityinstance);
  var_89e6aa0dcb676de = undefined;
  var_60cbd56e1b6ff1b7 = &function_a524fa56ca65ce48;
  var_859e0858a90cac79 = isDefined(var_3c99a2a84c4b850f) ? var_3c99a2a84c4b850f : spawnStruct();
  thread function_b2bfec0cbd353637(activityinstance, var_859e0858a90cac79);
  namespace_6d633d94b557096d::function_75e180b08f394748(var_bae6a1d8f73bc001, var_f07d96bc912b9e7b, var_5f30aa3845e26983, rewardspawnlocation, var_78ffc9208217131a, lootfunction, var_ed118e6dd8c246, var_89e6aa0dcb676de, var_60cbd56e1b6ff1b7, var_859e0858a90cac79);
}

function function_8fdd18e047a23b6a(activityinstance, rewardgrouptype, perplayerloot) {
  var_6f8af5eb76deac21 = spawnStruct();
  var_6f8af5eb76deac21.rewardgrouptype = rewardgrouptype;
  var_6f8af5eb76deac21.perplayerloot = perplayerloot;
  return function_104adc18c0d699c3(activityinstance, 6, var_6f8af5eb76deac21);
}

function function_ca5f5e4bcc7eeb6b(activityinstance, var_40bdc956443135c6) {
  rewardgrouptype = namespace_55960efed51f8481::function_45864bd1ba317b7f(var_40bdc956443135c6);
  perplayerloot = namespace_55960efed51f8481::function_d2ce6c5a4f9d52e5(var_40bdc956443135c6);
  return function_8fdd18e047a23b6a(activityinstance, rewardgrouptype, perplayerloot);
}

function function_7af151bd42e8132d(activityinstance, var_2b5aa40272b0bbce) {
  var_6f8af5eb76deac21 = spawnStruct();
  var_6f8af5eb76deac21.var_2b5aa40272b0bbce = var_2b5aa40272b0bbce;
  activitytype = function_de53ed8e35d0ed7a(activityinstance);

  if(function_811a0fab09c793ce(activitytype, 5) == function_35c9943414b3e6ed(5)) {
    var_35d3425cf6c2d4a7 = function_104adc18c0d699c3(activityinstance, 5, var_6f8af5eb76deac21);
  } else {
    var_35d3425cf6c2d4a7 = function_104adc18c0d699c3(activityinstance, 5);
  }

  if(isDefined(var_35d3425cf6c2d4a7)) {
    if(!isarray(var_35d3425cf6c2d4a7)) {
      var_35d3425cf6c2d4a7 = [var_35d3425cf6c2d4a7];
    }

    assertex(isDefined(var_35d3425cf6c2d4a7[0].origin), "<dev string:x1c>");
    assertex(isDefined(var_35d3425cf6c2d4a7[0].angles), "<dev string:x77>");
    return var_35d3425cf6c2d4a7[0];
  }

  assertmsg("<dev string:xd2>");
  return undefined;
}

function function_b62ec8e6a3683859(activityinstance, var_40bdc956443135c6) {
  var_2b5aa40272b0bbce = namespace_55960efed51f8481::function_fe7983e3293f0584(var_40bdc956443135c6);
  return function_7af151bd42e8132d(activityinstance, var_2b5aa40272b0bbce);
}

function function_885b8eee6652a555(argstruct) {
  activity_common::function_f541e4e4edaa8e99(9, argstruct, 0);
}

function function_a524fa56ca65ce48(argsstruct) {
  if(function_71d38726159c3f12(10)) {
    activity_common::function_f541e4e4edaa8e99(10, argsstruct, 0);
  }
}

function private function_b1a35db845047ecc(var_44fadde66021a763, var_df8cbcdead13c58f, activityinstance, activitymoment, var_8436ec5bdd7c457d) {
  if(var_df8cbcdead13c58f.size == 0) {
    function_91913c72212591e4(var_44fadde66021a763, []);
    return;
  }

  var_80fa831937e81d9d = {
    #var_8436ec5bdd7c457d: var_8436ec5bdd7c457d, #activitymoment: activitymoment, #activityinstance: activityinstance, #var_44fadde66021a763: var_44fadde66021a763, #numwaitingtospawn: var_df8cbcdead13c58f.size, #var_2b3da9e0b7d7384d: []
  };

  foreach(var_8d0b539295ebb58a in var_df8cbcdead13c58f) {
    thread function_f13e664170ab692d(var_8d0b539295ebb58a, var_80fa831937e81d9d);
  }
}

function private function_f13e664170ab692d(var_8d0b539295ebb58a, var_80fa831937e81d9d) {
  var_8d0b539295ebb58a waittill("managed_reward_cache_spawn_done", spawnedcache);

  if(isDefined(spawnedcache)) {
    var_80fa831937e81d9d.var_2b3da9e0b7d7384d[var_80fa831937e81d9d.var_2b3da9e0b7d7384d.size] = spawnedcache;
  }

  var_80fa831937e81d9d.numwaitingtospawn -= 1;

  if(var_80fa831937e81d9d.numwaitingtospawn <= 0) {
    function_91913c72212591e4(var_80fa831937e81d9d.var_44fadde66021a763, var_80fa831937e81d9d.var_2b3da9e0b7d7384d, var_80fa831937e81d9d.activityinstance, var_80fa831937e81d9d.activitymoment, var_80fa831937e81d9d.var_8436ec5bdd7c457d);
  }
}

function private function_91913c72212591e4(var_44fadde66021a763, var_2b3da9e0b7d7384d, activityinstance, activitymoment, var_8436ec5bdd7c457d) {
  if(isDefined(var_44fadde66021a763)) {
    var_44fadde66021a763 notify("activity_reward_caches_done_spawning", var_2b3da9e0b7d7384d);
  }

  if(isDefined(activityinstance)) {
    var_6f8af5eb76deac21 = function_488dc16c77130e3e(activitymoment, var_8436ec5bdd7c457d, var_2b3da9e0b7d7384d);
    activityinstance namespace_4fda5d7358015a06::function_735ee8e9d0f1b00b(activityinstance, "RewardsSpawned", var_6f8af5eb76deac21);
  }
}

function function_488dc16c77130e3e(var_9ff035d5fc0b423c, var_695aa6b24855b76d, rewardcaches) {
  return {
    #rewardcaches: default_to(rewardcaches, []), #var_695aa6b24855b76d: var_695aa6b24855b76d, #var_9ff035d5fc0b423c: var_9ff035d5fc0b423c
  };
}

function private function_bb5549431bc6e2db(var_ed118e6dd8c246) {
  assert(isstruct(var_ed118e6dd8c246) && isDefined(var_ed118e6dd8c246.activity_instance));
  activityinstance = var_ed118e6dd8c246.activity_instance;
  var_6f8af5eb76deac21 = var_ed118e6dd8c246;
  return function_104adc18c0d699c3(activityinstance, 7, var_6f8af5eb76deac21);
}

function function_d8812f59f918bbc(var_6f8af5eb76deac21) {
  assertex(isDefined(var_6f8af5eb76deac21), "<dev string:x1a5>");
  activityinstance = self;
  rewardgrouptype = var_6f8af5eb76deac21.rewardgrouptype;
  perplayerloot = var_6f8af5eb76deac21.perplayerloot;
  assertex(isDefined(rewardgrouptype));
  assertex(isDefined(perplayerloot));
  rewardgroups = function_eb4ddda3cbeb99b1(activityinstance, rewardgrouptype);

  if(istrue(perplayerloot)) {
    return function_f99ad6f0c1168f7a(rewardgroups);
  }

  return rewardgroups;
}

function private function_f99ad6f0c1168f7a(rewardgroups) {
  var_56d7bf81a933ef5a = [];

  foreach(rewardgroup in rewardgroups) {
    foreach(player in rewardgroup) {
      var_56d7bf81a933ef5a[var_56d7bf81a933ef5a.size] = [player];
    }
  }

  return var_56d7bf81a933ef5a;
}

function private function_eb4ddda3cbeb99b1(activityinstance, rewardgrouptype) {
  var_c083bd8353c655c1 = function_2dabe17056c2563f(activityinstance);
  var_5f30aa3845e26983 = [];

  switch (rewardgrouptype) {
    case #"hash_172e3a33f45b462e":
      assert(isDefined(var_c083bd8353c655c1));
      var_5f30aa3845e26983 = [var_c083bd8353c655c1];
      break;
    case #"hash_89ee46feec0f25b9":
      assertmsg("<dev string:x22f>");
      break;
    default:
      assertmsg("<dev string:x2b9>" + rewardgrouptype + "<dev string:x2cd>");
      break;
  }

  return var_5f30aa3845e26983;
}

function function_1edea59f189f9a02(activityinstance, activitymoment, var_8436ec5bdd7c457d) {
  var_340e29844a36960a = function_7f791aa5f22cda77(activityinstance, activitymoment, var_8436ec5bdd7c457d);
  return isDefined(var_340e29844a36960a) && var_340e29844a36960a.size > 0;
}

function private function_7f791aa5f22cda77(activityinstance, activitymoment, var_8436ec5bdd7c457d) {
  if(!isDefined(activityinstance.var_ee0f178c1bd2728b)) {
    function_dc46bdff60799db6(activityinstance);
  }

  mapkey = function_8ad919f0ad9070e3(activitymoment, var_8436ec5bdd7c457d);
  var_340e29844a36960a = activityinstance.var_ee0f178c1bd2728b[mapkey];
  return isDefined(var_340e29844a36960a) ? var_340e29844a36960a : [];
}

function private function_8ad919f0ad9070e3(activitymoment, var_8436ec5bdd7c457d) {
  return isDefined(var_8436ec5bdd7c457d) ? activitymoment + var_8436ec5bdd7c457d : activitymoment;
}

function private function_dc46bdff60799db6(activityinstance) {
  if(!isDefined(activityinstance.var_9767f7738e477df8)) {
    activityinstance.var_ee0f178c1bd2728b = [];
  }

  var_1c9128c658f1342b = function_5456fc53cbe1f0c4(activityinstance);

  foreach(bundlestruct in var_1c9128c658f1342b) {
    var_e4fd8733f4fb2b3c = function_f29715a4f86830ed(bundlestruct);
    var_aa82ae2da7694b4a = function_5b87e83d21054cb(bundlestruct);
    mapkey = function_8ad919f0ad9070e3(var_e4fd8733f4fb2b3c, var_aa82ae2da7694b4a);

    if(!isDefined(activityinstance.var_ee0f178c1bd2728b[mapkey])) {
      activityinstance.var_ee0f178c1bd2728b[mapkey] = [];
    }

    numelements = activityinstance.var_ee0f178c1bd2728b[mapkey].size;
    activityinstance.var_ee0f178c1bd2728b[mapkey][numelements] = bundlestruct;
  }
}

function private function_5456fc53cbe1f0c4(activityinstance) {
  var_95a5b3673c07cc00 = activity_common::function_8e6b7fc389a5a9b3();
  var_6b09d28bcc287c57 = var_95a5b3673c07cc00.var_f86621f26a29c23;
  activitycategory = function_511be8bcaede8b52(activityinstance);
  var_739aff34015ae82c = var_95a5b3673c07cc00.var_c75eef4add685c33;
  var_173b30de30893f89 = var_739aff34015ae82c[activitycategory];
  var_c424dcba3462821c = function_d8acbff3d0b7dd1a(activityinstance);
  var_3d9937b6ad104b6f = utility::array_combine(var_6b09d28bcc287c57, var_173b30de30893f89, var_c424dcba3462821c);
  return var_3d9937b6ad104b6f;
}

function private function_46cf871ea6373933(activityinstance) {
  var_ed118e6dd8c246 = spawnStruct();
  var_ed118e6dd8c246.activity_instance = activityinstance;
  var_ed118e6dd8c246.reward_group = undefined;
  return var_ed118e6dd8c246;
}

function private function_b2bfec0cbd353637(activityinstance, var_859e0858a90cac79) {
  namespace_4fda5d7358015a06::function_dca86aca511288f4(activityinstance, "CleanupState", "REWARD CACHE SPAWN START");
  var_859e0858a90cac79 waittill("managed_reward_cache_spawn_done");
  namespace_4fda5d7358015a06::function_20e36ec9e5802d01(activityinstance, "CleanupState", "REWARD CACHE SPAWN DONE");
}