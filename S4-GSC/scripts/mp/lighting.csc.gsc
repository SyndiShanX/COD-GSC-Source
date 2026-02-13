/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\lighting\.csc.gsc
*************************************************/

init() {
  if(_func_009F() || _func_009C()) {
    _func_00DF("#x3ea70431c60e87bc", 1);
    _func_00DF("#x3c9770bc1035fb6c", 16);
    _func_00DF("#x3405a466ee34b50bd", "8 0 1 0");
    _func_00DF("#x3992bf4d98eb075aa", 0);
    _func_00DF("#x33e13991f477e4469", 2);
    _func_00DF("#x3579351e851a0921f", 1);
    _func_00DF("#x3c9770bc1035fb6c", 16);
    _func_00DF("#x3c5fdcb456a1e0f2d", 0);
    _func_00DF("#x3b216f9ce3ada90cf", 0);
    _func_00DF("#x394d1da38be4893e7", 0.2);
    _func_00DF("#x3315497e1370274af", 8);
    _func_00DF("#x368bdfdbc24f123de", 1);
    _func_00DF("#x3c0aa0a6ec3acae1a", 8);
    _func_00DF("#x3beed502923a4c08f", 4);
    _func_00DF("#x37d86c21e8a4c3886", 2);
    _func_00DF("#x36953c7226815560c", "128 384 640 1024");
    _func_00DF("#x3c51757bb6571dfe4", 0.25);
    _func_00DF("#x3e6f20dc89ca4522a", 2);
    _func_00DF("#x3e6f20cc89ca44ff7", 2);
    _func_00DF("#x374f34613ef7590ef", 0);
    _func_00DF("#x3931e06e107a35919", 0);
    _func_00DF("#x345d28610c3b32a7f", 0);
    _func_00DF("#x366a409d6a93d9df2", 4);
    _func_00DF("#x3d16c9a360648a055", 1);
    _func_00DF("#x336c71b3429ba36e2", 1);
    _func_00DF("#x316739b0b2f3ad379", 1);
    _func_00DF("#x327cef7ae0eea8806", 0);
    _func_00DF("#x3f93ae5bcf5c3c0c0", 1);
    _func_00DF("#x3fac8f39da5737155", 0);
    _func_00DF("#x38c27879e101d5ae5", 0);
    _func_00DF("#x3c65a53586be74477", 999999);
    _func_00DF("#x33f5b5eb6211f7286", 0);
    _func_00DF("#x33a57ea4edb37c077", 1);
    _func_00DF("#x3bfe2019086956203", 2);
    _func_00DF("#x375846f2cf02aaaf7", 1.5);
    _func_00DF("#x3e4ad4b60f6720dec", 1.5);
    _func_00DF("#x3e92a80b7b2bb786c", 0);
    _func_00DF("#x331fa312c3eaa3b0b", 1);
    _func_00DF("#x3925010e1828c55d2", "0 0 0");
  }

  if(_func_00A0() || _func_009D() || _func_009A()) {
    _func_00DF("#x3ea70431c60e87bc", 1);
    _func_00DF("#x3579351e851a0921f", 1);
    _func_00DF("#x3c9770bc1035fb6c", 16);
    _func_00DF("#x3405a466ee34b50bd", "8 0 1 0");
    _func_00DF("#x3c5fdcb456a1e0f2d", 1);
    _func_00DF("#x3b216f9ce3ada90cf", 1);
    _func_00DF("#x394d1da38be4893e7", 0.2);
    _func_00DF("#x3315497e1370274af", 8);
    _func_00DF("#x368bdfdbc24f123de", 1);
    _func_00DF("#x3c0aa0a6ec3acae1a", 8);
    _func_00DF("#x3beed502923a4c08f", 4);
    _func_00DF("#x37d86c21e8a4c3886", 2);
    _func_00DF("#x36953c7226815560c", "128 384 640 1024");
    _func_00DF("#x3c51757bb6571dfe4", 0.25);
    _func_00DF("#x3e6f20dc89ca4522a", 2);
    _func_00DF("#x3e6f20cc89ca44ff7", 2);
    _func_00DF("#x374f34613ef7590ef", 0);
    _func_00DF("#x3931e06e107a35919", 0);
    _func_00DF("#x345d28610c3b32a7f", 0);
    _func_00DF("#x366a409d6a93d9df2", 4);
    _func_00DF("#x3d16c9a360648a055", 1);
    _func_00DF("#x336c71b3429ba36e2", 1);
    _func_00DF("#x316739b0b2f3ad379", 1);
    _func_00DF("#x327cef7ae0eea8806", 0);
    _func_00DF("#x3f93ae5bcf5c3c0c0", 1);
    _func_00DF("#x3fac8f39da5737155", 0);
    _func_00DF("#x38c27879e101d5ae5", 0);
    _func_00DF("#x3c65a53586be74477", 999999);
    _func_00DF("#x33f5b5eb6211f7286", 0);
    _func_00DF("#x33a57ea4edb37c077", 1);
    _func_00DF("#x3bfe2019086956203", 2);
    _func_00DF("#x375846f2cf02aaaf7", 1.5);
    _func_00DF("#x3e4ad4b60f6720dec", 1.5);
    _func_00DF("#x331fa312c3eaa3b0b", 1);
    _func_00DF("#x3925010e1828c55d2", "0 0 0");
  }

  if(_func_00A0() || _func_009D()) {
    _func_00DF("#x3992bf4d98eb075aa", 1);
    _func_00DF("#x33e13991f477e4469", 2);
  }

  thread winner_circle();
  thread _id_7E24();
  thread ball_turret_mp();
}

winner_circle() {
  for(;;) {
    if(_func_00D5(0, "winner_circle_lgt_dvars") == 1) {
      break;
    } else
      waitframe();
  }

  if(_func_009F() || _func_009C()) {
    _func_00DF("#x3c5fdcb456a1e0f2d", 1);
    _func_00DF("#x3b216f9ce3ada90cf", 1);
    _func_00DF("#x3315497e1370274af", "32");
    _func_00DF("#x3beed502923a4c08f", 8);
    _func_00DF("#x37d86c21e8a4c3886", 6);
    _func_00DF("#x394d1da38be4893e7", 2);
    _func_00DF("#x366a409d6a93d9df2", 16);
    _func_00DF("#x38bca74ab91b300ef", 1);
    _func_00DF("#x3e92a80b7b2bb786c", 0.2);
  }

  if(_func_00A0() || _func_009D() || _func_009A()) {
    _func_00DF("#x3c5fdcb456a1e0f2d", 1);
    _func_00DF("#x3b216f9ce3ada90cf", 1);
    _func_00DF("#x3315497e1370274af", "32");
    _func_00DF("#x3beed502923a4c08f", 8);
    _func_00DF("#x37d86c21e8a4c3886", 6);
    _func_00DF("#x394d1da38be4893e7", 2);
    _func_00DF("#x366a409d6a93d9df2", 16);
    _func_00DF("#x38bca74ab91b300ef", 1);
    _func_00DF("#x3e92a80b7b2bb786c", 0.3);
  }
}

_id_7E24() {
  for(;;) {
    if(_func_00D5(0, "infil_lgt_dvars") == 1) {
      break;
    } else
      waitframe();
  }

  if(_func_009F() || _func_009C()) {
    _func_00DF("#x3c5fdcb456a1e0f2d", 1);
    _func_00DF("#x3b216f9ce3ada90cf", 1);
    _func_00DF("#x3315497e1370274af", "32");
    _func_00DF("#x3beed502923a4c08f", 8);
    _func_00DF("#x37d86c21e8a4c3886", 6);
    _func_00DF("#x394d1da38be4893e7", 1);
    _func_00DF("#x366a409d6a93d9df2", 16);
    _func_00DF("#x38bca74ab91b300ef", 1);
    _func_00DF("#x3e92a80b7b2bb786c", 0.2);
  }

  if(_func_00A0() || _func_009D() || _func_009A()) {
    _func_00DF("#x3c5fdcb456a1e0f2d", 1);
    _func_00DF("#x3b216f9ce3ada90cf", 1);
    _func_00DF("#x3315497e1370274af", "32");
    _func_00DF("#x3beed502923a4c08f", 8);
    _func_00DF("#x37d86c21e8a4c3886", 6);
    _func_00DF("#x394d1da38be4893e7", 1);
    _func_00DF("#x366a409d6a93d9df2", 16);
    _func_00DF("#x38bca74ab91b300ef", 1);
    _func_00DF("#x3e92a80b7b2bb786c", 0.3);
  }

  for(;;) {
    if(_func_00D5(0, "infil_lgt_dvars") == 0) {
      break;
    } else
      waitframe();
  }

  if(_func_009F() || _func_009C()) {
    _func_00DF("#x3c5fdcb456a1e0f2d", 0);
    _func_00DF("#x3b216f9ce3ada90cf", 0);
    _func_00DF("#x3315497e1370274af", "8");
    _func_00DF("#x3beed502923a4c08f", 4);
    _func_00DF("#x37d86c21e8a4c3886", 2);
    _func_00DF("#x394d1da38be4893e7", 0.2);
    _func_00DF("#x366a409d6a93d9df2", 4);
    _func_00DF("#x38bca74ab91b300ef", 0);
    _func_00DF("#x3e92a80b7b2bb786c", 0);
  }

  if(_func_00A0() || _func_009D() || _func_009A()) {
    _func_00DF("#x3c5fdcb456a1e0f2d", 1);
    _func_00DF("#x3b216f9ce3ada90cf", 1);
    _func_00DF("#x3315497e1370274af", "32");
    _func_00DF("#x3beed502923a4c08f", 4);
    _func_00DF("#x37d86c21e8a4c3886", 2);
    _func_00DF("#x394d1da38be4893e7", 0.2);
    _func_00DF("#x366a409d6a93d9df2", 4);
    _func_00DF("#x38bca74ab91b300ef", 0);
    _func_00DF("#x3e92a80b7b2bb786c", 0);
  }
}

ball_turret_mp() {
  for(;;) {
    if(_func_00D5(0, "lgt_ball_turret_killstreak_in_progress") == 1) {
      _func_00DF("#x3925010e1828c55d2", "0 0 10000");
    } else {
      _func_00DF("#x3925010e1828c55d2", "0 0 0");
    }

    waitframe();
  }
}