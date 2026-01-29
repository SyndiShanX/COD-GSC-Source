/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1568.gsc
**************************************/

#using_animtree("vehicles");

main(var_0, var_1, var_2) {
  var_3 = "mi17";

  if(isDefined(var_1) && var_1 == "mi17_so") {
    var_3 = "mi17_so";
  } else if(isDefined(var_1) && var_1 == "mi17_so_takes_damage") {
    var_3 = "mi17_so_takes_damage";

  }
  _id_061D::main(var_0, var_3, var_2);
  maps\_vehicle::_id_2AC1( % mi17_heli_rotors, undefined, 0);
  maps\_vehicle::_id_2ABE("vehicle_mi17_woodland");
  maps\_vehicle::_id_2ABE("vehicle_mi17_woodland_fly");
  maps\_vehicle::_id_2ABE("vehicle_mi17_woodland_landing");
  maps\_vehicle::_id_2ABE("vehicle_mi17_woodland_fly_cheap");
  maps\_vehicle::_id_2AD2(::_id_2B1D);
  maps\_vehicle::_id_2AC5();
  maps\_vehicle::_id_2ACA(::_id_3A9D, ::_id_3A9C);
  maps\_vehicle::_id_2ACC(::_id_3E84);
  maps\_vehicle::_id_2ACD(::_id_3E58);
}

_id_2B1D() {
  if(maps\_utility::_id_1E25()) {
    self._id_295E = distance(self gettagorigin("tag_origin"), self gettagorigin("tag_ground"));
    self._id_295A = 710;
  } else {
    self._id_295A = 710 + distance(self gettagorigin("tag_origin"), self gettagorigin("tag_ground"));

  }
  self._id_2941 = 0;
  maps\_vehicle::_id_2AB3("running");
}

_id_3A9C(var_0) {
  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_0[var_1]._id_2523 = % mi17_heli_idle;

  }
  return var_0;
}

_id_3E83(var_0) {
  return var_0;
}

#using_animtree("generic_human");

_id_3A9D() {
  var_0 = [];

  for(var_1 = 0; var_1 < 10; var_1++) {
    var_0[var_1] = spawnStruct();

  }
  var_0[1]._id_0F59 = % mi17_1_idle;
  var_0[2]._id_0F59 = % mi17_2_idle;
  var_0[3]._id_0F59 = % mi17_3_idle;
  var_0[4]._id_0F59 = % mi17_4_idle;
  var_0[5]._id_0F59 = % mi17_5_idle;
  var_0[6]._id_0F59 = % mi17_6_idle;
  var_0[7]._id_0F59 = % mi17_7_idle;
  var_0[8]._id_0F59 = % mi17_8_idle;
  var_0[0]._id_0F59[0] = % helicopter_pilot1_idle;
  var_0[0]._id_0F59[1] = % helicopter_pilot1_twitch_clickpannel;
  var_0[0]._id_0F59[2] = % helicopter_pilot1_twitch_lookback;
  var_0[0]._id_0F59[3] = % helicopter_pilot1_twitch_lookoutside;
  var_0[0]._id_254D[0] = 500;
  var_0[0]._id_254D[1] = 100;
  var_0[0]._id_254D[2] = 100;
  var_0[0]._id_254D[3] = 100;
  var_0[0]._id_24F4 = 0;
  var_0[9]._id_24F4 = 0;
  var_0[9]._id_0F59[0] = % helicopter_pilot2_idle;
  var_0[9]._id_0F59[1] = % helicopter_pilot2_twitch_clickpannel;
  var_0[9]._id_0F59[2] = % helicopter_pilot2_twitch_lookoutside;
  var_0[9]._id_0F59[3] = % helicopter_pilot2_twitch_radio;
  var_0[9]._id_254D[0] = 450;
  var_0[9]._id_254D[1] = 100;
  var_0[9]._id_254D[2] = 100;
  var_0[9]._id_254D[3] = 100;
  var_0[0]._id_24F2 = "tag_driver";
  var_0[1]._id_24F2 = "tag_detach";
  var_0[2]._id_24F2 = "tag_detach";
  var_0[3]._id_24F2 = "tag_detach";
  var_0[4]._id_24F2 = "tag_detach";
  var_0[5]._id_24F2 = "tag_detach";
  var_0[6]._id_24F2 = "tag_detach";
  var_0[7]._id_24F2 = "tag_detach";
  var_0[8]._id_24F2 = "tag_detach";
  var_0[9]._id_24F2 = "tag_passenger";
  var_0[1]._id_257C = % mi17_1_drop;
  var_0[2]._id_257C = % mi17_2_drop;
  var_0[3]._id_257C = % mi17_3_drop;
  var_0[4]._id_257C = % mi17_4_drop;
  var_0[5]._id_257C = % mi17_5_drop;
  var_0[6]._id_257C = % mi17_6_drop;
  var_0[7]._id_257C = % mi17_7_drop;
  var_0[8]._id_257C = % mi17_8_drop;
  var_0[1]._id_259A = "crouch";
  var_0[2]._id_259A = "crouch";
  var_0[3]._id_259A = "crouch";
  var_0[4]._id_259A = "crouch";
  var_0[5]._id_259A = "crouch";
  var_0[6]._id_259A = "crouch";
  var_0[7]._id_259A = "crouch";
  var_0[8]._id_259A = "crouch";
  var_0[2]._id_2571 = 1;
  var_0[3]._id_2571 = 1;
  var_0[4]._id_2571 = 1;
  var_0[5]._id_2571 = 1;
  var_0[6]._id_2571 = 1;
  var_0[7]._id_2571 = 1;
  var_0[8]._id_2571 = 1;
  var_0[2]._id_2592 = % fastrope_fall;
  var_0[3]._id_2592 = % fastrope_fall;
  var_0[4]._id_2592 = % fastrope_fall;
  var_0[5]._id_2592 = % fastrope_fall;
  var_0[6]._id_2592 = % fastrope_fall;
  var_0[7]._id_2592 = % fastrope_fall;
  var_0[8]._id_2592 = % fastrope_fall;
  var_0[1]._id_2590 = 1;
  var_0[2]._id_2590 = 1;
  var_0[3]._id_2590 = 1;
  var_0[4]._id_2590 = 1;
  var_0[5]._id_2590 = 1;
  var_0[6]._id_2590 = 1;
  var_0[7]._id_2590 = 1;
  var_0[8]._id_2590 = 1;
  var_0[1]._id_258D = "fastrope_loop_npc";
  var_0[2]._id_258D = "fastrope_loop_npc";
  var_0[3]._id_258D = "fastrope_loop_npc";
  var_0[4]._id_258D = "fastrope_loop_npc";
  var_0[5]._id_258D = "fastrope_loop_npc";
  var_0[6]._id_258D = "fastrope_loop_npc";
  var_0[7]._id_258D = "fastrope_loop_npc";
  var_0[8]._id_258D = "fastrope_loop_npc";
  var_0[1]._id_256A = "TAG_FastRope_RI";
  var_0[2]._id_256A = "TAG_FastRope_RI";
  var_0[3]._id_256A = "TAG_FastRope_RI";
  var_0[4]._id_256A = "TAG_FastRope_RI";
  var_0[5]._id_256A = "TAG_FastRope_LE";
  var_0[6]._id_256A = "TAG_FastRope_LE";
  var_0[7]._id_256A = "TAG_FastRope_LE";
  var_0[8]._id_256A = "TAG_FastRope_LE";
  return _id_3E83(var_0);
}

_id_3E58() {
  var_0 = [];
  var_0["back"] = [];
  var_0["front"] = [];
  var_0["both"] = [];
  var_0["back"][var_0["back"].size] = 1;
  var_0["back"][var_0["back"].size] = 2;
  var_0["back"][var_0["back"].size] = 3;
  var_0["back"][var_0["back"].size] = 4;
  var_0["front"][var_0["front"].size] = 5;
  var_0["front"][var_0["front"].size] = 6;
  var_0["front"][var_0["front"].size] = 7;
  var_0["front"][var_0["front"].size] = 8;
  var_0["both"][var_0["both"].size] = 1;
  var_0["both"][var_0["both"].size] = 2;
  var_0["both"][var_0["both"].size] = 3;
  var_0["both"][var_0["both"].size] = 4;
  var_0["both"][var_0["both"].size] = 5;
  var_0["both"][var_0["both"].size] = 6;
  var_0["both"][var_0["both"].size] = 7;
  var_0["both"][var_0["both"].size] = 8;
  var_0["default"] = var_0["both"];
  return var_0;
}

_id_3E84() {
  var_0 = [];
  var_0["TAG_FastRope_LE"] = spawnStruct();
  var_0["TAG_FastRope_LE"].model = "rope_test";
  var_0["TAG_FastRope_LE"].tag = "TAG_FastRope_LE";
  var_0["TAG_FastRope_LE"]._id_2018 = % mi17_rope_idle_le;
  var_0["TAG_FastRope_LE"]._id_2577 = % mi17_rope_drop_le;
  var_0["TAG_FastRope_RI"] = spawnStruct();
  var_0["TAG_FastRope_RI"].model = "rope_test_ri";
  var_0["TAG_FastRope_RI"].tag = "TAG_FastRope_RI";
  var_0["TAG_FastRope_RI"]._id_2018 = % mi17_rope_idle_ri;
  var_0["TAG_FastRope_RI"]._id_2577 = % mi17_rope_drop_ri;
  var_1 = getarraykeys(var_0);

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    precachemodel(var_0[var_1[var_2]].model);

  }
  return var_0;
}