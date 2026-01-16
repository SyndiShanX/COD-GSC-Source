/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: behaviortree\zombie_grey.gsc
*********************************************/

func_13F2F(var_0) {
  return scripts\aitypes\combat::func_9E8B(var_0, 0);
}

func_13F30(var_0) {
  return lib_0A09::func_13157(var_0, [distance(self.origin, self.enemy.origin), 512, 1024]);
}

func_2AD0() {
  if(isDefined(level.var_119E["zombie_grey"])) {
    return;
  }

  var_0 = spawnStruct();
  var_0.var_1581 = [];
  var_0.var_1581[0] = lib_0A14::func_98C5;
  var_0.var_1581[1] = ::scripts\aitypes\zombie_grey\behaviors::zombiegreyinitmelee;
  var_0.var_1581[2] = lib_0A07::func_97ED;
  var_0.var_1581[3] = ::scripts\aitypes\zombie_grey\behaviors::zombiegreyinithealthregen;
  var_0.var_1581[4] = ::scripts\aitypes\zombie_grey\behaviors::zombiegreyinitduplicatingattack;
  var_0.var_1581[5] = ::scripts\aitypes\zombie_grey\behaviors::zombiegreyinitteleporttoloner;
  var_0.var_1581[6] = ::scripts\aitypes\zombie_grey\behaviors::zombiegreyinitteleportattack;
  var_0.var_1581[7] = ::scripts\aitypes\zombie_grey\behaviors::zombiegreyinitteleportsummon;
  var_0.var_1581[8] = ::scripts\aitypes\zombie_grey\behaviors::zombiegreyinitteleportdash;
  var_0.var_1581[9] = ::scripts\aitypes\combat::func_12E90;
  var_0.var_1581[10] = lib_0BFA::func_3E49;
  var_0.var_1581[11] = lib_0BFA::func_3DE6;
  var_0.var_1581[12] = ::scripts\aitypes\combat::func_9E40;
  var_0.var_1581[13] = ::scripts\aitypes\combat::func_12EC2;
  var_0.var_1581[14] = lib_0A19::func_12F5C;
  var_0.var_1581[15] = ::scripts\aitypes\combat::func_12F28;
  var_0.var_1581[16] = ::scripts\aitypes\zombie_grey\behaviors::zombiegreyassigntargetplayer;
  var_0.var_1581[17] = ::scripts\aitypes\zombie_grey\behaviors::zombiegreycheckhealthregen;
  var_0.var_1581[18] = ::scripts\aitypes\zombie_grey\behaviors::zombiegreyshouldteleportattack;
  var_0.var_1581[19] = ::scripts\aitypes\zombie_grey\behaviors::zombiegreydoteleportattack;
  var_0.var_1581[20] = ::scripts\aitypes\zombie_grey\behaviors::zombiegreyshouldteleportdash;
  var_0.var_1581[21] = ::scripts\aitypes\zombie_grey\behaviors::zombiegreydoteleportdash;
  var_0.var_1581[22] = ::scripts\aitypes\zombie_grey\behaviors::zombiegreyshouldteleporttoloner;
  var_0.var_1581[23] = ::scripts\aitypes\zombie_grey\behaviors::zombiegreydoteleporttoloner;
  var_0.var_1581[24] = ::scripts\aitypes\zombie_grey\behaviors::zombiegreyshouldteleportsummon;
  var_0.var_1581[25] = ::scripts\aitypes\zombie_grey\behaviors::zombiegreydoteleportsummon;
  var_0.var_1581[26] = ::scripts\aitypes\zombie_grey\behaviors::zombiegreyshouldduplicatingattack;
  var_0.var_1581[27] = ::scripts\aitypes\zombie_grey\behaviors::zombiegreydoduplicatingattack;
  var_0.var_1581[28] = lib_0BFA::func_930A;
  var_0.var_1581[29] = lib_0BFA::func_930D;
  var_0.var_1581[30] = lib_0BFA::func_5813;
  var_0.var_1581[31] = lib_0BFA::func_97FA;
  var_0.var_1581[32] = lib_0BFA::func_116F3;
  var_0.var_1581[33] = ::scripts\aitypes\combat::func_FE88;
  var_0.var_1581[34] = ::scripts\aitypes\combat::func_FE6E;
  var_0.var_1581[35] = ::scripts\aitypes\combat::func_FE83;
  var_0.var_1581[36] = lib_0A09::func_E475;
  var_0.var_1581[37] = ::scripts\aitypes\zombie_grey\behaviors::zombiegreyshouldmelee;
  var_0.var_1581[38] = ::scripts\aitypes\zombie_grey\behaviors::greymeleevsplayer_update;
  var_0.var_1581[39] = ::scripts\aitypes\zombie_grey\behaviors::greymeleevsplayer_init;
  var_0.var_1581[40] = ::scripts\aitypes\zombie_grey\behaviors::greymeleevsplayer_terminate;
  var_0.var_1581[41] = ::scripts\aitypes\combat::func_8BF6;
  var_0.var_1581[42] = lib_0A18::func_8BF7;
  var_0.var_1581[43] = ::scripts\aitypes\combat::func_B4EB;
  var_0.var_1581[44] = lib_0A18::func_3928;
  var_0.var_1581[45] = lib_0A18::func_11812;
  var_0.var_1581[46] = lib_0A18::func_1180F;
  var_0.var_1581[47] = lib_0A18::func_11811;
  var_0.var_1581[48] = ::scripts\aitypes\zombie_grey\behaviors::zombiegreyhasweapon;
  var_0.var_1581[49] = ::scripts\aitypes\combat::func_8BC6;
  var_0.var_1581[50] = ::func_13F2F;
  var_0.var_1581[51] = ::func_13F30;
  var_0.var_1581[52] = ::scripts\aitypes\combat::func_DF56;
  var_0.var_1581[53] = ::scripts\aitypes\combat::func_DF53;
  var_0.var_1581[54] = ::scripts\aitypes\combat::func_DF55;
  var_0.var_1581[55] = ::scripts\aitypes\zombie_grey\behaviors::zombiegreymayshoot;
  var_0.var_1581[56] = ::scripts\aitypes\combat::func_8C0B;
  level.var_119E["zombie_grey"] = var_0;
}

func_DEE8() {
  func_2AD0();
  btregistertree("zombie_grey");
}