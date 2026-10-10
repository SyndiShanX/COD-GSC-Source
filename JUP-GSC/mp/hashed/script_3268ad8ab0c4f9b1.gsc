/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_3268ad8ab0c4f9b1.gsc
*************************************************/

#using script_d74ae0b4aa21186;
#namespace namespace_96cc481cde994b55;

function combatconstants() {
  dc1 = function_39b811fb3872bdb8(&function_ea52a9e609588f7f);
  dc_rumble = dc1 function_30e98541032449dd(&function_34217b036153c4dd, "rumble_mgl.*.*");
  var_536229283aee849a = dc1 function_30e98541032449dd(&function_ed98942a69dc1f7d, "champion.*.*");
  var_a4c00fbfa6bc990a = dc1 function_30e98541032449dd(&function_b9e0bed9a47fa74d, "*.babysitter.*");
  return [dc1, dc_rumble, var_536229283aee849a, var_a4c00fbfa6bc990a];
}

function function_ea52a9e609588f7f(constants) {
  constants.var_dfdfb13389358aee = 800;
  constants.nearbyenemydistance = 3900;
  constants.var_96af88c97db9ed21 = [0, 585, 780, 1560, 2340, 2925, 3900, 5850];
  constants.var_49e2976ca0c853ef = [98, 90, 81, 75, 65, 55, 30, 0];
  constants.var_e3f6d868f3c297b2 = [0, 0, 2, 3, 6, 8, 14, 15];
  constants.var_e23500dbd314bae2 = [0.125, 0.25, 0.375, 0.5, 0.625, 0.75, 0.875, 1];
  constants.var_54ee9450d37b6312 = [-8, -5, 0, 0, 0, 5, 13, 20];
  constants.var_58e441d166562d6e = [-10, -8, 0, 5, 10, 15, 20, 25];
  constants.var_e3d1cf896f26ee33 = [195, 780, 1755, 2730];
  constants.var_85a0650f30c0b0b9 = [-5, -20, -30, -40];
  constants.var_d066abbf0bc74501 = getdvarfloat(@ "hash_56c8aed86d79259c", 1);
  constants.var_115b29b18485de3 = [60, getdvarint(@ "hash_f8d2853d99afabab", 1080)];
  constants.var_631e50e6ec9a24a8 = [0, getdvarint(@ "hash_cb472263824538b4", 9)];
  constants.var_36d2e5e6b1e19a3 = [780, 1170, 1560, 2340, 3120, 3900, 4680, 5460, 6240, 7020];
  constants.var_f1ff9682c42f2749 = [0, 20, 45, 50, 65, 55, 40, 28, 12, 0];
  constants.attackermodifier = 16;
  constants.laststandmodifier = -15;
  constants.extragrenadethrow = getdvarint(@ "hash_d118fed8f0c59f4d", 0);
}

function function_34217b036153c4dd(constants) {
  constants.var_dfdfb13389358aee = 1500;
  constants.var_e3d1cf896f26ee33 = [0, 195, 390, 585, 785, 980, 1180, 1375];
  constants.var_85a0650f30c0b0b9 = [0, -2, -5, -10, -15, -20, -25, -35];
  constants.var_115b29b18485de3 = [0, 60];
  constants.var_631e50e6ec9a24a8 = [-1, -1];
}

function function_ed98942a69dc1f7d(constants) {
  constants.var_891066f3bc70edcb = [780, 1170, 1560, 2340, 3120];
  constants.var_55bf1eec1bfddf31 = [30, 40, 50, 20, 10];
  constants.var_e23500dbd314bae2 = [0, 1];
  constants.var_54ee9450d37b6312 = [0, 0];
  constants.var_58e441d166562d6e = [0, 0];
}

function function_b9e0bed9a47fa74d(constants) {
  constants.attackermodifier = 8;
  constants.var_386520f2d17685d5 = 1.8;
}

function wanderconstants() {
  dc1 = function_39b811fb3872bdb8(&function_42109511957edc0c);
  return [dc1];
}

function function_42109511957edc0c(constants) {
  constants.basescore = 5;
  constants.var_bf4b19a689dba773 = getdvarfloat(@ "hash_438164de517b1a31", 1);
  constants.var_b248e7805fbaf822 = [780, 1170, 1560, 1950, 2340, 2730, 3120, 3510, 3900, 4290, 4680, 5070, 5850, 7800, 9750, 11700, 13650, 15600, 17550, 19500, 21450];
  constants.var_375a77fd02b3fcc = [0, 2, 5, 12, 18, 25, 30, 32, 35, 38, 40, 40, 40, 40, 40, 40, 35, 30, 20, 10, 5];
  constants.var_a135e495fbf4cf96 = getdvarint(@ "hash_733bf440cef76e18", 400);
  constants.var_cc9b7ef91fc151b = getdvarint(@ "hash_3b720086ba9ab075", 500);
  constants.var_3145d7adafc61293 = getdvarint(@ "hash_afc3a811d0f18fb9", 5);
}

function function_5d12156b320f8674() {
  dc1 = function_39b811fb3872bdb8(&function_a93cd09a4aa0fc53);
  return [dc1];
}

function function_a93cd09a4aa0fc53(constants) {
  constants.var_3dd54452af7d2b91 = [10, 25, 40, 50, 60, 80, 120];
  constants.var_49e2976ca0c853ef = [89, 60, 45, 35, 20, 10, 0];
  constants.var_5518deaf35f7b0ce = 70;
  constants.var_57228f75b014a7b8 = 6;
  constants.var_daec6fd98c7cee50 = 15;
}

function pickupconstants() {
  dc1 = function_39b811fb3872bdb8(&function_4182e943a8ef2e47);
  return [dc1];
}

function function_4182e943a8ef2e47(constants) {
  constants.var_5dcbc5ccec64f7de = 100;
  constants.sightrange = 500;
  constants.valuetable = spawnStruct();
  constants.valuetable.typevalue = [];
  constants.valuetable.typevalue[#"ammo"] = 27;
  constants.valuetable.typevalue[#"gear"] = 33;
  constants.valuetable.typevalue[#"health"] = 27;
  constants.valuetable.typevalue[#"revive"] = -100;
  constants.valuetable.typevalue[#"lethal"] = 27;
  constants.valuetable.typevalue[#"tactical"] = 26;
  constants.valuetable.typevalue[#"killstreak"] = 26;
  constants.valuetable.typevalue[#"super"] = 26;
  constants.valuetable.typevalue[#"cache"] = 40;
  constants.valuetable.typevalue[#"weapon"] = 40;
  constants.valuetable.typevalue[function_1823ff50bb28148d("ammo_restock")] = 30;
  constants.valuetable.typevalue[#"plunder"] = 28;
  constants.valuetable.lootvalue = [];
  constants.valuetable.lootvalue["brloot_offhand_semtex"] = 29;
  constants.valuetable.lootvalue["brloot_offhand_throwingknife"] = 26;
  constants.valuetable.lootvalue["brloot_offhand_thermite"] = 27;
  constants.valuetable.lootvalue["brloot_offhand_frag"] = 27;
  constants.valuetable.lootvalue["brloot_offhand_c4"] = 26;
  constants.valuetable.lootvalue["brloot_offhand_molotov"] = 27;
  constants.valuetable.lootvalue["brloot_offhand_claymore"] = 26;
  constants.valuetable.lootvalue["brloot_offhand_atmine"] = 26;
  constants.valuetable.lootvalue["brloot_offhand_heartbeatsensor"] = 40;
  constants.valuetable.lootvalue["brloot_offhand_concussion"] = 28;
  constants.valuetable.lootvalue["brloot_health_adrenaline"] = 27;
  constants.valuetable.lootvalue["brloot_offhand_flash"] = 27;
  constants.valuetable.lootvalue["brloot_offhand_smoke"] = 27;
  constants.valuetable.lootvalue["brloot_offhand_gas"] = 27;
  constants.valuetable.lootvalue["brloot_offhand_snapshot"] = 26;
  constants.valuetable.lootvalue["brloot_offhand_decoy"] = 26;
  constants.valuetable.lootvalue["brloot_offhand_snapshot"] = 26;
  constants.valuetable.lootvalue["brloot_killstreak_uav_bigmap"] = 42;
  constants.valuetable.lootvalue["brloot_killstreak_precision_airstrike"] = 35;
  constants.valuetable.lootvalue["brloot_killstreak_clusterstrike"] = 33;
  constants.valuetable.lootvalue["brloot_super_armorbox"] = 42;
  constants.valuetable.lootvalue["brloot_super_munitionsbox"] = 39;
  constants.valuetable.lootvalue["brloot_super_deadsilence"] = 33;
  constants.var_6c134b04a6e15e0f = [390, 585, 780, 975, 1170, 1365, 1560, 1755, 1950];
  constants.var_eea720f577a76b0b = [24, 21, 18, 15, 12, 9, 6, 3, 0];
  constants.var_65a3f0d7a3f96f0f = constants.var_6c134b04a6e15e0f[constants.var_6c134b04a6e15e0f.size - 1];
  constants.var_e23500dbd314bae2 = [0.125, 0.25, 0.375, 0.5, 0.625, 0.75, 0.875, 1];
  constants.var_e58a5e1efeb78937 = [10, 8, 6, 2, 0, -5, -8, -10];
  constants.var_2e392955e7388247 = [0.125, 0.25, 0.375, 0.5, 0.625, 0.75, 0.875, 1];
  constants.var_b516486de7d13311 = [23, 25, 26, 28, 20, 15, 0, 0];
  constants.var_de1c985391b99a2b = [20, 18, 15, 5, 0, 0, 0, 0];
  constants.var_e749e36fec025a10 = [20, 20, 15, 5, 0, 0, 0, 0];
  constants.var_3f74fc9a89bd6f1e = [10, 8, 5, 0, 0, 0, 0, 0];
  constants.var_2ecab98395f8d2f8 = [20, 20, 15, 5, 0, 0, 0, 0];
  constants.var_7604b66fc0bf7887 = [0, 1950, 3900, 5850, 7800, 9750];
  constants.var_9ba7c398de3ab6b8 = [8, 3, 1, 0, -10, -15];
  constants.var_18143b1f14cc381d = [390, 585, 780, 975, 1170, 1365, 1560, 1755, 1950];
  constants.var_c82fa9468a010a2 = [26, 23, 20, 18, 15, 13, 9, 7, 5];
  constants.var_c0c5b5dd018dc8cf = 30;
  constants.var_93bcc2b99d24433f = [9, 13];
  constants.var_5107f0b927dad2b = [-40, 0];
  constants.var_65789424b6d020cc = -10;
  constants.var_57228f75b014a7b8 = 5;
  constants.var_daec6fd98c7cee50 = 10;
  constants.var_aeaac16f3357bcae = squared(32) + squared(72);
}

function function_d5a3be7287e9a86a() {
  dc1 = function_39b811fb3872bdb8(&function_ce9046b5b9375f11);
  return [dc1];
}

function function_ce9046b5b9375f11(constants) {
  constants.basescore = 40;
  constants.var_df15d9eff00563be = 16000;
  constants.var_e8b4534f27490bc4 = [0, 1, 2, 5];
  constants.var_ffd2b6629c92a80d = [-20, -5, 0, 30];
}

function function_7a44b3ec454cfba0() {
  dc1 = function_39b811fb3872bdb8(&function_ea71b8f2ce79205b);
  var_a4c00fbfa6bc990a = dc1 function_30e98541032449dd(&function_655543cdc2f1cf39, "*.babysitter.*");
  return [dc1, var_a4c00fbfa6bc990a];
}

function function_ea71b8f2ce79205b(constants) {
  constants.targettype = "human";
  constants.basescore = 40;
  constants.var_6b536e17b179b18c = 4900;
  constants.var_ca44fa65dc21651a = [0, 197, 394, 591, 787, 984, 1181, 1378, 1575, 1772, 1969, 2165, 2362, 2559, 2756, 2953, 3150, 3346, 3543, 3740, 3937, 4134, 4331, 4528, 4724, 4921];
  constants.var_e6f117499091fd02 = [-20, -20, -20, -20, -20, -20, -20, -16, -11, -6, -1, 4, 9, 12, 16, 19, 20, 20, 20, 20, 16, 12, 9, 4, -1, -6];
}

function function_655543cdc2f1cf39(constants) {
  constants.targettype = "bot";
}

function function_5c136b5eb48ca3cf() {
  dc1 = function_39b811fb3872bdb8(&function_bf7f709607210cae);
  var_536229283aee849a = dc1 function_30e98541032449dd(&function_a467c066ba4a47b6, "champion.*.*");
  var_a4c00fbfa6bc990a = dc1 function_30e98541032449dd(&function_b04842c4d28aba56, "*.babysitter.*");
  return [dc1, var_536229283aee849a, var_a4c00fbfa6bc990a];
}

function function_bf7f709607210cae(constants) {
  constants.basescore = 40;
  constants.var_ae436a56f4dc7add = 150;
  constants.var_a8d37f0ea66f877f = [0, 195, 390, 585, 780, 975, 1170, 1365, 1560, 1755, 1950, 2145, 2340, 2535, 2730, 2925];
  constants.var_71bdba3f5c7a939d = [-15, -13, -10, -8, -5, -3, 0, 2, 5, 7, 9, 12, 14, 17, 19, 20];
}

function function_a467c066ba4a47b6(constants) {
  constants.var_ae436a56f4dc7add = 50;
}

function function_b04842c4d28aba56(constants) {
  constants.var_ae436a56f4dc7add = 100;
}

function function_5bf82db35aea77e5() {
  dc1 = function_39b811fb3872bdb8(&function_9491337bc348bca8);
  return [dc1];
}

function function_9491337bc348bca8(constants) {
  constants.var_96af88c97db9ed21 = [0, 975, 1950, 3120, 3900];
  constants.var_49e2976ca0c853ef = [63, 43, 30, 15, 0];
  constants.var_6477b93fa7db5161 = [0, 3500];
  constants.var_afb9ac7095182ae5 = [-20, 0];
  constants.var_48b2040db1860373 = getdvarfloat(@ "hash_37bbfb694b0e93ac", 1);
}

function function_aee45e6f09410216() {
  dc1 = function_39b811fb3872bdb8(&function_d75b7b128b443427);
  return [dc1];
}

function function_d75b7b128b443427(constants) {
  constants.var_e34f223c4f415ed0["brloot_armor_plate"] = "brloot_armor_plate";
  constants.var_e34f223c4f415ed0["brloot_equip_gasmask"] = "brloot_equip_gasmask";
  constants.var_e34f223c4f415ed0["brloot_self_revive"] = "brloot_self_revive";
  constants.var_e34f223c4f415ed0["super_ammo_drop"] = "brloot_super_munitionsbox";
  constants.var_e34f223c4f415ed0["super_armor_drop"] = "brloot_super_armorbox";
  constants.var_e34f223c4f415ed0["tomaStrike"] = "brloot_killstreak_clusterstrike";
  constants.var_e34f223c4f415ed0["uavStreak_bigmap"] = "brloot_killstreak_uav_bigmap";
  constants.var_e34f223c4f415ed0["precisionAirstrike"] = "brloot_killstreak_precision_airstrike";
  constants.var_ea186a77c016a88d = [390, 3900, 7800, 11700];
  constants.var_9551c1a2c6f5863 = [30, 25, 20, 12];
  constants.var_93bcc2b99d24433f = [9, 14];
  constants.var_5107f0b927dad2b = [-50, 0];
  constants.var_8e95bda6c02d6964 = [20, 40, 60, 80];
  constants.var_2a7a0c76f330e72d = [-30, -10, 0, 5];
  constants.var_e23500dbd314bae2 = [0.125, 0.25, 0.375, 0.5, 0.625, 0.75, 0.875, 1];
  constants.var_e58a5e1efeb78937 = [0, 2, 5, 8, 2, -5, -7, -10];
  constants.var_79eef5a8e34ac410 = [0, 780, 1950];
  constants.var_ca580a719e470379 = [-50, -10, 0];
  constants.var_7d0fd6ff10edefd6["brloot_armor_plate"] = 1;
  constants.var_7d0fd6ff10edefd6["brloot_equip_gasmask"] = 2;
  constants.var_7d0fd6ff10edefd6["brloot_self_revive"] = 2;
  constants.var_7d0fd6ff10edefd6["super_ammo_drop"] = 3;
  constants.var_7d0fd6ff10edefd6["super_armor_drop"] = 4;
  constants.var_7d0fd6ff10edefd6["tomaStrike"] = 3;
  constants.var_7d0fd6ff10edefd6["uavStreak_bigmap"] = 5;
  constants.var_7d0fd6ff10edefd6["precisionAirstrike"] = 4;
}

function function_bcfc6cfe13faa2f2() {
  dc1 = function_39b811fb3872bdb8(&function_549e53d66028483b);
  return [dc1];
}

function function_549e53d66028483b(constants) {
  constants.var_87f34cf0d41d251d = [780, 1950, 3900, 7800, 9750];
  constants.var_38a8985512b3e7b3 = [40, 36, 32, 20, 15];
  constants.var_93bcc2b99d24433f = [9, 14];
  constants.var_5107f0b927dad2b = [-50, 0];
  constants.var_79eef5a8e34ac410 = [0, 780, 1950];
  constants.var_ca580a719e470379 = [-50, -10, 0];
  constants.var_2d40425ebda06605 = getdvarfloat(@ "hash_c5435ed163fdbc98", 1);
}

function function_d4bd9ff9c32e7fd6() {
  dc1 = function_39b811fb3872bdb8(&function_8d42c4865dd407c7);
  var_a4c00fbfa6bc990a = dc1 function_30e98541032449dd(&function_bdae70656375edb5, "*.babysitter.*");
  return [dc1, var_a4c00fbfa6bc990a];
}

function function_8d42c4865dd407c7(constants) {
  constants.var_96af88c97db9ed21 = [0, 195, 390, 585, 780, 975, 1170, 1365, 1560, 1755, 1950, 2145, 2340, 2535, 2730, 2925, 3120, 3315, 3510, 3705, 3900];
  constants.var_7d7f72df5616d9e8 = [60, 58, 56, 54, 52, 50, 47, 43, 40, 37, 33, 30, 28, 23, 20, 6, 0, -6, -12, -18, -24];
  constants.var_d114ba8784fcab24 = [0, 3, 6, 9, 12, 15, 18, 21, 24, 27, 30];
  constants.var_bf755758ae9ab4ed = [6, 5, 3, 0, -1, -2, -3, -4, -6, -8, -10];
}

function function_bdae70656375edb5(constants) {
  constants.var_96af88c97db9ed21 = [0, 390, 975, 1170, 1365, 1950, 3120, 3900];
  constants.var_7d7f72df5616d9e8 = [56, 50, 43, 37, 28, 30, 0, -24];
  constants.var_d114ba8784fcab24 = [0, 6, 12, 18, 24, 27];
  constants.var_bf755758ae9ab4ed = [2, -2, -4, -6, -8, -12];
}

function function_8f613fdda808e996() {
  dc1 = function_39b811fb3872bdb8(&function_d0038f06984cfe83);
  return [dc1];
}

function function_d0038f06984cfe83(constants) {
  constants.eventtypevalues = [];
  constants.eventtypevalues["bullet_whizby"] = 35;
  constants.eventtypevalues["projectile_impact"] = 25;
  constants.eventtypevalues["gunshot"] = 20;
  constants.eventtypevalues["silenced_shot"] = 15;
  constants.eventtypevalues["death"] = 30;
  constants.eventtypevalues["can_see"] = 27;
  constants.eventtypevalues["radar"] = 20;
  constants.var_436444ebcb6bf7b3 = [0, 195, 390, 585, 780, 975, 1170, 1365, 1560, 1755, 1950, 2145, 2340, 2535, 2730, 2925, 3120, 3315, 3510, 3705, 3900];
  constants.var_e8de868e20882c8a = [40, 38, 36, 34, 32, 30, 27, 23, 20, 17, 13, 10, 8, 3, 0, -14, -20, -26, -32, -38, -44];
  constants.eventtypevalues["footstep"] = 10;
  constants.eventtypevalues["footstep_walk"] = 5;
  constants.eventtypevalues["footstep_sprint"] = 15;
  constants.var_1c1e326edfaee326 = [0, 195, 390, 585, 780, 975, 1170, 1365, 1560, 1755, 1950, 2145, 2340, 2535, 2730, 2925, 3120, 3315, 3510, 3705, 3900];
  constants.var_b17cbf80b52df82f = [20, 18, 16, 14, 12, 10, 7, 3, 0, -3, -7, -10, -12, -17, -20, -34, -40, -46, -52, -58, -64];
  constants.var_50cf5a797d61ae47 = [2, 4, 6, 8, 20, 30];
  constants.var_f65cad93a3671678 = [0, -2, -4, -6, -10, -20];
  constants.var_931b4359890cef33 = [1, 2, 3, 4, 5];
  constants.var_188ae31c05e38b7c = [3, 6, 9, 12, 14];
}

function function_2ca23c5b750be895() {
  dc1 = function_39b811fb3872bdb8(&function_408c5fefe9f70f50);
  return [dc1];
}

function function_408c5fefe9f70f50(constants) {
  constants.var_d0708c53f9aedbbe = 0.2;
  constants.var_96af88c97db9ed21 = [0, 780, 1560, 2340, 3120, 3900, 4680, 5460, 6240, 7020, 7800];
  constants.var_49e2976ca0c853ef = [26, 26, 24, 22, 20, 19, 18, 17, 15, 10, 5];
  constants.var_e23500dbd314bae2 = [0.125, 0.25, 0.375, 0.5, 0.625, 0.75, 0.875, 1];
  constants.var_e58a5e1efeb78937 = [-5, 0, 6, 8, 10, 4, -4, -5];
}

function function_194933a246c12c3f() {
  dc1 = function_39b811fb3872bdb8(&function_cbdbedbc80917462);
  return [dc1];
}

function function_cbdbedbc80917462(constants) {
  constants.var_b9de038abd473868 = 40;
  constants.var_d0708c53f9aedbbe = 0.2;
  constants.var_96af88c97db9ed21 = [0, 195, 390, 585, 780, 975, 1170, 1365, 1560, 1755, 1950, 2145, 2340, 2535, 2730, 2925, 3120, 3315, 3510, 3705, 3900];
  constants.var_49e2976ca0c853ef = [40, 40, 65, 85, 100, 98, 96, 91, 86, 80, 74, 68, 60, 57, 54, 51, 47, 43, 40, 35, 30];
  constants.attackermodifier = 10;
  constants.extragrenadethrow = getdvarint(@ "hash_7fc4f004028aa76", 0);
}

function function_222ab0653b177ae() {
  dc1 = function_39b811fb3872bdb8(&function_e427b92324dba47b);
  return [dc1];
}

function function_e427b92324dba47b(constants) {
  constants.basescore = 40;
  constants.var_2070b5f48167a4a = 3880900;
}

function function_6e26a8349c0590a8() {
  dc1 = function_39b811fb3872bdb8(&function_74792fdb82e112c5);
  return [dc1];
}

function function_74792fdb82e112c5(constants) {
  constants.basescore = 20;
  constants.var_cf22d0ed88800557 = 30;
}

function function_40064f9911317199() {
  dc1 = function_39b811fb3872bdb8(&function_19c20b422937d448);
  var_6f3a418463686a32 = dc1 function_30e98541032449dd(&function_4504149d2661de5b, "*.*.recruit");
  return [dc1, var_6f3a418463686a32];
}

function function_19c20b422937d448(constants) {
  constants.var_3b344b36c6469a5d = 10;
  constants.var_e41be6ba8b297901 = 60;
  constants.var_bd58d59c468151dd = 500;
  constants.basescore = 150;
}

function function_4504149d2661de5b(constants) {
  constants.var_3b344b36c6469a5d = 6;
}

function retreatconstants() {
  dc1 = function_39b811fb3872bdb8(&function_1216d39bcd3fb5de);
  return [dc1];
}

function function_1216d39bcd3fb5de(constants) {
  constants.nearbyenemydistance = 5800;
  constants.var_96af88c97db9ed21 = [195, 390, 975, 1950, 3900];
  constants.var_49e2976ca0c853ef = [-30, 20, 52, 65, 75];
  constants.var_b8eb6b85b8ebb591 = [-1, -0.5, 0, 0.5, 1];
  constants.var_aa7751bb8bb0bf4e = [25, 17, 10, 4, -5];
  constants.var_dff6f563a1619566 = [0, 0.2, 0.4, 0.6, 0.8, 1];
  constants.var_6b5b5a20f3356ee3 = [45, 33, 30, 18, 5, -5];
  constants.armormodifier = 5;
  constants.var_d318160b4ec63dc6 = [0, 0.5, 1];
  constants.var_b42a419b44acd2c3 = [27, 14, -5];
}