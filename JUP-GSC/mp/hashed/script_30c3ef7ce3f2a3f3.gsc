/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_30c3ef7ce3f2a3f3.gsc
*************************************************/

#using script_254c2e2a2c8207f8;
#using script_530f3ea26428deba;
#using script_6981400abfcd765c;
#using script_70bdd197c5957b56;
#namespace namespace_b2de5662c522b9fa;

function function_9fcc9920ba3dbe3() {
  contextualtips = [];
  contextualtips[#"parachutecontrols"] = function_47fd484462dfbcca();
  contextualtips[#"gaszone"] = function_a7bc977f967e7c60();
  contextualtips[#"EnemiesInMinimap"] = function_15f86a8f15251eab();
  contextualtips[#"lootenemy"] = function_8c0acc8f8efc6329();
  contextualtips[#"gulag"] = function_8634e67dd83515bb();
  contextualtips[#"loadoutdrops"] = function_276714c3127904a7();
  contextualtips[#"cash"] = function_ea1bb06c0166989e();
  contextualtips[#"hash_31faa69615b691c8"] = function_da68043c98f35984();
  contextualtips[#"hash_9b8dea0d3c5a5896"] = function_d3f868ad4b277242();
  contextualtips[#"hash_f2b18d9c5c5e8436"] = function_553f6f05285d96e2();
  contextualtips[#"hash_20895fc3f28f0518"] = function_1b81fbb54a47e7fc();
  contextualtips[#"lootcrate"] = function_90ad8c7b4bed2aa2();
  contextualtips[#"redeployally"] = function_aba6900e1e97f9a1();
  contextualtips[#"hash_71134e8b7d74f150"] = function_47da0ffac3ffd92c();
  contextualtips[#"hash_e6a6afa131968b33"] = function_b3d753411ac17ef7();

  contextualtips[#"berespawned"] = function_5f9b3065373f6069();
  contextualtips[#"hash_8b81479492ee564f"] = function_32beb91cd7225cd3();
  contextualtips[#"usezipline"] = function_a92926e7cdcd3835();
  contextualtips[#"switchweapon"] = function_35b5b71c5acc0f09();

  level.var_305547d6de59eba4.var_2f72209eba1e0b19 = (0, 0, -800);
  level.var_305547d6de59eba4.var_7520d86455f99294 = spawnscriptable("vfx_ftue_ring_1", level.var_305547d6de59eba4.var_2f72209eba1e0b19);
  function_a5559a1ea030676a();
  function_d421d0a2a75e7895();
  function_318ab477e532009e();
  level.var_6edc807b8a61c73[#"hash_67633f0cf39ded5a"] = &namespace_88945a6f395620be::function_d98f4406380ee6a6;
  level.var_6edc807b8a61c73[#"hash_a685bbede81ae08d"] = &namespace_88945a6f395620be::function_605b786ff40f7141;
  level.var_6edc807b8a61c73[#"hash_6fb1c8eda6981f46"] = &namespace_88945a6f395620be::function_a678411ce9a6f9ea;
  level.var_6edc807b8a61c73[#"hash_ead6c565e9e5af6b"] = &namespace_88945a6f395620be::function_6e076751711f3aa7;
  level.var_6edc807b8a61c73[#"hash_f333a334fe816184"] = &namespace_88945a6f395620be::function_af1415d10d444cf0;
  level.var_6edc807b8a61c73[#"hash_1f18168471c7075a"] = &namespace_88945a6f395620be::function_7fa70c0fd64f5a06;
  level.var_6edc807b8a61c73[#"hash_dfee792a12afe9c3"] = &namespace_88945a6f395620be::function_683a9cf72e77d5bf;
  level.var_6edc807b8a61c73[#"hash_744dca4b41de3cf2"] = &namespace_88945a6f395620be::function_76064323fdd75b86;
  level.var_6edc807b8a61c73[#"hash_a758b1385fb1b63e"] = &namespace_88945a6f395620be::function_abca315d6e0d1a92;
  level.var_6edc807b8a61c73[#"hash_e507ed2a9d0c7c0d"] = &namespace_88945a6f395620be::function_4f790be93cb37a59;
  level.var_6edc807b8a61c73[#"hash_7e796115efec6b4b"] = &namespace_88945a6f395620be::function_79858d3473b6385f;
  level.var_6edc807b8a61c73[#"hash_48e52bce049e3053"] = &namespace_88945a6f395620be::function_49a922d5b933eb1f;
  level.var_6edc807b8a61c73[#"hash_261b097dcfb478e8"] = &namespace_88945a6f395620be::function_578b87d7eb32541c;
  level.var_6edc807b8a61c73[#"hash_78b146a77bfb873"] = &namespace_88945a6f395620be::function_549535e92d5c8d97;
  level.var_6edc807b8a61c73[#"executecash"] = &namespace_88945a6f395620be::executecash;
  level.var_6edc807b8a61c73[#"hash_5112426a98b97641"] = &namespace_88945a6f395620be::function_5e5e151cbcc6775;
  level.var_6edc807b8a61c73[#"hash_bd9ffc37b7d99469"] = &namespace_88945a6f395620be::function_28e0fc227558e22d;
  level.var_6edc807b8a61c73[#"hash_12168b403896b93c"] = &namespace_88945a6f395620be::function_c5ea332184e0a3e8;
  level.var_6edc807b8a61c73[#"executeswitchweapon"] = &namespace_88945a6f395620be::executeswitchweapon;
  level.var_6edc807b8a61c73[#"hash_6c267d9ea7af8ae4"] = &namespace_88945a6f395620be::function_ae5757fdad4729b8;
  level.var_6edc807b8a61c73[#"hash_e175bca8011c1c15"] = &namespace_88945a6f395620be::function_390588110ddad141;
  level.var_6edc807b8a61c73[#"hash_14b58257ca92e7ec"] = &namespace_88945a6f395620be::function_91f8e694098031e8;
  level.var_6edc807b8a61c73[#"hash_b7b127d31eee37f3"] = &namespace_88945a6f395620be::function_6440647b22203967;
  level.var_6edc807b8a61c73[#"hash_b7b128d31eee39a6"] = &namespace_88945a6f395620be::function_6440657b22203b9a;
  level.var_6edc807b8a61c73[#"endLootEnemyByCond1"] = &namespace_88945a6f395620be::endlootenemybycond1;
  level.var_6edc807b8a61c73[#"hash_58e4fcf39c740b0d"] = &namespace_88945a6f395620be::function_b340dd5a8c093af1;
  level.var_6edc807b8a61c73[#"hash_f08d55c2afd0332f"] = &namespace_88945a6f395620be::function_4a531c5ba156e6b;
  level.var_6edc807b8a61c73[#"hash_f08d56c2afd034e2"] = &namespace_88945a6f395620be::function_4a532c5ba15709e;
  level.var_6edc807b8a61c73[#"hash_2fc43db5e4a2ac56"] = &namespace_88945a6f395620be::function_1873c2c76f8cf9ba;
  level.var_6edc807b8a61c73[#"hash_61fb9ceae06b354a"] = &namespace_88945a6f395620be::function_34eca3f4488832d6;
  level.var_6edc807b8a61c73[#"hash_3a64444a59c2244e"] = &namespace_88945a6f395620be::function_3197c7ae9b533b7a;
  level.var_6edc807b8a61c73[#"hash_7cf14ff9ec031aed"] = &namespace_88945a6f395620be::function_8e4ce4303149d181;
  return contextualtips;
}

function function_d421d0a2a75e7895() {
  var_13036c7f57466667[0] = #"parachutecontrols";
  var_13036c7f57466667[1] = #"gaszone";
  var_13036c7f57466667[2] = #"EnemiesInMinimap";
  var_13036c7f57466667[3] = #"lootenemy";
  var_13036c7f57466667[4] = #"gulag";
  var_13036c7f57466667[5] = #"loadoutdrops";
  var_13036c7f57466667[6] = #"cash";
  var_13036c7f57466667[7] = #"hash_31faa69615b691c8";
  var_13036c7f57466667[8] = #"hash_9b8dea0d3c5a5896";
  var_13036c7f57466667[9] = #"hash_f2b18d9c5c5e8436";
  var_13036c7f57466667[10] = #"hash_20895fc3f28f0518";
  var_13036c7f57466667[11] = #"lootcrate";
  var_13036c7f57466667[12] = #"redeployally";
  var_13036c7f57466667[13] = #"hash_71134e8b7d74f150";
  var_13036c7f57466667[14] = #"hash_8b81479492ee564f";
  var_13036c7f57466667[15] = #"usezipline";
  var_13036c7f57466667[16] = #"switchweapon";
  var_13036c7f57466667[17] = #"hash_e6a6afa131968b33";
  level.var_13036c7f57466667 = var_13036c7f57466667;
}

function function_a5559a1ea030676a() {
  var_8205621341adedc4[#"parachutecontrols"] = 0;
  var_8205621341adedc4[#"gaszone"] = 1;
  var_8205621341adedc4[#"EnemiesInMinimap"] = 2;
  var_8205621341adedc4[#"lootenemy"] = 3;
  var_8205621341adedc4[#"gulag"] = 4;
  var_8205621341adedc4[#"loadoutdrops"] = 5;
  var_8205621341adedc4[#"cash"] = 6;
  var_8205621341adedc4[#"hash_31faa69615b691c8"] = 7;
  var_8205621341adedc4[#"hash_9b8dea0d3c5a5896"] = 8;
  var_8205621341adedc4[#"berespawned"] = 9;
  var_8205621341adedc4[#"hash_f2b18d9c5c5e8436"] = 10;
  var_8205621341adedc4[#"hash_20895fc3f28f0518"] = 11;
  var_8205621341adedc4[#"lootcrate"] = 12;
  var_8205621341adedc4[#"redeployally"] = 14;
  var_8205621341adedc4[#"hash_71134e8b7d74f150"] = 13;
  var_8205621341adedc4[#"hash_8b81479492ee564f"] = 15;
  var_8205621341adedc4[#"sprintlock"] = 16;
  var_8205621341adedc4[#"usezipline"] = 17;
  var_8205621341adedc4[#"switchweapon"] = 18;
  var_8205621341adedc4[#"hash_e6a6afa131968b33"] = 30;
  level.var_8205621341adedc4 = var_8205621341adedc4;
}

function function_318ab477e532009e() {
  level.ftuedata.var_744254a0a817ff39 = spawnStruct();
  level.ftuedata.var_744254a0a817ff39.sound = 1;
  level.ftuedata.var_f09f2ffd8a67fe03 = spawnStruct();
  level.ftuedata.var_f09f2ffd8a67fe03.sound = 1;
}

function function_47fd484462dfbcca() {
  data = spawnStruct();
  data.var_2297e189e2eb2818 = [0, 1, 2, 3];
  data.priority = 40;
  data.initconditions = [];
  data.initconditions[0] = spawnStruct();
  data.initconditions[0].func = #"hash_fdeb23005dd2fee8";
  data.initconditions[0].params = spawnStruct();
  data.initconditions[0].params.var_be502a4377111804 = 1;
  data.endconditions = [];
  data.endconditions[0] = spawnStruct();
  data.endconditions[0].func = #"hash_2985d7fb1675a4c9";
  data.endconditions[0].action = #"hash_e175bca8011c1c15";
  data.function = #"hash_e507ed2a9d0c7c0d";
  return data;
}

function function_a7bc977f967e7c60() {
  data = spawnStruct();
  data.var_2297e189e2eb2818 = [0, 1, 2, 3];
  data.priority = 10;
  data.initconditions = [];
  data.initconditions[0] = spawnStruct();
  data.initconditions[0].func = #"hash_2985d7fb1675a4c9";
  data.initconditions[1] = spawnStruct();
  data.initconditions[1].func = #"hash_c9d3284406c828b9";
  data.initconditions[1].params = spawnStruct();
  data.initconditions[1].params.circleindex = 2;
  data.initconditions[2] = spawnStruct();
  data.initconditions[2].func = #"hash_f577fae0c1ef83e2";
  data.initconditions[2].params = spawnStruct();
  data.initconditions[2].params.expectedvalue = 0;
  data.initconditions[3] = spawnStruct();
  data.initconditions[3].func = #"hash_ffe69230ae15b79";
  data.endconditions = [];
  data.endconditions[0] = spawnStruct();
  data.endconditions[0].func = #"hash_92bc2e77cf3d5526";
  data.function = #"hash_ead6c565e9e5af6b";
  return data;
}

function function_15f86a8f15251eab() {
  data = spawnStruct();
  data.var_2297e189e2eb2818 = [0, 1, 2, 3];
  data.priority = 20;
  data.initconditions = [];
  data.initconditions[0] = spawnStruct();
  data.initconditions[0].func = #"hash_1d0b64065eb28cba";
  data.initconditions[1] = spawnStruct();
  data.initconditions[1].func = #"hash_5e6fbe69ddb8ec3a";
  data.initconditions[2] = spawnStruct();
  data.initconditions[2].func = #"hash_f577fae0c1ef83e2";
  data.initconditions[2].params = spawnStruct();
  data.initconditions[2].params.expectedvalue = 0;
  data.function = #"hash_6fb1c8eda6981f46";
  data.var_c6228a01683251ae = 1;
  return data;
}

function function_8c0acc8f8efc6329() {
  data = spawnStruct();
  data.var_2297e189e2eb2818 = [0, 1, 2, 3];
  data.priority = 20;
  data.initconditions = [];
  data.initconditions[0] = spawnStruct();
  data.initconditions[0].func = #"hash_2fd4540e87646c8f";
  data.initconditions[1] = spawnStruct();
  data.initconditions[1].func = #"hash_f577fae0c1ef83e2";
  data.initconditions[1].params = spawnStruct();
  data.initconditions[1].params.expectedvalue = 0;
  data.initconditions[2] = spawnStruct();
  data.initconditions[2].func = #"hash_ffe69230ae15b79";
  data.endconditions = [];
  data.endconditions[0] = spawnStruct();
  data.endconditions[0].func = #"hash_b494e46204ad69af";
  data.endconditions[0].action = "endLootEnemyByCond1";
  data.endconditions[1] = spawnStruct();
  data.endconditions[1].func = #"hash_4a6f0040129fb058";
  data.endconditions[1].params = spawnStruct();
  data.endconditions[1].params.var_e003733bba588f4b = 7000;
  data.endconditions[1].action = #"hash_58e4fcf39c740b0d";
  data.function = #"hash_a758b1385fb1b63e";
  data.var_c6228a01683251ae = 1;
  return data;
}

function function_8634e67dd83515bb() {
  data = spawnStruct();
  data.var_2297e189e2eb2818 = [0, 1, 2, 3];
  data.priority = 40;
  data.initconditions = [];
  data.initconditions[0] = spawnStruct();
  data.initconditions[0].func = #"hash_f577fae0c1ef83e2";
  data.initconditions[0].params = spawnStruct();
  data.initconditions[0].params.expectedvalue = 1;
  data.endconditions = [];
  data.endconditions[0] = spawnStruct();
  data.endconditions[0].func = #"hash_f577fae0c1ef83e2";
  data.endconditions[0].params = spawnStruct();
  data.endconditions[0].params.expectedvalue = 0;
  data.endconditions[0].action = #"hash_3a64444a59c2244e";
  data.function = #"hash_f333a334fe816184";
  return data;
}

function function_276714c3127904a7() {
  data = spawnStruct();
  data.var_2297e189e2eb2818 = [0, 1, 2, 3];
  data.priority = 10;
  data.initconditions = [];
  data.initconditions[0] = spawnStruct();
  data.initconditions[0].func = #"hash_35b06a2bd68b0a3";
  data.initconditions[1] = spawnStruct();
  data.initconditions[1].func = #"hash_f77da1a0bc1b7f20";
  data.initconditions[1].params = spawnStruct();
  data.initconditions[1].params.var_38bb163d3f371e2b = 1500;
  data.initconditions[2] = spawnStruct();
  data.initconditions[2].func = #"hash_f577fae0c1ef83e2";
  data.initconditions[2].params = spawnStruct();
  data.initconditions[2].params.expectedvalue = 0;
  data.endconditions = [];
  data.function = #"hash_744dca4b41de3cf2";
  return data;
}

function function_ea1bb06c0166989e() {
  data = spawnStruct();
  data.var_2297e189e2eb2818 = [0, 1, 2, 3];
  data.priority = 10;
  data.initconditions = [];
  data.initconditions[0] = spawnStruct();
  data.initconditions[0].func = #"hash_dafc8ae8e6499e85";
  data.initconditions[0].params = spawnStruct();
  data.initconditions[0].params.expectedvalue = 1;
  data.initconditions[1] = spawnStruct();
  data.initconditions[1].func = #"hash_d983f744b6d432df";
  data.initconditions[1].params = spawnStruct();
  data.initconditions[1].params.mindistance = 50;
  data.initconditions[1].params.maxdistance = 700;
  data.initconditions[2] = spawnStruct();
  data.initconditions[2].func = #"hash_f577fae0c1ef83e2";
  data.initconditions[2].params = spawnStruct();
  data.initconditions[2].params.expectedvalue = 0;
  data.endconditions = [];
  data.endconditions[0] = spawnStruct();
  data.endconditions[0].func = #"hash_1a5df0a873a65c7d";
  data.endconditions[0].action = #"hash_f08d55c2afd0332f";
  data.endconditions[1] = spawnStruct();
  data.endconditions[1].func = #"hash_c8e46e6c2c78a405";
  data.endconditions[1].params = spawnStruct();
  data.endconditions[1].params.var_f933abfe96db9b2a = 900;
  data.endconditions[1].action = #"hash_f08d56c2afd034e2";
  data.function = #"executecash";
  return data;
}

function function_da68043c98f35984() {
  data = spawnStruct();
  data.var_2297e189e2eb2818 = [-1];
  data.priority = 10;
  data.initconditions = [];
  data.initconditions[0] = spawnStruct();
  data.initconditions[0].func = #"hash_473ba3171fb07967";
  data.initconditions[0].params = spawnStruct();
  data.initconditions[0].params.var_9130f52078745877 = 1000;
  data.initconditions[1] = spawnStruct();
  data.initconditions[1].func = #"hash_cdb2255842d1b7a7";
  data.initconditions[1].params = spawnStruct();
  data.initconditions[1].params.amount = 1000;
  data.initconditions[2] = spawnStruct();
  data.initconditions[2].func = #"hash_dafc8ae8e6499e85";
  data.initconditions[2].params = spawnStruct();
  data.initconditions[2].params.expectedvalue = 1;
  data.endconditions = [];
  data.function = #"hash_78b146a77bfb873";
  return data;
}

function function_d3f868ad4b277242() {
  data = spawnStruct();
  data.var_2297e189e2eb2818 = [0, 1, 2, 3];
  data.priority = 40;
  data.initconditions = [];
  data.initconditions[0] = spawnStruct();
  data.initconditions[0].func = #"hash_bd485a8766cc8144";
  data.initconditions[1] = spawnStruct();
  data.initconditions[1].func = #"hash_f577fae0c1ef83e2";
  data.initconditions[1].params = spawnStruct();
  data.initconditions[1].params.expectedvalue = 0;
  data.endconditions = [];
  data.function = #"hash_7e796115efec6b4b";
  data.var_bce08f4be4261bc4 = 1;
  return data;
}

function function_5f9b3065373f6069() {
  data = spawnStruct();
  data.var_2297e189e2eb2818 = [0, 1, 2, 3];
  data.priority = 40;
  data.initconditions = [];
  data.initconditions[0] = spawnStruct();
  data.initconditions[0].func = #"hash_9f7d9a620915dddf";
  data.initconditions[1] = spawnStruct();
  data.initconditions[1].func = #"hash_f577fae0c1ef83e2";
  data.initconditions[1].params = spawnStruct();
  data.initconditions[1].params.expectedvalue = 0;
  data.endconditions = [];
  data.endconditions[0] = spawnStruct();
  data.endconditions[0].func = #"hash_88893fc5d607ff7b";
  data.endconditions[0].action = #"hash_14b58257ca92e7ec";
  data.function = #"hash_67633f0cf39ded5a";
  data.var_bce08f4be4261bc4 = 1;
  return data;
}

function function_553f6f05285d96e2() {
  data = spawnStruct();
  data.var_2297e189e2eb2818 = [-1];
  data.priority = 10;
  data.initconditions = [];
  data.initconditions[0] = spawnStruct();
  data.initconditions[0].func = #"hash_dafc8ae8e6499e85";
  data.initconditions[0].params = spawnStruct();
  data.initconditions[0].params.expectedvalue = 1;
  data.initconditions[1] = spawnStruct();
  data.initconditions[1].func = #"hash_2985d7fb1675a4c9";
  data.initconditions[2] = spawnStruct();
  data.initconditions[2].func = #"hash_f577fae0c1ef83e2";
  data.initconditions[2].params = spawnStruct();
  data.initconditions[2].params.expectedvalue = 0;
  data.endconditions = [];
  data.function = #"hash_a685bbede81ae08d";
  return data;
}

function function_1b81fbb54a47e7fc() {
  data = spawnStruct();
  data.var_2297e189e2eb2818 = [-1];
  data.priority = 10;
  data.initconditions = [];
  data.initconditions[0] = spawnStruct();
  data.initconditions[0].func = #"hash_dafc8ae8e6499e85";
  data.initconditions[0].params = spawnStruct();
  data.initconditions[0].params.expectedvalue = 1;
  data.initconditions[1] = spawnStruct();
  data.initconditions[1].func = #"hash_cdb2255842d1b7a7";
  data.initconditions[1].params = spawnStruct();
  data.initconditions[1].params.amount = 2000;
  data.initconditions[2] = spawnStruct();
  data.initconditions[2].func = #"hash_f577fae0c1ef83e2";
  data.initconditions[2].params = spawnStruct();
  data.initconditions[2].params.expectedvalue = 0;
  data.initconditions[3] = spawnStruct();
  data.initconditions[3].func = #"hash_a441d3353290aefd";
  data.initconditions[3].params = spawnStruct();
  data.initconditions[3].params.expectedvalue = 0;
  data.endconditions = [];
  data.endconditions[0] = spawnStruct();
  data.endconditions[0].func = #"hash_a441d3353290aefd";
  data.endconditions[0].action = #"hash_95626095fb1efab5";
  data.function = #"hash_dfee792a12afe9c3";
  return data;
}

function function_90ad8c7b4bed2aa2() {
  data = spawnStruct();
  data.var_2297e189e2eb2818 = [0, 1, 2, 3];
  data.priority = 10;
  data.initconditions = [];
  data.initconditions[0] = spawnStruct();
  data.initconditions[0].func = #"hash_91fb810dfb39019e";
  data.initconditions[0].params = spawnStruct();
  data.initconditions[0].params.angle = 45;
  data.initconditions[0].params.maxdistance = 1500;
  data.initconditions[1] = spawnStruct();
  data.initconditions[1].func = #"hash_dafc8ae8e6499e85";
  data.initconditions[1].params = spawnStruct();
  data.initconditions[1].params.expectedvalue = 1;
  data.initconditions[2] = spawnStruct();
  data.initconditions[2].func = #"hash_2985d7fb1675a4c9";
  data.function = #"hash_bd9ffc37b7d99469";
  return data;
}

function function_aba6900e1e97f9a1() {
  data = spawnStruct();
  data.var_2297e189e2eb2818 = [0, 1, 2, 3];
  data.priority = 30;
  data.initconditions = [];
  data.initconditions[0] = spawnStruct();
  data.initconditions[0].func = #"hash_e944571129710325";
  data.initconditions[0].params = spawnStruct();
  data.initconditions[0].params.var_69fc8669a623577 = 1;
  data.initconditions[0].params.var_f0c18e87eb4091e9 = 0;
  data.initconditions[1] = spawnStruct();
  data.initconditions[1].func = #"hash_cd4f860af4d9d01";
  data.initconditions[2] = spawnStruct();
  data.initconditions[2].func = #"hash_2985d7fb1675a4c9";
  data.initconditions[3] = spawnStruct();
  data.initconditions[3].func = #"hash_f577fae0c1ef83e2";
  data.initconditions[3].params = spawnStruct();
  data.initconditions[3].params.expectedvalue = 0;
  data.initconditions[4] = spawnStruct();
  data.initconditions[4].func = #"hash_dafc8ae8e6499e85";
  data.initconditions[4].params = spawnStruct();
  data.initconditions[4].params.expectedvalue = 1;
  data.endconditions = [];
  data.endconditions[0] = spawnStruct();
  data.endconditions[0].func = #"hash_e944571129710325";
  data.endconditions[0].params = spawnStruct();
  data.endconditions[0].params.var_69fc8669a623577 = 0;
  data.endconditions[0].params.var_f0c18e87eb4091e9 = 0;
  data.endconditions[0].action = #"hash_ec29c85e9d367f82";
  data.function = #"hash_12168b403896b93c";
  data.var_bce08f4be4261bc4 = 1;
  data.var_c6228a01683251ae = 1;
  return data;
}

function function_47da0ffac3ffd92c() {
  data = spawnStruct();
  data.var_2297e189e2eb2818 = [0, 1, 2, 3];
  data.priority = 40;
  data.initconditions = [];
  data.initconditions[0] = spawnStruct();
  data.initconditions[0].func = #"hash_e71b427d3ac2e1e8";
  data.initconditions[0].params = spawnStruct();
  data.initconditions[0].params.var_71dd2a61430c603f = 2000;
  data.initconditions[0].params.minheight = -2000;
  data.initconditions[0].params.maxheight = 10000;
  data.initconditions[1] = spawnStruct();
  data.initconditions[1].func = #"hash_1f9ca1411bb8910d";
  data.initconditions[1].params = spawnStruct();
  data.initconditions[1].params.var_d7bfce72f2368972 = 3000;
  data.initconditions[2] = spawnStruct();
  data.initconditions[2].func = #"hash_f577fae0c1ef83e2";
  data.initconditions[2].params = spawnStruct();
  data.initconditions[2].params.expectedvalue = 0;
  data.initconditions[3] = spawnStruct();
  data.initconditions[3].func = #"hash_ffe69230ae15b79";
  data.endconditions = [];
  data.function = #"hash_5112426a98b97641";
  return data;
}

function function_b3d753411ac17ef7() {
  data = spawnStruct();
  data.var_2297e189e2eb2818 = [-1];
  data.priority = 60;
  data.initconditions = [];
  data.initconditions[0] = spawnStruct();
  data.initconditions[0].func = #"hash_dafc8ae8e6499e85";
  data.initconditions[0].params = spawnStruct();
  data.initconditions[0].params.expectedvalue = 1;
  data.initconditions[1] = spawnStruct();
  data.initconditions[1].func = #"hash_2985d7fb1675a4c9";
  data.initconditions[2] = spawnStruct();
  data.initconditions[2].func = #"hash_91ada55fbb1c7416";
  data.initconditions[2].params = spawnStruct();
  data.initconditions[2].params.var_31c4c1d952b9e73d = 0;
  data.initconditions[3] = spawnStruct();
  data.initconditions[3].func = #"hash_e4cd71e9e0ba9d63";
  data.initconditions[3].params = spawnStruct();
  data.initconditions[3].params.var_fcf2301d78f01b4a = 5;
  data.initconditions[4] = spawnStruct();
  data.initconditions[4].func = #"hash_f577fae0c1ef83e2";
  data.initconditions[4].params = spawnStruct();
  data.initconditions[4].params.expectedvalue = 0;
  data.endconditions = [];
  data.function = #"hash_6c267d9ea7af8ae4";
  return data;
}

function function_32beb91cd7225cd3() {
  data = spawnStruct();
  data.var_2297e189e2eb2818 = [0, 1, 2, 3];
  data.priority = 20;
  data.initconditions = [];
  data.initconditions[0] = spawnStruct();
  data.initconditions[0].func = #"hash_2985d7fb1675a4c9";
  data.initconditions[1] = spawnStruct();
  data.initconditions[1].func = #"hash_15a1d7193e2dc069";
  data.initconditions[2] = spawnStruct();
  data.initconditions[2].func = #"hash_f577fae0c1ef83e2";
  data.initconditions[2].params = spawnStruct();
  data.initconditions[2].params.expectedvalue = 0;
  data.initconditions[3] = spawnStruct();
  data.initconditions[3].func = #"hash_9271835cd909dc99";
  data.initconditions[3].params = spawnStruct();
  data.initconditions[3].params.var_38bac1117024a027 = 2;
  data.initconditions[4] = spawnStruct();
  data.initconditions[4].func = #"hash_e944571129710325";
  data.initconditions[4].params = spawnStruct();
  data.initconditions[4].params.var_69fc8669a623577 = 0;
  data.initconditions[4].params.var_f0c18e87eb4091e9 = 1;
  data.initconditions[5] = spawnStruct();
  data.initconditions[5].func = #"hash_51441c1a72c67c87";
  data.endconditions = [];
  data.function = #"hash_1f18168471c7075a";
  return data;
}

function function_e91c7a1efbd62bbe() {
  data = spawnStruct();
  data.var_2297e189e2eb2818 = [-1];
  data.priority = 10;
  data.initconditions = [];
  data.initconditions[0] = spawnStruct();
  data.initconditions[0].func = #"hash_f577fae0c1ef83e2";
  data.initconditions[0].params = spawnStruct();
  data.initconditions[0].params.expectedvalue = 0;
  data.endconditions = [];
  data.function = #"hash_48e52bce049e3053";
  return data;
}

function function_a92926e7cdcd3835() {
  data = spawnStruct();
  data.var_2297e189e2eb2818 = [-1];
  data.priority = 10;
  data.initconditions = [];
  data.initconditions[0] = spawnStruct();
  data.initconditions[0].func = #"hash_2423b25b94251c73";
  data.initconditions[0].params = spawnStruct();
  data.initconditions[0].params.var_71e5a20019ec7f70 = 2000;
  data.initconditions[1] = spawnStruct();
  data.initconditions[1].func = #"hash_2985d7fb1675a4c9";
  data.initconditions[2] = spawnStruct();
  data.initconditions[2].func = #"hash_f577fae0c1ef83e2";
  data.initconditions[2].params = spawnStruct();
  data.initconditions[2].params.expectedvalue = 0;
  data.endconditions = [];
  data.endconditions[0] = spawnStruct();
  data.endconditions[0].func = #"hash_393d0d0552ce9cdb";
  data.endconditions[0].action = #"hash_2fc43db5e4a2ac56";
  data.function = #"hash_261b097dcfb478e8";
  return data;
}

function function_35b5b71c5acc0f09() {
  data = spawnStruct();
  data.var_2297e189e2eb2818 = [-1];
  data.priority = 20;
  data.initconditions = [];
  data.initconditions[0] = spawnStruct();
  data.initconditions[0].func = #"hash_75ea4d06d4feb720";
  data.initconditions[1] = spawnStruct();
  data.initconditions[1].func = #"hash_2985d7fb1675a4c9";
  data.initconditions[2] = spawnStruct();
  data.initconditions[2].func = #"hash_f577fae0c1ef83e2";
  data.initconditions[2].params = spawnStruct();
  data.initconditions[2].params.expectedvalue = 0;
  data.endconditions = [];
  data.endconditions[0] = spawnStruct();
  data.endconditions[0].func = #"hash_98d6c62aa452883b";
  data.endconditions[0].action = #"hash_61fb9ceae06b354a";
  data.function = #"executeswitchweapon";
  return data;
}

function function_b73181b6c636632f() {
  self.var_657f5a0d17435bc.var_25d8f562f9f2daa3 = spawnStruct();
  self.var_657f5a0d17435bc.var_6d2384744119499a = spawnStruct();
  self.var_657f5a0d17435bc.var_1e6270fc42010edd = spawnStruct();
  self.var_657f5a0d17435bc.var_9fd058151789294e = spawnStruct();
  self.var_657f5a0d17435bc.var_9fd058151789294e.cashpicked = 0;
  self.var_657f5a0d17435bc.var_9fd058151789294e.var_977a0264ee6a021b = 0;
  self.var_657f5a0d17435bc.var_480aa6483c54887 = spawnStruct();
  self.var_657f5a0d17435bc.var_480aa6483c54887.var_78c14e981c4a4a62 = 0;
  self.var_657f5a0d17435bc.var_480aa6483c54887.anypurchase = 0;
  self.var_657f5a0d17435bc.var_8907faaf3879c3a0 = spawnStruct();
  self.var_657f5a0d17435bc.var_9daf1075af0426fa = spawnStruct();
  self.var_657f5a0d17435bc.var_9daf1075af0426fa.var_3af3cd0524977042 = 1;
  self.var_657f5a0d17435bc.var_f028b7eee8d5ac0d = spawnStruct();
  self.var_657f5a0d17435bc.var_f028b7eee8d5ac0d.var_78f9776e5d16bcfb = "";
  self.var_657f5a0d17435bc.var_ebf862078b683a7a = spawnStruct();
  self.var_657f5a0d17435bc.var_ebf862078b683a7a.var_3af3cd0524977042 = 1;
  self.var_657f5a0d17435bc.var_40834c928484edfb = spawnStruct();
  self.var_657f5a0d17435bc.var_40834c928484edfb.var_654c850c2646f8e0 = 0;
  self.var_657f5a0d17435bc.var_40834c928484edfb.var_55d2955394d9da6f = 0;
  self.var_657f5a0d17435bc.var_40834c928484edfb.anypurchase = 0;
  self.var_657f5a0d17435bc.var_82caa11345c69977 = spawnStruct();
  self.var_657f5a0d17435bc.var_82caa11345c69977.var_3af3cd0524977042 = 1;
  self.var_657f5a0d17435bc.var_cd0ce7cfecde4c03 = spawnStruct();
  self.var_657f5a0d17435bc.var_cd0ce7cfecde4c03.var_ea2fa2c80fead697 = 0;
  self.var_657f5a0d17435bc.var_cd0ce7cfecde4c03.var_78f9776e5d16bcfb = "";
  self.var_657f5a0d17435bc.var_108d73ddf65aa72c = spawnStruct();
  self.var_657f5a0d17435bc.var_108d73ddf65aa72c.var_78f9776e5d16bcfb = "";
  self function_dec6429d4bf84464("MobileFTUEUnScriptedMatchTooltip");

  if(isPlayer(self) && !isbot(self)) {
    self.enabledxp = !function_89e1a31bd1de0567() || !function_ee43f827080726b1();
    self.var_10844ddcb34694ee = function_70781ace6e552a59();
  }
}