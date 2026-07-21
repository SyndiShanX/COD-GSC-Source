/*********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\maps\cp_so_embassy\cp_so_embassy_alley.gsc
*********************************************************/

alley_start() {
  scripts\engine\utility::flag_wait("_encstr_A2A3086439CBF1DF3C8A");
  var_0 = scripts\engine\utility::getStruct("_encstr_8CA90DEF08E015E3C747DB52A31FBF", "_encstr_B2CE0BA1D0FB19FDC54613D9BF").origin;
  var_1 = _encstr_AAA6354790C3F99371266D768F9F1AB9EB68BE9FA0DE3BAACF35C52E7F0F3359D840BBE720305F72935ECE625EE3C91D1B88439A68EBDB::_id_134ED("_encstr_8F1B0ECD900917C027088B92C0AD3F93", _encstr_AAA6354790C3F99371266D768F9F1AB9EB68BE9FA0DE3BAACF35C52E7F0F3359D840BBE720305F72935ECE625EE3C91D1B88439A68EBDB::propchange(16), var_0);

  foreach(var_3 in var_1) {
    if(var_3.origin == (-2177.8, -850.952, 56)) {
      var_4 = scripts\cp\cp_weapon::buildweapon("_encstr_925D13A28841F9E728B06A7FB1514FE8B74A497A18", ["_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99"], "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99");
      var_3 thread _encstr_842518E6D8395A38A3B9BC0B73B4AD5EB9862CE4AC8CE23BDC1B::forceuseweapon(var_4, "_encstr_BA7F0830B3A7859B60B0");
    }
  }

  thread brmoderemovefromteamlives();
  thread _encstr_8F0137E6D89C4B073A9BCB3683F2B658386E798DC1AFE6B77D956B4C0B9BB9F297361CBEDCDB7D59ADC4C2CD9BBCF519CA33957323E276CDB1::his_playerdisconnect();
  scripts\engine\utility::flag_clear("_encstr_864715CDC158EE73B473B3FAB437D71C27B7B327ACB9E6");
  thread first_convoy();
}

brmoderemovefromteamlives() {
  var_0 = scripts\cp\laser_traps\cp_laser_traps::_id_134F1("_encstr_83DB1813B68FB873B7F2B35EBA132F716715879B3233E13147AA", (-2009.28, -486.884, 60), (0, 270, 0), 1, 1);
  var_1 = scripts\engine\utility::spawn_tag_origin(var_0.origin, var_0.angles);
  var_0 endon("_encstr_AD75063D571AE108");
  var_0.goalradius = 50;
  var_0 allowedstances("_encstr_922406F1A6FD5E05");
  waitframe();
  var_0.baseaccuracy = 0.1;
  var_0.ignoresuppression = 1;
  var_0 linkTo(var_1);
  scripts\engine\utility::flag_wait("_encstr_A16309A525E2C10FE71B28");
  var_0 allowedstances("_encstr_922406F1A6FD5E05", "_encstr_B13D076BED70539F23", "_encstr_A5AD069B231F0BAF");
  var_0 unlink();
  var_0.goalradius = 1000;
}

brloadoutcratepostcapture() {
  var_0 = getdvarint("_encstr_AA5C11E338661FDD4570435BA8E79293191E6C", 0);

  if(var_0 <= 2) {
    var_1 = getEnt("_encstr_BAF30A858D1B5ED734CA8D96", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    var_2 = _encstr_AAA6354790C3F99371266D768F9F1AB9EB68BE9FA0DE3BAACF35C52E7F0F3359D840BBE720305F72935ECE625EE3C91D1B88439A68EBDB::_id_134F0("_encstr_843A1A8E58B0A9397E213F6F752DB3FB8160075510D17F2358337B3B");
    level.infil_heli = var_1 scripts\common\vehicle::spawn_vehicle_and_gopath();
    level.infil_heli thread _encstr_81AE300BC6CB74723C98C213A04E500BE92BAF6352E1471F670D59C9A7DF1F8BCAD9CBF1568F716F03F191872BE9AAB2F65E::givequestrewardgroup();
    level.infil_heli thread steve();
    thread steam_trigger();
  }
}

steam_trigger() {
  wait 4;
  thread _encstr_AAA6354790C3F99371266D768F9F1AB9EB68BE9FA0DE3BAACF35C52E7F0F3359D840BBE720305F72935ECE625EE3C91D1B88439A68EBDB::_id_12758("_encstr_BAEB23C5808733DF5DF9B88012F68748C70CDBD0F163BB2D05E21060C90CAD410FA4489F18");
  level.infil_heli waittill("_encstr_BD82096B5DA4B07F924F29");
  wait 1;
  _encstr_AAA6354790C3F99371266D768F9F1AB9EB68BE9FA0DE3BAACF35C52E7F0F3359D840BBE720305F72935ECE625EE3C91D1B88439A68EBDB::_id_12758("_encstr_91EB238CC3F5B37BAD7DAE9BC636AF86B2365A7D2C8338E4BD161B1ABE96CD994B8DF52318");
  wait 1;
  var_0 = sortbydistance(getaiarray("_encstr_9A8507BA4040188D08"), level.player.origin)[0];
  var_0 playSound("_encstr_AAD623C8F0D7CEB7B6D7EADC8CBED8BD379DB7977D85B5C45DDC0DF585471DB0D85BAF13C0");
}

steve() {
  var_0 = scripts\engine\utility::getStruct("_encstr_818B1BB0B18DE5F56E1C16BB3756E46EBE34AC1B4B7D83C23A86AFC0C4", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  self.target = undefined;
  self settargetyaw(var_0.angles[1]);
  self vehicle_teleport(var_0.origin, var_0.angles);
  self setvehgoalpos(var_0.origin, 1);
  self vehicle_setspeedimmediate(0);
  self sethoverparams(300, 20, 10);
  thread scripts\common\vehicle::vehicle_unload("_encstr_8B1608EC43B8D647A113");
  thread scripts\common\vehicle::attach_vehicle_and_gopath(var_0);
  self waittill("_encstr_BD82096B5DA4B07F924F29");
  var_1 = scripts\engine\utility::getStruct("_encstr_AA8B1B872DF2C3C65BE310A8B365BB0F29D40D99C4799949249BD98A3A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  self vehicle_setspeed(20, 20, 20);
  thread scripts\common\vehicle::vehicle_paths(var_1);
  scripts\common\vehicle_paths::gopath(self);
  self waittill("_encstr_8B7205D9ED5958");

  foreach(var_3 in self.riders)
  var_3 scripts\cp\laser_traps\cp_laser_traps::ks_pointstowin();

  self delete();
}

_id_11A6E() {
  self.attackeraccuracy = 0.1;
  self.health = 1000;

  for(;;) {
    self waittill("_encstr_B2BE0788BAF573592F", var_0, var_1);
    self.health = self.health + var_0;
  }
}

bridge_two_death_func(var_0, var_1, var_2) {
  var_3 = getEnt(var_0, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(!isDefined(var_3) || !isDefined(level.allies) || level.allies.size < 1) {
    return;
  }
  var_4 = scripts\engine\utility::array_removedead_or_dying(level.allies);

  foreach(var_6 in var_4) {
    if(!isalive(var_6)) {
      return;
    }
    var_6 setgoalvolumeauto(var_3);

    if(istrue(var_1))
      wait(randomfloatrange(0.5, 2.5));
  }
}

first_convoy() {
  thread _encstr_AAA6354790C3F99371266D768F9F1AB9EB68BE9FA0DE3BAACF35C52E7F0F3359D840BBE720305F72935ECE625EE3C91D1B88439A68EBDB::brenableagents(-3800, "_encstr_814C02A2", "_encstr_8D1E0E0298218F40D9C9454B91B15AA6");
  thread _encstr_AAA6354790C3F99371266D768F9F1AB9EB68BE9FA0DE3BAACF35C52E7F0F3359D840BBE720305F72935ECE625EE3C91D1B88439A68EBDB::brenableagents(-2700, "_encstr_814C02A2", "_encstr_AF1E0EA9F14857E00730FB93D82F8AB2");
  thread _encstr_AAA6354790C3F99371266D768F9F1AB9EB68BE9FA0DE3BAACF35C52E7F0F3359D840BBE720305F72935ECE625EE3C91D1B88439A68EBDB::brenableagents(-2200, "_encstr_814C02A2", "_encstr_9A1E0EB0B13656CBEB38D56E86FA81CC");
  thread _encstr_AAA6354790C3F99371266D768F9F1AB9EB68BE9FA0DE3BAACF35C52E7F0F3359D840BBE720305F72935ECE625EE3C91D1B88439A68EBDB::brenableagents(-1000, "_encstr_814C02A2", "_encstr_8C1E0E1E71911A29BED8B7A73096B8D7");

  while(getaiarray("_encstr_8E8405EA382B2A").size > 10 + level.players.size)
    wait 0.1;

  wait 8;
  _id_135B1();
  thread _id_12389();

  while(getaiarray("_encstr_8E8405EA382B2A").size > 10)
    wait 0.1;

  _encstr_8F0137E6D89C4B073A9BCB3683F2B658386E798DC1AFE6B77D956B4C0B9BB9F297361CBEDCDB7D59ADC4C2CD9BBCF519CA33957323E276CDB1::createhudelem((-1951.59, -489.52, 58.0407));
  thread createhudstring();
  wait 1;

  while(getaiarray("_encstr_8E8405EA382B2A").size > 5)
    wait 0.1;

  thread _id_13525("_encstr_AC8117D01AA7DB2A77732FB0498313F74F32E8A8B3BB07E12B", _encstr_AAA6354790C3F99371266D768F9F1AB9EB68BE9FA0DE3BAACF35C52E7F0F3359D840BBE720305F72935ECE625EE3C91D1B88439A68EBDB::propchange(16));
  wait 5;

  while(getaiarray("_encstr_8E8405EA382B2A").size > 10)
    wait 0.1;

  thread _id_13D1E();

  while(getaiarray("_encstr_8E8405EA382B2A").size > 4)
    wait 0.1;

  level notify("_encstr_847315D696C6D8BEB1DBB6C16359E1AF4CB7D6982B93E6");

  while(getaiarray("_encstr_8E8405EA382B2A").size > 0)
    wait 0.1;

  thread _encstr_8F0137E6D89C4B073A9BCB3683F2B658386E798DC1AFE6B77D956B4C0B9BB9F297361CBEDCDB7D59ADC4C2CD9BBCF519CA33957323E276CDB1::ally_vo();
  wait 2;
  scripts\engine\utility::flag_clear("_encstr_864715CDC158EE73B473B3FAB437D71C27B7B327ACB9E6");
  thread hit_by_emp_internal();
}

_id_13525(var_0, var_1) {
  var_2 = [];
  var_3 = 0;
  var_4 = [];
  var_4[var_4.size] = [(-277.042, 453.234, 152), (0, 270, 0)];
  var_4[var_4.size] = [(-103, 564.556, 152), (0, 270, 0)];
  var_4[var_4.size] = [(-910.474, 720.486, 18.0132), (0, 270, 0)];
  var_4[var_4.size] = [(2244.82, -475.153, -20), (0, 270, 0)];
  var_4[var_4.size] = [(-307.744, 983.131, 25.0132), (0, 180, 0)];
  var_4[var_4.size] = [(47.422, 961.435, 25.0132), (0, 360, 0)];
  var_4[var_4.size] = [(-877.833, -1443.16, 16.276), (0, 90, 0)];
  var_4[var_4.size] = [(158.948, 511.008, 23.9998), (0, 270, 0)];
  var_4[var_4.size] = [(-256.9, 320.88, 152), (0, 270, 0)];
  var_4[var_4.size] = [(-40.5786, -1232.58, 19.2759), (0, 180, 0)];
  var_4[var_4.size] = [(-448.779, 355.353, 152), (0, 270, 0)];
  var_4[var_4.size] = [(236.259, -692.464, 16), (0, 180, 0)];
  var_4[var_4.size] = [(114.734, 281.237, 24.3059), (0, 270, 0)];
  var_4[var_4.size] = [(128.845, -805.786, 150), (0, 180, 0)];
  var_4[var_4.size] = [(-182.852, 380.091, 25.9998), (0, 270, 0)];
  var_4[var_4.size] = [(-404.955, 514.211, 152.799), (0, 270, 0)];
  var_4[var_4.size] = [(415.348, 659.345, 16.0132), (0, 90, 0)];
  var_4[var_4.size] = [(411.962, 344.199, 16.013), (0, 270, 0)];
  var_4[var_4.size] = [(-929.509, 523.016, 25.0132), (0, 270, 0)];
  var_4[var_4.size] = [(-146.642, 387.858, 25.0132), (0, 270, 0)];
  var_4[var_4.size] = [(-183.683, 476.539, 25.0132), (0, 270, 0)];
  var_4[var_4.size] = [(-257.604, 479.891, 25.0132), (0, 270, 0)];

  for(var_5 = 0; var_5 < var_1; var_5++) {
    while(getaiarray("_encstr_8E8405EA382B2A").size >= _encstr_AAA6354790C3F99371266D768F9F1AB9EB68BE9FA0DE3BAACF35C52E7F0F3359D840BBE720305F72935ECE625EE3C91D1B88439A68EBDB::_id_130A1() || getaiarray().size > 40)
      wait 0.2;

    if(var_3 > var_4.size - 1)
      var_3 = 0;

    var_6 = scripts\cp\laser_traps\cp_laser_traps::_id_134F1(var_0, var_4[var_3][0], var_4[var_3][1], 1, 1);
    var_6 scripts\engine\utility::set_movement_speed(300);
    var_3++;

    if(var_5 > 20) {
      var_6 setgoalpos((-751.502, -472.085, -5));
      var_6.goalradius = 1500;
    } else if(var_5 > 10) {
      var_6 setgoalpos((-623.502, -264.085, -5));
      var_6.goalradius = 700;
    } else {
      var_6 setgoalpos((-391.502, 303.915, -5));
      var_6.goalradius = 800;
    }

    var_2[var_2.size] = var_6;
    waitframe();
  }

  return var_2;
}

_id_12389() {
  badplace_cylinder("_encstr_A56F14CD8F5A1B9067A2A8A0CF3F78C7C25379734F82", -1, (-70.6799, -862.777, 150), 415, 100, "_encstr_8E8405EA382B2A");
  scripts\engine\utility::flag_wait("_encstr_A16309A525E2C10FE71B28");
  badplace_delete("_encstr_A56F14CD8F5A1B9067A2A8A0CF3F78C7C25379734F82");
}

_id_13D1E() {
  var_0 = [];
  var_0[var_0.size] = [(249.8, -325.5, 4), (0, 270, 0)];
  var_0[var_0.size] = [(-530.067, 565.2, 42), (0, 270, 0)];
  var_0[var_0.size] = [(-114.67, 641.429, 42), (0, 270, 0)];
  var_0[var_0.size] = [(-548.124, 319.717, 42), (0, 360, 0)];
  var_0[var_0.size] = [(-479.139, 410.874, 42), (0, 270, 0)];
  var_0[var_0.size] = [(-129.105, 502.898, 42), (0, 270, 0)];
  var_0[var_0.size] = [(-233.107, 596.631, 42), (0, 270, 0)];
  var_0[var_0.size] = [(-430.798, 634.78, 42), (0, 360, 0)];
  var_1 = [];

  for(var_2 = 0; var_2 < level.players.size; var_2++) {
    var_3 = _encstr_AAA6354790C3F99371266D768F9F1AB9EB68BE9FA0DE3BAACF35C52E7F0F3359D840BBE720305F72935ECE625EE3C91D1B88439A68EBDB::_id_1352B("_encstr_A2F11CA3D33AD9B827A68B66CECC20188247073BCB5388A038BDF379F3A6", var_0[var_2][0]);
    var_3.goalradius = 80;
    var_3 setgoalpos(var_0[var_2][0]);
    var_1[var_1.size] = var_3;
    waitframe();
  }

  var_3 = _encstr_AAA6354790C3F99371266D768F9F1AB9EB68BE9FA0DE3BAACF35C52E7F0F3359D840BBE720305F72935ECE625EE3C91D1B88439A68EBDB::_id_1352B("_encstr_ABDB186AF08DF718B197283FAB1022F7A50983929BDD87D248F7", var_0[6][0]);
  var_3 setgoalpos(var_0[6][0]);
  var_3.goalradius = 100;
  var_1[var_1.size] = var_3;
  waitframe();
  var_3 = _encstr_AAA6354790C3F99371266D768F9F1AB9EB68BE9FA0DE3BAACF35C52E7F0F3359D840BBE720305F72935ECE625EE3C91D1B88439A68EBDB::_id_1352B("_encstr_ABDB186AF08DF718B197283FAB1022F7A50983929BDD87D248F7", var_0[7][0]);
  var_3 setgoalpos(var_0[7][0]);
  var_3.goalradius = 100;
  var_1[var_1.size] = var_3;

  foreach(var_3 in var_1) {
    var_3.og_fov = 1;
    var_3 thread gasfxground();
    var_5 = scripts\cp\cp_weapon::buildweapon("_encstr_925D13A28841F9E728B06A7FB1514FE8B74A497A18", ["_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99"], "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99");
    var_3 thread _encstr_842518E6D8395A38A3B9BC0B73B4AD5EB9862CE4AC8CE23BDC1B::forceuseweapon(var_5, "_encstr_BA7F0830B3A7859B60B0");
  }
}

gasfxground() {
  self endon("_encstr_AD75063D571AE108");
  self waittill("_encstr_B2BE0788BAF573592F");
  self.goalradius = 200;
}

_id_11A77(var_0) {
  foreach(var_2 in var_0) {
    if(distance2d(var_2.origin, (-307.915, 463.628, 148)) <= 400)
      var_2.og_fov = 1;
  }
}

createhudstring() {
  level endon("_encstr_847315D696C6D8BEB1DBB6C16359E1AF4CB7D6982B93E6");
  var_0 = [];
  var_0[var_0.size] = (203.162, -1024.91, 56);
  var_0[var_0.size] = (-149.502, 975.083, 25);
  var_0[var_0.size] = (2291.6, -123.688, -20);
  var_0[var_0.size] = (-728.79, -1777.19, 16);
  var_0[var_0.size] = (203.162, -1024.91, 56);
  var_0[var_0.size] = (-149.502, 975.083, 25);
  var_0[var_0.size] = (2291.6, -123.688, -20);
  var_0[var_0.size] = (-728.79, -1777.19, 16);
  var_0[var_0.size] = (203.162, -1024.91, 56);
  var_0[var_0.size] = (-149.502, 975.083, 25);
  var_0[var_0.size] = (2291.6, -123.688, -20);
  var_0[var_0.size] = (-728.79, -1777.19, 16);
  var_0[var_0.size] = (203.162, -1024.91, 56);
  var_0[var_0.size] = (-149.502, 975.083, 25);
  var_0[var_0.size] = (2291.6, -123.688, -20);
  var_0[var_0.size] = (-728.79, -1777.19, 16);
  scripts\engine\utility::flag_wait("_encstr_A16309A525E2C10FE71B28");
  wait 10;

  for(var_1 = 0; var_1 < level.players.size; var_1++) {
    for(var_2 = 0; var_2 < 2; var_2++) {
      thread _encstr_8F0137E6D89C4B073A9BCB3683F2B658386E798DC1AFE6B77D956B4C0B9BB9F297361CBEDCDB7D59ADC4C2CD9BBCF519CA33957323E276CDB1::createhudelem(var_0[var_1]);
      wait 15;
    }
  }
}

_id_135B1() {
  var_0 = [];
  var_0[var_0.size] = [(-1380.93, -979.18, 18.0409), (0, 270, 0)];
  var_0[var_0.size] = [(-1434.47, -673.528, 18.0408), (0, 270, 0)];
  var_0[var_0.size] = [(-2021.2, -922.943, 58.0407), (0, 270, 0)];
  var_0[var_0.size] = [(-2163.12, -760.887, 58.0407), (0, 360, 0)];
  var_1 = _encstr_AAA6354790C3F99371266D768F9F1AB9EB68BE9FA0DE3BAACF35C52E7F0F3359D840BBE720305F72935ECE625EE3C91D1B88439A68EBDB::_id_1352C("_encstr_ABDB186AF08DF718B197283FAB1022F7A50983929BDD87D248F7", var_0);
  _encstr_81AE300BC6CB74723C98C213A04E500BE92BAF6352E1471F670D59C9A7DF1F8BCAD9CBF1568F716F03F191872BE9AAB2F65E::lootchopper_findunoccupiedpatrolzone(var_1);

  foreach(var_3 in var_1)
  var_3.goalradius = 1000;

  var_5 = _encstr_8F0137E6D89C4B073A9BCB3683F2B658386E798DC1AFE6B77D956B4C0B9BB9F297361CBEDCDB7D59ADC4C2CD9BBCF519CA33957323E276CDB1::createhudelem((-1951.59, -489.52, 58.0407));
  create_oscilloscope_screen();
  var_0 = [];
  var_0[var_0.size] = [(-1579.28, -1637.05, 18.0407), (0, 90, 0)];
  var_0[var_0.size] = [(-1554.1, -1131.2, 17.5688), (0, 270, 0)];
  var_0[var_0.size] = [(-1579.57, -387.718, 58.0407), (0, 180, 0)];
  var_0[var_0.size] = [(-1705.52, -392.408, 58.0407), (0, 180, 0)];
  var_1 = _encstr_AAA6354790C3F99371266D768F9F1AB9EB68BE9FA0DE3BAACF35C52E7F0F3359D840BBE720305F72935ECE625EE3C91D1B88439A68EBDB::_id_1352C("_encstr_ABDB186AF08DF718B197283FAB1022F7A50983929BDD87D248F7", var_0);

  foreach(var_3 in var_1) {
    var_3.goalradius = 700;
    var_3 setgoalpos(var_3.origin);
  }
}

create_oscilloscope_screen() {
  self endon("_encstr_AD75063D571AE108");

  while(isalive(self))
    wait 0.1;
}

hit_by_emp_internal() {
  level._id_13BD3 = 6000;
  thread _encstr_AAA6354790C3F99371266D768F9F1AB9EB68BE9FA0DE3BAACF35C52E7F0F3359D840BBE720305F72935ECE625EE3C91D1B88439A68EBDB::_id_1238D((69.25, 399, 62), 50, 150, "_encstr_8E8405EA382B2A");
  thread _encstr_AAA6354790C3F99371266D768F9F1AB9EB68BE9FA0DE3BAACF35C52E7F0F3359D840BBE720305F72935ECE625EE3C91D1B88439A68EBDB::_id_1238D((2311.76, 1671.9, 54.1039), 50, 150, "_encstr_8E8405EA382B2A", "_encstr_9A8507BA4040188D08");
  thread _encstr_AAA6354790C3F99371266D768F9F1AB9EB68BE9FA0DE3BAACF35C52E7F0F3359D840BBE720305F72935ECE625EE3C91D1B88439A68EBDB::_id_1238D((-166.454, 139.447, 46.5), 50, 150, "_encstr_8E8405EA382B2A", "_encstr_9A8507BA4040188D08");
  scripts\engine\utility::flag_set("_encstr_B15D1BC979C0FB1F1B78AA83E0605B39C8D1795AF3B107CB37D1729A69");
  thread brloadoutcratefirstactivation();
  thread _id_12AB9();
  thread _id_12BEF();
  scripts\engine\utility::flag_set("_encstr_A77911BAF0539A3FD3401437EED8DF66D50852");
  scripts\engine\utility::flag_set("_encstr_8C1E0E1E71911A29BED8B7A73096B8D7");
  thread _encstr_8F0137E6D89C4B073A9BCB3683F2B658386E798DC1AFE6B77D956B4C0B9BB9F297361CBEDCDB7D59ADC4C2CD9BBCF519CA33957323E276CDB1::hitbytrain();
  level.hitslocs = 0;
  var_0 = scripts\engine\utility::getStruct("_encstr_A6880EB329BE53D79327D3DC55101E03", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = var_0 _encstr_AAA6354790C3F99371266D768F9F1AB9EB68BE9FA0DE3BAACF35C52E7F0F3359D840BBE720305F72935ECE625EE3C91D1B88439A68EBDB::_id_11A9A(&"_encstr_992C1CF73381DE01DFD724DDCEFB29133E97635D534806B908FA6C34A284");
  var_1 waittill("_encstr_8F5C086405E70FBA4B4A", var_2);
  var_1 delete();

  foreach(var_4 in getaiarray("_encstr_9A8507BA4040188D08"))
  var_4.health = 150;

  setthreatbias("_encstr_9A8507BA4040188D08", "_encstr_8E8405EA382B2A", 10000);
  var_6 = getEnt("_encstr_88290C99EF93882D0B5976074F4B", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_7 = getEnt("_encstr_A6C90DD8EDB5E0D53A95C9AF7BCCCC", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_7 hide();
  var_6 show();
  scripts\engine\utility::flag_set("_encstr_AA5F11E4B6A1335A4D505399F8B1168BBB957C");
  scripts\engine\utility::flag_clear("_encstr_AD6110D48622E2CBC6305277899BEBCAE3F0");
  scripts\engine\utility::flag_clear("_encstr_864715CDC158EE73B473B3FAB437D71C27B7B327ACB9E6");
  _encstr_8F0137E6D89C4B073A9BCB3683F2B658386E798DC1AFE6B77D956B4C0B9BB9F297361CBEDCDB7D59ADC4C2CD9BBCF519CA33957323E276CDB1::justbecamehvt();
}

_id_12BEF() {
  var_0 = getnodesinradius((-676.247, 477.233, 167), 30, 0, 50);

  foreach(var_2 in var_0)
  var_2 disconnectnode();

  var_0 = getnodesinradius((-686.203, 437.787, 167), 30, 0, 50);

  foreach(var_2 in var_0)
  var_2 disconnectnode();
}

brloadoutcratefirstactivation() {
  wait 1;
  var_0 = getaiarray("_encstr_9A8507BA4040188D08");
  var_0 = sortbydistance(var_0, (20.056, 205.038, 168));

  if(isDefined(var_0[0])) {
    var_1 = var_0[0];
    var_1 cleargoalvolume();
    var_1 setgoalpos((20.056, 205.038, 168));
    var_1.goalradius = 40;
  }

  if(isDefined(var_0[1])) {
    var_1 = var_0[1];
    var_1 cleargoalvolume();
    var_1 setgoalpos((-53.038, 688.056, 168));
    var_1.goalradius = 50;
    var_1.goalheight = 20;
  }
}

_id_12AB9() {
  scripts\engine\utility::delaythread(5, _encstr_AAA6354790C3F99371266D768F9F1AB9EB68BE9FA0DE3BAACF35C52E7F0F3359D840BBE720305F72935ECE625EE3C91D1B88439A68EBDB::weapon_xp_iw8_sm_beta, "_encstr_9B1807D39B48FD93A3", 1, 1);

  if(level.players.size > 1)
    scripts\engine\utility::delaythread(5, _encstr_AAA6354790C3F99371266D768F9F1AB9EB68BE9FA0DE3BAACF35C52E7F0F3359D840BBE720305F72935ECE625EE3C91D1B88439A68EBDB::weapon_xp_iw8_sm_beta, "_encstr_BDF5147B33CD0FDC1043F7CE17B8E4036E6BD3927895", 1, 7);

  if(level.players.size > 3)
    scripts\engine\utility::delaythread(5, _encstr_AAA6354790C3F99371266D768F9F1AB9EB68BE9FA0DE3BAACF35C52E7F0F3359D840BBE720305F72935ECE625EE3C91D1B88439A68EBDB::weapon_xp_iw8_sm_beta, "_encstr_ACD20F4B118BEF03D380F9335815BC7761", 1, 7);

  var_0 = getaiarray("_encstr_9A8507BA4040188D08");

  if(var_0.size < 3) {
    var_1 = getEnt("_encstr_BAF30A858D1B5ED734CA8D96", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    var_2 = var_1 scripts\common\vehicle::spawn_vehicle_and_gopath();
    var_2.ignoreme = 1;
    waitframe();
    var_3 = spawnStruct();
    var_3.origin = (-150.89, -56.1799, 567);
    var_3.angles = (0, 75.6521, 0);
    level._id_12ABA = var_2;
    scripts\engine\utility::array_thread(var_2.riders, ::_id_12AB8);
    var_2 thread _encstr_81AE300BC6CB74723C98C213A04E500BE92BAF6352E1471F670D59C9A7DF1F8BCAD9CBF1568F716F03F191872BE9AAB2F65E::givequestrewardgroup();
    var_4 = var_2.riders;
    var_2 settargetyaw(var_3.angles[1]);
    var_2 vehicle_teleport(var_1.origin + (-2000, 1000, 1000), var_3.angles);
    var_2 setvehgoalpos(var_1.origin + (-2000, 1000, 1000), 0);
    var_2 vehicle_setspeedimmediate(40);
    var_2 setneargoalnotifydist(1000);
    var_2 waittill("_encstr_B4D10ADC950BE4EB76DE8536");
    var_2 setvehgoalpos(var_3.origin, 1);
    var_2 vehicle_setspeedimmediate(40);
    var_2 waittill("_encstr_B4D10ADC950BE4EB76DE8536");
    var_2 thread scripts\common\vehicle::vehicle_unload("_encstr_8B1608EC43B8D647A113");
    var_2 waittill("_encstr_BD82096B5DA4B07F924F29");
    var_2 vehicle_setspeedimmediate(40);
    var_2 setvehgoalpos(var_3.origin + (0, 0, 800), 1);
    wait 5;

    foreach(var_6 in var_2.riders)
    var_6 scripts\cp\laser_traps\cp_laser_traps::ks_pointstowin();

    var_2 waittill("_encstr_8B7205D9ED5958");
    var_2 delete();
  }
}

_id_12AB8() {
  self endon("_encstr_AD75063D571AE108");
  var_0 = getEnt("_encstr_B1CF0B9159332BB991F5B3F6D8", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  self.ignoreme = 1;
  self.target = undefined;
  self notify("_encstr_AFF5136B4BEAA2CF4A38B86349D06B40CED5D004B0");
  self clearpath();
  self setgoalpos((-108.179, -141.79, 32));
  self setgoalvolumeauto(var_0);
  level._id_12ABA scripts\engine\utility::_id_143B9(30, "_encstr_BD82096B5DA4B07F924F29");
  self.ignoreme = 0;
}

_id_119E5() {
  var_0 = [];
  var_1 = scripts\engine\utility::getStructArray("_encstr_992B18B3C7A2C081E31AA11BC7F72887DA073547C75B16E83B73", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = sortbydistance(var_1, (-410.812, 520.18, 60));
  var_1[1].angles = (0, 0, 0);

  foreach(var_3 in var_1) {
    var_4 = scripts\cp\laser_traps\cp_laser_traps::brplayerhudoutlineforteammatesupdate(var_3.origin, var_3.angles);
    var_0[var_0.size] = var_4;
    setheadiconsnaptoedges(var_4.headiconid, 500);
  }

  var_6 = scripts\engine\utility::getStruct("_encstr_88881C1BC658F2ADEDC9ACF536932CE8ACD79B38B0EEE6AF6E47C95DD8D1", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_0[var_0.size] = scripts\cp\laser_traps\cp_laser_traps::handle_leads_collected_hideiconbuilding(var_6.origin, var_6.angles);
  var_7 = scripts\engine\utility::getStruct("_encstr_AB911BF9289D77B54F4889E3EB9718E8018AEF82AF0836CF34339F93EB", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_0[var_0.size] = scripts\cp\laser_traps\cp_laser_traps::player_limitedammo(var_7.origin + (0, 0, 5), var_7.angles);
  var_8 = scripts\engine\utility::getStruct("_encstr_8F9F18926033379789E6B9A475567FBA5B309A99C0A1AAF761CD", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_0[var_0.size] = scripts\cp\laser_traps\cp_laser_traps::playerplunderlosedepositcallback(var_8.origin, var_8.angles);
  var_0[var_0.size] = scripts\cp\laser_traps\cp_laser_traps::binoculars_getpendingtime((-152.152, -361.947, 50.3), (0, 48.5995, 0));
  var_0[var_0.size] = scripts\cp\laser_traps\cp_laser_traps::focus_fire_outline_enabled((-211.976, 207.544, 63.5), (358.6, 293.969, -1.32843));
}