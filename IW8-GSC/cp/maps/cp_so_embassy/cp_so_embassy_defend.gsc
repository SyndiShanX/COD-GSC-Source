/**********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\maps\cp_so_embassy\cp_so_embassy_defend.gsc
**********************************************************/

justbecamehvt() {
  level.playerscoreeventvalue = 1;
  thread min_pt();
  thread min_player_health();
  wait 3;
  brevent2();
  setsaveddvar("_encstr_A7F10BDB5966F39BFA13DB52CD", 1);
  scripts\engine\utility::flag_clear("_encstr_864715CDC158EE73B473B3FAB437D71C27B7B327ACB9E6");
  thread keephudhiddentillfadein();
  scripts\engine\utility::flag_wait("_encstr_9B93128E4E16739B9956E47D8DBD6B0E8DB28EAC");
  _id_1233F();
  scripts\engine\utility::flag_wait("_encstr_B4FD0FD383052A67A0813B82382076A2D5");
  has_target_player_with_battle_stations();
  wait 3;
  bonus_targets((-221, -588, 34), 0, 600);
  setsaveddvar("_encstr_A7F10BDB5966F39BFA13DB52CD", 1);
  _encstr_81AE300BC6CB74723C98C213A04E500BE92BAF6352E1471F670D59C9A7DF1F8BCAD9CBF1568F716F03F191872BE9AAB2F65E::_id_12F4B();
}

createhudtimer() {}

_id_13D20() {
  var_0 = getEnt("_encstr_AC8A0FCF6061F68B19900A58D2072D60A6", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  radiusdamage((32, 377, 112), 50, 50, 50);
  radiusdamage((-1042, 1890, 645), 50, 50, 50);
  waitframe();
  radiusdamage((-309, 1885, 275), 50, 50, 50);
}

createheliextractobjectiveicons() {
  level.createhistorydestination = [];
  level.createhistorydestination[level.createhistorydestination.size] = (4778, 811, 17.4804);
  level.createhistorydestination[level.createhistorydestination.size] = (3621, 698, -20);
  level.createhistorydestination[level.createhistorydestination.size] = (4148, -1864, -7.49091);
  level.createhistorydestination[level.createhistorydestination.size] = (5123, -855, 4.50909);
  level.createhistorydestination[level.createhistorydestination.size] = (2165, 1857, 25);
}

has_target_player_with_battle_stations() {
  wait 1;
  bonus_targets((-221, -588, 34), 1, 600);

  if(getaiarray("_encstr_8E8405EA382B2A").size)
    thread hatch_model_linkto_train();
}

_id_1233F() {
  var_0 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-427, 393, 58));
  var_0 setModel("_encstr_B6DB195B59F586854E19770B9CCA7D432C27C8914E2D3BCAEB0C4C");
  var_1 = var_0 _encstr_AAA6354790C3F99371266D768F9F1AB9EB68BE9FA0DE3BAACF35C52E7F0F3359D840BBE720305F72935ECE625EE3C91D1B88439A68EBDB::_id_11A9A(undefined, (0, 0, 4));
  var_1 thread iscaliberattachment(var_0);
  thread _id_12CDD(var_1);
  var_2 = getEnt("_encstr_88290C99EF93882D0B5976074F4B", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_3 = getEnt("_encstr_A6C90DD8EDB5E0D53A95C9AF7BCCCC", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_3 show();
  var_2 hide();
}

iscacsecondaryweapongroup(var_0) {
  scripts\engine\utility::flag_set("_encstr_B4FD0FD383052A67A0813B82382076A2D5");
}

iscaliberattachment(var_0) {
  self waittill("_encstr_8F5C086405E70FBA4B4A", var_1);
  var_0 delete();
  self delete();
  scripts\engine\utility::flag_set("_encstr_B4FD0FD383052A67A0813B82382076A2D5");
}

method_for_calling_reinforcement() {
  var_0 = 0;

  if(level.players.size > 1)
    var_0 = randomintrange(0, level.players.size - 1);

  wait 5;
  level.players[var_0].team = "_encstr_8E8405EA382B2A";
}

play_nags_from_array() {
  createhudelem(level.createhistorydestination[1]);
  createhudelem(level.createhistorydestination[4]);
  _encstr_AAA6354790C3F99371266D768F9F1AB9EB68BE9FA0DE3BAACF35C52E7F0F3359D840BBE720305F72935ECE625EE3C91D1B88439A68EBDB::_id_134ED("_encstr_93AE1A8013CD0853694AB737A392A3130FD31810876E616702F7A445", _encstr_AAA6354790C3F99371266D768F9F1AB9EB68BE9FA0DE3BAACF35C52E7F0F3359D840BBE720305F72935ECE625EE3C91D1B88439A68EBDB::propchange(10));
  thread _encstr_AAA6354790C3F99371266D768F9F1AB9EB68BE9FA0DE3BAACF35C52E7F0F3359D840BBE720305F72935ECE625EE3C91D1B88439A68EBDB::_id_134ED("_encstr_833F1B9FBD9F1DEBA9E3392FAFCB1A36FE84B7DAE1D601BF0B8C01437B", _encstr_AAA6354790C3F99371266D768F9F1AB9EB68BE9FA0DE3BAACF35C52E7F0F3359D840BBE720305F72935ECE625EE3C91D1B88439A68EBDB::propchange(2));
  var_0 = getaiarray("_encstr_8E8405EA382B2A");

  foreach(var_2 in var_0) {
    if(!bomb_carrier(var_2)) {
      continue;
    }
    var_2.goalradius = 500;
    var_2 setgoalpos((1860.9, 963.5, 44));
    var_2 scripts\engine\utility::set_movement_speed(280);
  }

  wait 10;
  createhudelem(level.createhistorydestination[4]);
  var_0 = getaiarray("_encstr_8E8405EA382B2A");

  foreach(var_2 in var_0) {
    if(!bomb_carrier(var_2)) {
      continue;
    }
    var_2.goalradius = 700;
    var_2 setgoalpos(level.oncrateactivate);
    var_2 scripts\engine\utility::set_movement_speed(280);
  }
}

brevent2() {
  level endon("_encstr_9B93128E4E16739B9956E47D8DBD6B0E8DB28EAC");
  childthread _id_11CE3();
  childthread _id_11BDA();
  scripts\engine\utility::flag_clear("_encstr_864715CDC158EE73B473B3FAB437D71C27B7B327ACB9E6");
  keep_firing_minigun();
  scripts\engine\utility::flag_clear("_encstr_864715CDC158EE73B473B3FAB437D71C27B7B327ACB9E6");
  keep_requesting_spawners();
  scripts\engine\utility::flag_clear("_encstr_864715CDC158EE73B473B3FAB437D71C27B7B327ACB9E6");
  scripts\engine\utility::flag_set("_encstr_BEFA0D4F27C315518361D34B96AA40");
}

_id_11BDA() {
  scripts\engine\utility::flag_wait("_encstr_9182142577C7D0F9FD3A10C11742E76BE7F23E2DDE13");
  _encstr_AAA6354790C3F99371266D768F9F1AB9EB68BE9FA0DE3BAACF35C52E7F0F3359D840BBE720305F72935ECE625EE3C91D1B88439A68EBDB::weapon_xp_iw8_sm_beta("_encstr_B20D1473D82347A5014072161B6829B2DB58FB9120D3", 1, 4);

  if(level.players.size > 3)
    _encstr_AAA6354790C3F99371266D768F9F1AB9EB68BE9FA0DE3BAACF35C52E7F0F3359D840BBE720305F72935ECE625EE3C91D1B88439A68EBDB::weapon_xp_iw8_sm_beta("_encstr_9B1807D39B48FD93A3", 1, 7);
}

_id_11CE3() {
  var_0 = [];
  var_0[var_0.size] = [(60.2156, -1296.45, 16), (0, 0, 0)];
  var_0[var_0.size] = [(-278.211, -1338.31, 15.9999), (0, 180, 0)];
  var_0[var_0.size] = [(-1090.4, -102.426, 15.9999), (0, 270, 0)];
  var_0[var_0.size] = [(-1079.6, -37.5742, 15.9999), (0, 90, 0)];
  var_0[var_0.size] = [(-1402.71, 979.767, 25), (0, 360, 0)];
  var_0[var_0.size] = [(61.6827, 976.349, 25), (0, 360, 0)];
  var_0[var_0.size] = [(403.336, 336.536, 15.9998), (0, 360, 0)];
  var_0[var_0.size] = [(418.133, -920.934, 16), (0, 90, 0)];
  var_0[var_0.size] = [(399.53, 626.671, 16), (0, 90, 0)];
  scripts\engine\utility::flag_wait("_encstr_AADC14E3F26BFA8C15B6817E8BDA49F3499D7EC048C5");

  for(;;) {
    wait 10;
    var_1 = _encstr_AAA6354790C3F99371266D768F9F1AB9EB68BE9FA0DE3BAACF35C52E7F0F3359D840BBE720305F72935ECE625EE3C91D1B88439A68EBDB::brevent1playervalid((-289.142, 479.222, 26), 380, 143);

    if(var_1) {
      scripts\engine\utility::flag_waitopen("_encstr_AD6110D48622E2CBC6305277899BEBCAE3F0");
      wait 10;
      var_1 = _encstr_AAA6354790C3F99371266D768F9F1AB9EB68BE9FA0DE3BAACF35C52E7F0F3359D840BBE720305F72935ECE625EE3C91D1B88439A68EBDB::brevent1playervalid((-289.142, 479.222, 26), 380, 143);

      if(var_1) {
        var_2 = [];

        for(var_3 = 0; var_3 < level.players.size; var_3++) {
          var_4 = scripts\engine\utility::array_randomize(var_0);

          if(getaiarray("_encstr_8E8405EA382B2A").size < _encstr_AAA6354790C3F99371266D768F9F1AB9EB68BE9FA0DE3BAACF35C52E7F0F3359D840BBE720305F72935ECE625EE3C91D1B88439A68EBDB::_id_130A1())
            thread createhudelem(var_4[0][0]);

          var_5 = getaiarrayinradius((-813.331, -420.376, 16.0002), 2000, "_encstr_8E8405EA382B2A");

          if(var_5.size < 10)
            var_5 = getaiarrayinradius((1911.67, -420.376, 16.0002), 2000, "_encstr_8E8405EA382B2A");

          var_5 = _id_12BCC(var_5);

          if(isDefined(var_5) && var_5.size > 6) {
            var_5 = sortbydistance(var_5, (1911.67, -420.376, 16.0002));
            var_6 = level.players;

            for(var_3 = 0; var_3 < level.players.size; var_3++) {
              var_5 = scripts\engine\utility::array_removedead_or_dying(var_5);

              if(!isDefined(var_5) || var_5.size < 2) {
                break;
              }

              var_6 = scripts\engine\utility::array_removeundefined(var_6);
              var_7 = scripts\engine\utility::random(var_6);
              var_6 = scripts\engine\utility::array_remove(var_6, var_7);

              if(var_7 _encstr_AAA6354790C3F99371266D768F9F1AB9EB68BE9FA0DE3BAACF35C52E7F0F3359D840BBE720305F72935ECE625EE3C91D1B88439A68EBDB::getdefaultstreamhinttimeoutms()) {
                continue;
              }
              var_5[0] childthread set_vehicle_anims_techo(var_7, var_0);
              var_5[1] childthread set_vehicle_anims_techo(var_7, var_0);
              var_2[var_2.size] = var_5[0];
            }
          }

          if(var_3 > 1)
            wait 6;
        }
      }
    }
  }
}

set_vehicle_anims_techo(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self.og_fov = 1;

  if(distance2dsquared(self.origin, (-813.331, -420.376, 16.0002)) > 6250000) {
    var_2 = var_1[randomintrange(4, 8)];
    self forceteleport(var_2[0], var_2[1]);
  }

  var_3 = sortbydistance(level._id_13AF5, self.origin)[0].origin;
  level._id_13AF3 = scripts\engine\utility::array_randomize(level._id_13AF3);
  var_4 = open_this_door();
  self setgoalpos(var_3);
  self.goalradius = 150;
  self.goalheight = 40;
  self waittill("_encstr_8B7205D9ED5958");
  self setgoalpos(var_4);
  self waittill("_encstr_8B7205D9ED5958");
  self setgoalpos(var_0.origin);

  if(var_0 _encstr_AAA6354790C3F99371266D768F9F1AB9EB68BE9FA0DE3BAACF35C52E7F0F3359D840BBE720305F72935ECE625EE3C91D1B88439A68EBDB::getdefaultstreamhinttimeoutms()) {
    self getenemyinfo(var_0);
    self setgoalentity(var_0);
  }

  self.goalradius = 200;
  self.goalheight = 30;
  self.goalradius = 200;
  self.goalheight = 30;
}

_id_12BCC(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    if(!bomb_carrier(var_3))
      var_1[var_1.size] = var_3;
  }

  var_5 = scripts\engine\utility::array_remove_array(var_0, var_1);
  return var_5;
}

keep_firing_minigun() {
  var_0[1] = 10;
  var_0[2] = 15;
  var_0[3] = 20;
  var_0[4] = 25;
  scripts\engine\utility::flag_set("_encstr_B1A40DBB0BCE56AFC4D7DCE80B933A");
  childthread vo_use_computer();
  wait 7;
  _encstr_AAA6354790C3F99371266D768F9F1AB9EB68BE9FA0DE3BAACF35C52E7F0F3359D840BBE720305F72935ECE625EE3C91D1B88439A68EBDB::_id_134ED("_encstr_8FBB1A5AC0BDA748E1C75851D7301793C8F9D2F209805B0960C3414A", _encstr_AAA6354790C3F99371266D768F9F1AB9EB68BE9FA0DE3BAACF35C52E7F0F3359D840BBE720305F72935ECE625EE3C91D1B88439A68EBDB::propchange(16));
  thread scripts\engine\utility::exploder("_encstr_8814074F985BFD9FC3");
  waitframe();
  thread scripts\engine\utility::exploder("_encstr_961407CB918457CA5A");
  waitframe();
  thread scripts\engine\utility::exploder("_encstr_8714073CE95321F15A");
  childthread velnormals();
  bonus_targets((3413, -146, -20), 1);
  bonus_target_score(1);
  childthread bonusdeathplunder(0);
  childthread bonusdeathplunder(1);

  if(level.players.size > 2)
    childthread bonusdeathplunder(2);

  if(level.players.size > 3) {
    childthread bonusdeathplunder(3);
    childthread bonusdeathplunder(4);
  }

  waitframe();
  thread ctgs_compareweaponxp();
  bonus_targets((2139, -146, -4), 1);
  thread _id_13554();
  var_1 = gettime();
  var_2 = var_1 + 20000;

  while(var_2 > gettime() && getaiarray("_encstr_8E8405EA382B2A").size > var_0[level.players.size] && !scripts\engine\utility::flag("_encstr_AADC14E3F26BFA8C15B6817E8BDA49F3499D7EC048C5")) {
    bonus_targets((2139, -146, -4), 1);
    wait 0.5;
  }

  thread _id_13555();
  bonus_targets((1226, -165, -4), 1);
  var_1 = gettime();
  var_2 = var_1 + 20000;

  while(var_2 > gettime() && getaiarray("_encstr_8E8405EA382B2A").size > var_0[level.players.size] && !scripts\engine\utility::flag("_encstr_9182142577C7D0F9FD3A10C11742E76BE7F23E2DDE13")) {
    bonus_targets((1226, -165, -4), 1);
    wait 0.5;
  }

  bonus_targets((-221, -588, 34), 1, 900);

  if(!scripts\engine\utility::flag("_encstr_9182142577C7D0F9FD3A10C11742E76BE7F23E2DDE13"))
    thread _encstr_AAA6354790C3F99371266D768F9F1AB9EB68BE9FA0DE3BAACF35C52E7F0F3359D840BBE720305F72935ECE625EE3C91D1B88439A68EBDB::_id_134ED("_encstr_833F1B9FBD9F1DEBA9E3392FAFCB1A36FE84B7DAE1D601BF0B8C01437B", _encstr_AAA6354790C3F99371266D768F9F1AB9EB68BE9FA0DE3BAACF35C52E7F0F3359D840BBE720305F72935ECE625EE3C91D1B88439A68EBDB::propchange(10));

  bonus_targets((-221, -588, 34), 1, 900);
  wait 1;
  level notify("_encstr_A34A10738A432569C2D747A71D7A38FD9362");

  while(getaiarray("_encstr_8E8405EA382B2A").size > level.players.size && !scripts\engine\utility::flag("_encstr_85BF142A1087FDD3B0E73417A4935702DB90C2B2A029")) {
    bonus_targets((-221, -588, 34), 1, 900);
    wait 0.1;
  }
}

ally_vo() {
  var_0 = getaiarray("_encstr_9A8507BA4040188D08");

  if(isDefined(var_0[0])) {
    var_1 = sortbydistance(getaiarray("_encstr_9A8507BA4040188D08"), level.player.origin)[0];
    var_1 playSound("_encstr_8C66224943BF84C0EDEF4347A959B84ED70B80B14AABB08842977747EDFE40156FE713B3");
  }

  scripts\engine\utility::flag_wait("_encstr_B1A40DBB0BCE56AFC4D7DCE80B933A");
  wait 6;
  var_0 = getaiarray("_encstr_9A8507BA4040188D08");

  if(isDefined(var_0[0])) {
    var_1 = sortbydistance(getaiarray("_encstr_9A8507BA4040188D08"), level.player.origin)[0];
    var_1 playSound("_encstr_ADD41EE4D9195D801BB1389E66FE4175AF95D5113FC24322D358A9A7D02B8877");
  }

  wait 10;
  var_0 = getaiarray("_encstr_9A8507BA4040188D08");

  if(isDefined(var_0[0])) {
    var_1 = sortbydistance(getaiarray("_encstr_9A8507BA4040188D08"), level.player.origin)[0];
    var_1 playSound("_encstr_A3391DE1F38F85C7CDC6A3709AEFE983D0D955AB91039D38BA23C33F2F8319");
  }

  scripts\engine\utility::flag_wait("_encstr_92D90DDB303BEDAF7DF8FE293B635B");
  wait 2;
  var_0 = getaiarray("_encstr_9A8507BA4040188D08");

  if(isDefined(var_0[0])) {
    var_1 = sortbydistance(getaiarray("_encstr_9A8507BA4040188D08"), level.player.origin)[0];
    var_1 playSound("_encstr_ABC21BC8877DB3DB5BBEBAB926BE851BC62B97AFB1EDADC4853AAF3381");
  }

  scripts\engine\utility::flag_wait("_encstr_BEFA0D4F27C315518361D34B96AA40");
  wait 2;
  var_0 = getaiarray("_encstr_9A8507BA4040188D08");

  if(isDefined(var_0[0])) {
    var_1 = sortbydistance(getaiarray("_encstr_9A8507BA4040188D08"), level.player.origin)[0];
    var_1 playSound("_encstr_99201FC81E7D9DDB5B7DAECD627DB9E8C9CA591DAF85C183277B16C6D0D74CDC0C");
  }
}

_id_13554() {
  level endon("_encstr_9182142577C7D0F9FD3A10C11742E76BE7F23E2DDE13");
  _encstr_AAA6354790C3F99371266D768F9F1AB9EB68BE9FA0DE3BAACF35C52E7F0F3359D840BBE720305F72935ECE625EE3C91D1B88439A68EBDB::_id_134ED("_encstr_8FBB1A5AC0BDA748E1C75851D7301793C8F9D2F209805B0960C3414A", _encstr_AAA6354790C3F99371266D768F9F1AB9EB68BE9FA0DE3BAACF35C52E7F0F3359D840BBE720305F72935ECE625EE3C91D1B88439A68EBDB::propchange(10));
  _encstr_AAA6354790C3F99371266D768F9F1AB9EB68BE9FA0DE3BAACF35C52E7F0F3359D840BBE720305F72935ECE625EE3C91D1B88439A68EBDB::_id_134ED("_encstr_93AE1A8013CD0853694AB737A392A3130FD31810876E616702F7A445", _encstr_AAA6354790C3F99371266D768F9F1AB9EB68BE9FA0DE3BAACF35C52E7F0F3359D840BBE720305F72935ECE625EE3C91D1B88439A68EBDB::propchange(6));
  _encstr_AAA6354790C3F99371266D768F9F1AB9EB68BE9FA0DE3BAACF35C52E7F0F3359D840BBE720305F72935ECE625EE3C91D1B88439A68EBDB::_id_134ED("_encstr_833F1B9FBD9F1DEBA9E3392FAFCB1A36FE84B7DAE1D601BF0B8C01437B", _encstr_AAA6354790C3F99371266D768F9F1AB9EB68BE9FA0DE3BAACF35C52E7F0F3359D840BBE720305F72935ECE625EE3C91D1B88439A68EBDB::propchange(8));
}

_id_13555() {
  level endon("_encstr_9182142577C7D0F9FD3A10C11742E76BE7F23E2DDE13");
  _encstr_AAA6354790C3F99371266D768F9F1AB9EB68BE9FA0DE3BAACF35C52E7F0F3359D840BBE720305F72935ECE625EE3C91D1B88439A68EBDB::_id_134ED("_encstr_833F1B9FBD9F1DEBA9E3392FAFCB1A36FE84B7DAE1D601BF0B8C01437B", _encstr_AAA6354790C3F99371266D768F9F1AB9EB68BE9FA0DE3BAACF35C52E7F0F3359D840BBE720305F72935ECE625EE3C91D1B88439A68EBDB::propchange(5));
  _encstr_AAA6354790C3F99371266D768F9F1AB9EB68BE9FA0DE3BAACF35C52E7F0F3359D840BBE720305F72935ECE625EE3C91D1B88439A68EBDB::_id_134ED("_encstr_93AE1A8013CD0853694AB737A392A3130FD31810876E616702F7A445", _encstr_AAA6354790C3F99371266D768F9F1AB9EB68BE9FA0DE3BAACF35C52E7F0F3359D840BBE720305F72935ECE625EE3C91D1B88439A68EBDB::propchange(6));
  _encstr_AAA6354790C3F99371266D768F9F1AB9EB68BE9FA0DE3BAACF35C52E7F0F3359D840BBE720305F72935ECE625EE3C91D1B88439A68EBDB::_id_134ED("_encstr_8FBB1A5AC0BDA748E1C75851D7301793C8F9D2F209805B0960C3414A", _encstr_AAA6354790C3F99371266D768F9F1AB9EB68BE9FA0DE3BAACF35C52E7F0F3359D840BBE720305F72935ECE625EE3C91D1B88439A68EBDB::propchange(4));
}

blockingcover(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = 1000;

  var_2 = gettime();
  var_3 = var_2 + var_1 * 1000;

  if(!isDefined(var_0))
    var_0 = 0;

  var_4[1] = 18;
  var_4[2] = 24;
  var_4[3] = 30;
  var_4[4] = 36;

  while(var_3 > gettime() && getaiarray("_encstr_8E8405EA382B2A").size > var_4[level.players.size] - var_0)
    wait 0.1;
}

bonus_targets(var_0, var_1, var_2) {
  if(!isDefined(var_2))
    var_2 = 800;

  var_3 = getaiarray("_encstr_8E8405EA382B2A");

  foreach(var_5 in var_3) {
    if(!bomb_carrier(var_5)) {
      continue;
    }
    var_5.grenadeammo = 2;
    var_5.grenadeweapon = getcompleteweaponname("_encstr_8DCB085BEF657B4DCF0B");
    var_5.goalradius = var_2;
    var_5 setgoalpos(var_0);

    if(istrue(var_1))
      var_5 childthread no_more_wire_to_cut();

    wait 0.1;
  }
}

ctgs_compareweaponxp() {
  createhudelem(level.createhistorydestination[level.createhistorydestination.size - 1]);
  wait 1;

  if(level.players.size < 2)
    wait 6;

  createhudelem(level.createhistorydestination[level.createhistorydestination.size - 2]);
  wait 1;

  if(level.players.size < 2)
    wait 6;

  createhudelem(level.createhistorydestination[level.createhistorydestination.size - 3]);

  if(level.players.size < 2) {
    return;
  }
  wait 5;
  createhudelem(level.createhistorydestination[4]);
  wait 1;
  createhudelem(scripts\engine\utility::random(level.createhistorydestination));
  wait 1;
  createhudelem(scripts\engine\utility::random(level.createhistorydestination));

  if(level.players.size < 4) {
    return;
  }
  wait 10;
  createhudelem(level.createhistorydestination[4]);
  wait 1;
  createhudelem(scripts\engine\utility::random(level.createhistorydestination));
  wait 2;
  createhudelem(scripts\engine\utility::random(level.createhistorydestination));
  wait 2;
  createhudelem(scripts\engine\utility::random(level.createhistorydestination));
}

createhudelem(var_0) {
  var_1 = _encstr_AAA6354790C3F99371266D768F9F1AB9EB68BE9FA0DE3BAACF35C52E7F0F3359D840BBE720305F72935ECE625EE3C91D1B88439A68EBDB::_id_1352B("_encstr_AF071B99AD5D5083B1C7B1E7E7AACF79F4C7C31152940936EA878DABB3", var_0, (0, 0, 0), 1, 1);
  var_1 endon("_encstr_AD75063D571AE108");
  var_1.create_head_icon_for_crate = 1;
  var_1.attackeraccuracy = 0.01;
  var_2 = level.players;
  var_3 = [];

  foreach(var_5 in var_2) {
    if(var_5 _encstr_AAA6354790C3F99371266D768F9F1AB9EB68BE9FA0DE3BAACF35C52E7F0F3359D840BBE720305F72935ECE625EE3C91D1B88439A68EBDB::getdefaultstreamhinttimeoutms())
      var_3[var_3.size] = var_5;
  }

  var_1 scripts\engine\utility::set_movement_speed(300);
  var_2 = scripts\engine\utility::array_remove_array(var_2, var_3);
  var_5 = scripts\engine\utility::random(var_2);

  if(isDefined(var_5)) {
    var_1 setgoalpos(var_5.origin);
    var_1 getenemyinfo(var_5);
    var_1 setgoalentity(var_5);
  }

  var_1 childthread create_nav_obstacle_for_wheelson();
  var_1 childthread create_name_fx_base();
}

create_nav_obstacle_for_wheelson() {
  self waittill("_encstr_AC8F0AC94174F85AFA901D30");
  var_0 = self magicgrenade(self.origin + (0, 0, 60), self.origin, 0.05, 0);
}

create_name_fx_base() {
  for(;;) {
    self waittill("_encstr_B2BE0788BAF573592F");

    if(isDefined(self.is_specops_gametype))
      self getenemyinfo(self.is_specops_gametype);

    waitframe();
  }
}

bomb_carrier(var_0) {
  if(!isalive(var_0))
    return 0;

  if(isDefined(var_0.create_head_icon_for_crate))
    return 0;

  if(isDefined(var_0._id_13AF2))
    return 0;

  if(isDefined(var_0._id_12DC3))
    return 0;

  if(isDefined(var_0.og_fov))
    return 0;
  else
    return 1;
}

objective_manager() {
  var_0 = scripts\engine\utility::getStruct("_encstr_A6880EB329BE53D79327D3DC55101E03", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = "_encstr_97740E40C3BE35836B9DC6A8749FABF3";
  var_2 = scripts\cp\cp_objectives::requestworldid(var_1, 1);
  objective_setlabel(var_2, "_encstr_99830EF4A6B1234A5DA0A37E51AB43D7");
  objective_setplayintro(var_2, 1);
  objective_setplayoutro(var_2, 0);
  objective_position(var_2, var_0.origin + (0, 0, 12));
  objective_state(var_2, "_encstr_AF5A081BBAC993AC73A3");
  objective_icon(var_2, "_encstr_9A2E1472F83F45A779F9ADA38DE3074E4B18997A30C9");
}

his_playerdisconnect() {
  var_0 = "_encstr_83901179FF8043A711A3C10AA8F99BBDD85DF4";
  var_1 = spawnStruct();
  var_1.origin = (-319.79, -51.821, 100);
  var_2 = scripts\cp\cp_objectives::requestworldid(var_0, 2);
  objective_setdescription(var_2, &"_encstr_BA481EC3217952B7203D4880851E8F98A24FBD4BB3B96F2FC69440A92C75C307");
  objective_setlabel(var_2, &"_encstr_BA481EC3217952B7203D4880851E8F98A24FBD4BB3B96F2FC69440A92C75C307");
  objective_setplayintro(var_2, 1);
  objective_setplayoutro(var_2, 0);
  objective_position(var_2, var_1.origin);
  objective_state(var_2, "_encstr_AF5A081BBAC993AC73A3");
  setomnvar("_encstr_999B13469361F7B2BA430FABA35C0A0F08F83F4F0A", 1);
  setomnvar("_encstr_AA6D19DF23D6C8819A2D8B55F0EC6A0FABE02A09531F424A2FCD9A", 2);
  objective_icon(var_2, "_encstr_A23F20C3AE82AD861FE790D0F729F8C1E9D5CEDA87FA5188E6EF9970A7765105D2BD");
  scripts\engine\utility::flag_wait("_encstr_A77911BAF0539A3FD3401437EED8DF66D50852");
  objective_state(var_2, "_encstr_8267056410C669");
}

hitbytrain() {
  var_0 = scripts\engine\utility::getStruct("_encstr_A6880EB329BE53D79327D3DC55101E03", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = "_encstr_97740E40C3BE35836B9DC6A8749FABF3";
  var_2 = scripts\cp\cp_objectives::requestworldid(var_1, 1);
  objective_setlabel(var_2, &"_encstr_875F171D710FC611B125C3D509EAA98BA64955A708EF90A99D");
  objective_setplayintro(var_2, 1);
  objective_setplayoutro(var_2, 0);
  objective_position(var_2, var_0.origin + (0, 0, 12));
  objective_state(var_2, "_encstr_AF5A081BBAC993AC73A3");
  setomnvar("_encstr_AA6D19DF23D6C8819A2D8B55F0EC6A0FABE02A09531F424A2FCD9A", 3);
  objective_icon(var_2, "_encstr_A23F20C3AE82AD861FE790D0F729F8C1E9D5CEDA87FA5188E6EF9970A7765105D2BD");
  scripts\engine\utility::flag_wait("_encstr_AA5F11E4B6A1335A4D505399F8B1168BBB957C");
  thread _id_12D8D();
  objective_state(var_2, "_encstr_83B306C13570D0CB");

  for(;;) {
    scripts\engine\utility::flag_wait("_encstr_AD6110D48622E2CBC6305277899BEBCAE3F0");
    objective_state(var_2, "_encstr_AF5A081BBAC993AC73A3");
    setomnvar("_encstr_AA6D19DF23D6C8819A2D8B55F0EC6A0FABE02A09531F424A2FCD9A", 4);
    objective_setlabel(var_2, &"_encstr_92311E47E9E8710FC19D7DB635895B697845C78F1B39D827C107668D6FD99591");
    scripts\engine\utility::flag_waitopen("_encstr_AD6110D48622E2CBC6305277899BEBCAE3F0");
    objective_state(var_2, "_encstr_83B306C13570D0CB");
    setomnvar("_encstr_AA6D19DF23D6C8819A2D8B55F0EC6A0FABE02A09531F424A2FCD9A", 6);
  }
}

_id_12CDD(var_0) {
  scripts\engine\utility::flag_wait("_encstr_9B93128E4E16739B9956E47D8DBD6B0E8DB28EAC");
  var_1 = scripts\engine\utility::getStruct("_encstr_A6880EB329BE53D79327D3DC55101E03", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_2 = "_encstr_841F0E39B28E9CD2956759F58C581D0B";
  var_3 = scripts\cp\cp_objectives::requestworldid(var_2, 4);
  objective_setlabel(var_3, &"_encstr_8EB71C46BF27A9EF4E8187B3C9A78B71AFD65F0B06D3543ED569BBC779DD");
  objective_setplayintro(var_3, 1);
  objective_setplayoutro(var_3, 0);
  objective_position(var_3, var_0.origin + (0, 0, 12));
  objective_state(var_3, "_encstr_AF5A081BBAC993AC73A3");
  setomnvar("_encstr_AA6D19DF23D6C8819A2D8B55F0EC6A0FABE02A09531F424A2FCD9A", 5);
  objective_icon(var_3, "_encstr_A23F20C3AE82AD861FE790D0F729F8C1E9D5CEDA87FA5188E6EF9970A7765105D2BD");
  scripts\engine\utility::flag_wait("_encstr_B4FD0FD383052A67A0813B82382076A2D5");
  objective_state(var_3, "_encstr_83B306C13570D0CB");
  setomnvar("_encstr_AA6D19DF23D6C8819A2D8B55F0EC6A0FABE02A09531F424A2FCD9A", 8);
}

_id_12D8D() {
  wait 3;
  var_0 = scripts\engine\utility::getStruct("_encstr_A6880EB329BE53D79327D3DC55101E03", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = "_encstr_97CC10E2886DC7231920EBEFC163DF0B9518";
  var_2 = scripts\cp\cp_objectives::requestworldid(var_1, 2);
  objective_setlabel(var_2, &"_encstr_AC2F1EA1A07DA9A7BE543521284DA9AC5E1151C8A87288D7A17A9A149EAAC911");
  objective_setplayintro(var_2, 1);
  objective_setplayoutro(var_2, 0);
  objective_position(var_2, var_0.origin + (200, 0, 150));
  objective_state(var_2, "_encstr_AF5A081BBAC993AC73A3");
  setomnvar("_encstr_AA6D19DF23D6C8819A2D8B55F0EC6A0FABE02A09531F424A2FCD9A", 6);
  objective_icon(var_2, "_encstr_A23F20C3AE82AD861FE790D0F729F8C1E9D5CEDA87FA5188E6EF9970A7765105D2BD");
  thread _id_12BE3("_encstr_9B93128E4E16739B9956E47D8DBD6B0E8DB28EAC", var_2);
  level endon("_encstr_9B93128E4E16739B9956E47D8DBD6B0E8DB28EAC");

  while(!scripts\engine\utility::flag("_encstr_9B93128E4E16739B9956E47D8DBD6B0E8DB28EAC")) {
    scripts\engine\utility::flag_wait("_encstr_AD6110D48622E2CBC6305277899BEBCAE3F0");
    objective_state(var_2, "_encstr_83B306C13570D0CB");
    scripts\engine\utility::flag_waitopen("_encstr_AD6110D48622E2CBC6305277899BEBCAE3F0");
    objective_state(var_2, "_encstr_AF5A081BBAC993AC73A3");
  }
}

_id_12BE3(var_0, var_1) {
  scripts\engine\utility::flag_wait(var_0);
  objective_state(var_1, "_encstr_83B306C13570D0CB");
}

omnvars() {
  scripts\engine\utility::flag_wait("_encstr_9B93128E4E16739B9956E47D8DBD6B0E8DB28EAC");
  wait 1;
  var_0 = "_encstr_83901179FF8043A711A3C10AA8F99BBDD85DF4";
  var_1 = spawnStruct();
  var_2 = scripts\engine\utility::getStruct("_encstr_B43214FA6865FC1376A3F5E4CB9ED385996803D19273", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1.origin = (1147.58, -75.013, -8);
  level.oncrateactivate = var_1.origin;
  var_3 = scripts\cp\cp_objectives::requestworldid(var_0, 3);
  objective_setdescription(var_3, &"_encstr_B2111F27291FCAED7721B00E076EB631903DC0E999B54DA50B1D6B4FD1175B15C1");
  objective_setlabel(var_3, &"_encstr_B2111F27291FCAED7721B00E076EB631903DC0E999B54DA50B1D6B4FD1175B15C1");
  objective_setplayintro(var_3, 1);
  objective_setplayoutro(var_3, 0);
  objective_position(var_3, var_1.origin);
  objective_state(var_3, "_encstr_AF5A081BBAC993AC73A3");
  setomnvar("_encstr_AA6D19DF23D6C8819A2D8B55F0EC6A0FABE02A09531F424A2FCD9A", 7);
  objective_icon(var_3, "_encstr_A23F20C3AE82AD861FE790D0F729F8C1E9D5CEDA87FA5188E6EF9970A7765105D2BD");
  scripts\engine\utility::flag_wait("_encstr_B4150DB8130F4B10DFDD980EA15379");
  objective_state(var_3, "_encstr_83B306C13570D0CB");
  scripts\engine\utility::flag_waitopen("_encstr_B4150DB8130F4B10DFDD980EA15379");
  scripts\engine\utility::flag_set("_encstr_95B411439A6F401755EA174DC8AF70F0A0A0E9");
  objective_setdescription(var_3, &"_encstr_B2111F27291FCAED7721B00E076EB631903DC0E999B54DA50B1D6B4FD1175B15C1");
  objective_setlabel(var_3, &"_encstr_B2111F27291FCAED7721B00E076EB631903DC0E999B54DA50B1D6B4FD1175B15C1");
  objective_state(var_3, "_encstr_AF5A081BBAC993AC73A3");
  setomnvar("_encstr_AA6D19DF23D6C8819A2D8B55F0EC6A0FABE02A09531F424A2FCD9A", 7);
}

old_getspawnpoint_func() {
  scripts\engine\utility::flag_wait("_encstr_B4150DB8130F4B10DFDD980EA15379");
  wait 1;
  var_0 = "_encstr_8A0F149728A9B6FDD6FACB17EBDA96632043BFB24B13";
  var_1 = spawnStruct();
  var_1.origin = (1860.9, 963.5, 600);
  var_2 = scripts\cp\cp_objectives::requestworldid(var_0, 6);
  objective_setdescription(var_2, &"_encstr_A1791CF1E939571C8745A12E596F478B8D60015990021737F3BA5DB76407");
  objective_state(var_2, "_encstr_AF5A081BBAC993AC73A3");
  setomnvar("_encstr_AA6D19DF23D6C8819A2D8B55F0EC6A0FABE02A09531F424A2FCD9A", 8);
  scripts\engine\utility::flag_waitopen("_encstr_B4150DB8130F4B10DFDD980EA15379");
  objective_state(var_2, "_encstr_83B306C13570D0CB");
}

hatch_model_linkto_train() {
  scripts\engine\utility::flag_set("_encstr_B4150DB8130F4B10DFDD980EA15379");
  wait 1;
  var_0 = "_encstr_92430FE74C47102E6F3AE850F35765A0DF";
  var_1 = spawnStruct();
  var_1.origin = (1860.9, 963.5, 600);
  var_2 = scripts\engine\utility::getStruct("_encstr_A6880EB329BE53D79327D3DC55101E03", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_3 = scripts\cp\cp_objectives::requestworldid(var_0, 6);
  objective_setdescription(var_3, &"_encstr_A1791CF1E939571C8745A12E596F478B8D60015990021737F3BA5DB76407");
  objective_setlabel(var_3, &"_encstr_A1791CF1E939571C8745A12E596F478B8D60015990021737F3BA5DB76407");
  setomnvar("_encstr_AA6D19DF23D6C8819A2D8B55F0EC6A0FABE02A09531F424A2FCD9A", 8);
  objective_position(var_3, var_2.origin + (200, 0, 150));
  objective_setplayintro(var_3, 1);
  objective_setplayoutro(var_3, 0);
  objective_state(var_3, "_encstr_AF5A081BBAC993AC73A3");
  objective_icon(var_3, "_encstr_A23F20C3AE82AD861FE790D0F729F8C1E9D5CEDA87FA5188E6EF9970A7765105D2BD");
  scripts\engine\utility::flag_waitopen("_encstr_B4150DB8130F4B10DFDD980EA15379");
  objective_state(var_3, "_encstr_83B306C13570D0CB");
}

bonus_target_score(var_0) {
  var_1[1] = 7;
  var_1[2] = 10;
  var_1[3] = 13;
  var_1[4] = 16;

  if(istrue(var_0))
    wait 7;

  scripts\engine\utility::flag_set("_encstr_A6C811DC8E85E4D1AF99A5B263C8BE38D5370D");

  for(;;) {
    wait 0.1;
    var_2 = getaiarray("_encstr_8E8405EA382B2A");

    if(var_2.size < var_1[level.players.size]) {
      break;
    }

    if(level.vfx_htown_stab_blink_2) {
      break;
    }
  }
}

_id_1283D() {
  level endon("_encstr_8D5A0D46AC99B2CD32F5DCA3B04E8E");

  while(!scripts\engine\utility::flag("_encstr_8D5A0D46AC99B2CD32F5DCA3B04E8E")) {
    _encstr_AAA6354790C3F99371266D768F9F1AB9EB68BE9FA0DE3BAACF35C52E7F0F3359D840BBE720305F72935ECE625EE3C91D1B88439A68EBDB::_id_134ED("_encstr_8FBB1A5AC0BDA748E1C75851D7301793C8F9D2F209805B0960C3414A", _encstr_AAA6354790C3F99371266D768F9F1AB9EB68BE9FA0DE3BAACF35C52E7F0F3359D840BBE720305F72935ECE625EE3C91D1B88439A68EBDB::propchange(16));
    var_0 = getaiarray("_encstr_8E8405EA382B2A");

    foreach(var_2 in var_0) {
      var_2.goalradius = 800;
      var_2 setgoalpos((3413, -146, -20));
    }

    while(getaiarray("_encstr_8E8405EA382B2A").size > 1)
      wait 0.1;
  }
}

min_player_health() {
  var_0 = scripts\engine\utility::getStruct("_encstr_A6880EB329BE53D79327D3DC55101E03", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = 75;
  var_2 = var_0.origin + (0, 0, -30);
  level endon("_encstr_9B93128E4E16739B9956E47D8DBD6B0E8DB28EAC");

  for(;;) {
    wait 1;
    var_3 = getaiarray("_encstr_8E8405EA382B2A");

    if(!isDefined(var_3[0])) {
      continue;
    }
    var_4 = sortbydistance(var_3, var_0.origin)[0];

    if(distance(var_4.origin, var_2) < var_1) {
      scripts\engine\utility::flag_set("_encstr_AD6110D48622E2CBC6305277899BEBCAE3F0");
      var_5 = getEnt("_encstr_88290C99EF93882D0B5976074F4B", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
      var_5 hide();
      var_6 = getEnt("_encstr_A6C90DD8EDB5E0D53A95C9AF7BCCCC", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
      var_6 show();
      waitframe();
      var_7 = var_0 _encstr_AAA6354790C3F99371266D768F9F1AB9EB68BE9FA0DE3BAACF35C52E7F0F3359D840BBE720305F72935ECE625EE3C91D1B88439A68EBDB::_id_11A9A(&"_encstr_992C1CF73381DE01DFD724DDCEFB29133E97635D534806B908FA6C34A284");
      var_7 waittill("_encstr_8F5C086405E70FBA4B4A", var_8);
      var_7 delete();
      waitframe();
      var_5 = getEnt("_encstr_88290C99EF93882D0B5976074F4B", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
      var_5 show();
      var_6 = getEnt("_encstr_A6C90DD8EDB5E0D53A95C9AF7BCCCC", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
      var_6 hide();
      scripts\engine\utility::flag_clear("_encstr_AD6110D48622E2CBC6305277899BEBCAE3F0");
      wait 2;
    }
  }
}

bonusdeathplunder(var_0) {
  var_1 = scripts\engine\utility::getStruct("_encstr_A6880EB329BE53D79327D3DC55101E03", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  while(!scripts\engine\utility::flag("_encstr_9B93128E4E16739B9956E47D8DBD6B0E8DB28EAC")) {
    var_2 = [];
    var_3 = getaiarray("_encstr_8E8405EA382B2A");

    foreach(var_5 in var_3) {
      if(!bomb_carrier(var_5))
        var_2[var_2.size] = var_5;
    }

    var_3 = scripts\engine\utility::array_remove_array(var_3, var_2);

    if(isDefined(var_3[var_0])) {
      var_5 = sortbydistance(var_3, var_1.origin)[var_0];
      var_5 set_vehicle_anims_tromeo(var_1);

      if(level.players.size == 1)
        wait 12;
      else if(level.players.size == 2)
        wait 7;
      else
        wait 4;
    }

    waitframe();
  }
}

set_vehicle_anims_tromeo(var_0) {
  self endon("_encstr_AD75063D571AE108");
  var_1 = scripts\cp\cp_weapon::buildweapon("_encstr_925D13A28841F9E728B06A7FB1514FE8B74A497A18", ["_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99"], "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99");
  thread _encstr_842518E6D8395A38A3B9BC0B73B4AD5EB9862CE4AC8CE23BDC1B::forceuseweapon(var_1, "_encstr_BA7F0830B3A7859B60B0");
  self._id_13AF2 = 1;
  self.health = 175;
  var_2 = sortbydistance(level._id_13AF5, self.origin)[0].origin;
  level._id_13AF3 = scripts\engine\utility::array_randomize(level._id_13AF3);
  var_3 = open_this_door();
  self setgoalpos(var_2);
  childthread bomb_vests_explode(180);
  self.goalradius = 150;
  self.goalheight = 40;
  self waittill("_encstr_8B7205D9ED5958");
  self setgoalpos(var_3);
  childthread bomb_vests_explode(75);
  self.goalradius = 150;
  self.goalheight = 40;
  self waittill("_encstr_8B7205D9ED5958");
  self setgoalpos(var_0.origin + (0, 0, -30));
  self.ignoreall = 0;
  self waittill("_encstr_8B7205D9ED5958");
  self.goalradius = 600;
  self.goalheight = 50;
  self waittill("_encstr_AD75063D571AE108");
}

open_this_door() {
  var_0 = level._id_13AF3[level._id_13AF4];
  level._id_13AF4++;

  if(level._id_13AF4 == level._id_13AF3.size)
    level._id_13AF4 = 0;

  return var_0;
}

_id_13AF6() {
  level._id_13AF5 = [];
  var_0 = spawnStruct();
  var_0.origin = (184.872, 1001.06, 41);
  level._id_13AF5[level._id_13AF5.size] = var_0;
  var_1 = spawnStruct();
  var_1.origin = (16.1177, -1808.52, 16.6421);
  level._id_13AF5[level._id_13AF5.size] = var_1;
  var_2 = spawnStruct();
  var_2.origin = (439.422, 1205.44, 25.0132);
  level._id_13AF5[level._id_13AF5.size] = var_2;
  level._id_13AF3 = [];
  level._id_13AF3[level._id_13AF3.size] = (-89.31, 82.03, 46.3515);
  level._id_13AF3[level._id_13AF3.size] = (141.984, 355.185, 40);
  level._id_13AF3[level._id_13AF3.size] = (-132.506, 721.46, 42);
  level._id_13AF3[level._id_13AF3.size] = (-674.321, 26.7897, 33.2541);
}

bomb_vests_explode(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self.ignoreall = 1;
  childthread little_bird_mg_cp_init();
  self waittill("_encstr_8B7205D9ED5958");
  self.ignoreall = 0;

  if(isDefined(var_0))
    self.goalradius = var_0;
}

little_bird_mg_cp_init() {
  self endon("_encstr_8B7205D9ED5958");

  while(self.ignoreall) {
    var_0 = sortbydistance(level.players, self.origin)[0];

    if(250 > distance(self.origin, var_0.origin))
      self.ignoreall = 0;

    wait 1.0;
  }
}

vfx_htown_stab_blink_3() {
  for(;;) {
    wait 1;

    if(level.vfx_htown_stab_blink_2) {
      iprintln("_encstr_B8150641D4095338");
      continue;
    }

    iprintln("_encstr_8E950B26FDE7F283FFA3F77B77");
  }
}

velnormals() {
  var_0[1] = 7;
  var_0[2] = 6;
  var_0[3] = 5;
  var_0[4] = 4;
  scripts\engine\utility::flag_wait("_encstr_A6C811DC8E85E4D1AF99A5B263C8BE38D5370D");

  for(;;) {
    var_1 = level scripts\engine\utility::waittill_notify_or_timeout_return("_encstr_B6420CD7EBB988A1F2FFC1453F5B", var_0[level.players.size]);

    if(var_1 == "_encstr_995408F398012F656821") {
      level.vfx_htown_stab_blink_2 = 1;
      continue;
    }

    level.vfx_htown_stab_blink_2 = 0;
  }
}

subscriptions() {
  scripts\cp\laser_traps\cp_laser_traps::add_global_spawn_function("_encstr_8E8405EA382B2A", ::weapon_xp_iw8_sm_uzulu);
}

weapon_xp_iw8_sm_uzulu() {
  self endon("_encstr_8A490E5973475A8EE546CA63B23ACA46");
  self waittill("_encstr_AD75063D571AE108");
  level.jumpcomandsregistered = level.jumpcomandsregistered + 1;
  level notify("_encstr_B6420CD7EBB988A1F2FFC1453F5B");
}

isinrewardflow() {
  level endon("_encstr_930B18AF116D10C0C7F2D0D87B930E2B467BBF1F81D3A093075B");
  level.jumpcomandsregistered = 0;

  for(var_0 = 0; var_0 < 3; var_0++) {
    while(level.jumpcomandsregistered < 10 * level.players.size)
      wait 0.5;

    level.jumpcomandsregistered = 0;
    _encstr_AAA6354790C3F99371266D768F9F1AB9EB68BE9FA0DE3BAACF35C52E7F0F3359D840BBE720305F72935ECE625EE3C91D1B88439A68EBDB::weapon_xp_iw8_sm_augolf(var_0);
  }
}

vo_use_computer() {
  level endon("_encstr_847B13A0EB573B8F1A7E26A5D9033B818B57F8986F");
  childthread _encstr_AAA6354790C3F99371266D768F9F1AB9EB68BE9FA0DE3BAACF35C52E7F0F3359D840BBE720305F72935ECE625EE3C91D1B88439A68EBDB::weapon_xp_iw8_sm_papa90(4);
  scripts\engine\utility::flag_wait("_encstr_8BE714196FA3E0B88FBE611E323DE9277AF38F93D33B");
  _encstr_AAA6354790C3F99371266D768F9F1AB9EB68BE9FA0DE3BAACF35C52E7F0F3359D840BBE720305F72935ECE625EE3C91D1B88439A68EBDB::weapon_xp_iw8_sm_augolf(1);
  scripts\engine\utility::flag_wait("_encstr_85BF142A1087FDD3B0E73417A4935702DB90C2B2A029");
  _encstr_AAA6354790C3F99371266D768F9F1AB9EB68BE9FA0DE3BAACF35C52E7F0F3359D840BBE720305F72935ECE625EE3C91D1B88439A68EBDB::weapon_xp_iw8_sm_augolf(3);
}

no_more_wire_to_cut() {
  self endon("_encstr_AD75063D571AE108");
  self.ignoreall = 1;
  scripts\engine\utility::_id_143B9(30, "_encstr_8B7205D9ED5958");
  self.ignoreall = 0;
}

keep_requesting_spawners() {
  wait 10;
  _id_12DC7();
  scripts\engine\utility::flag_set("_encstr_92D90DDB303BEDAF7DF8FE293B635B");

  while(scripts\engine\utility::flag("_encstr_864715CDC158EE73B473B3FAB437D71C27B7B327ACB9E6"))
    wait 0.1;

  wait 6;
  scripts\engine\utility::flag_set("_encstr_864715CDC158EE73B473B3FAB437D71C27B7B327ACB9E6");
  setsaveddvar("_encstr_A7F10BDB5966F39BFA13DB52CD", 0.15);
  var_0 = thread _id_135EB(level._id_13DE2, "_encstr_B6ED09E3EB1D277449D9F3");
  scripts\engine\utility::flag_clear("_encstr_864715CDC158EE73B473B3FAB437D71C27B7B327ACB9E6");
  wait 1;
  thread _encstr_AAA6354790C3F99371266D768F9F1AB9EB68BE9FA0DE3BAACF35C52E7F0F3359D840BBE720305F72935ECE625EE3C91D1B88439A68EBDB::_id_134ED("_encstr_93AE1A8013CD0853694AB737A392A3130FD31810876E616702F7A445", 12);
  wait 1;

  while(getaiarray("_encstr_8E8405EA382B2A").size > 12 && !scripts\engine\utility::flag("_encstr_85BF142A1087FDD3B0E73417A4935702DB90C2B2A029")) {
    bonus_targets((402, 1234, 48), 0, 800);
    wait 0.1;
  }

  childthread ctgs_compareweaponxp();

  while(getaiarray("_encstr_8E8405EA382B2A").size > 5 && !scripts\engine\utility::flag("_encstr_85BF142A1087FDD3B0E73417A4935702DB90C2B2A029"))
    wait 0.1;

  if(scripts\engine\utility::flag("_encstr_85BF142A1087FDD3B0E73417A4935702DB90C2B2A029"))
    wait 10;
}

_id_12DC7() {
  while(getaiarray("_encstr_8E8405EA382B2A").size > 35)
    wait 0.1;

  scripts\engine\utility::flag_set("_encstr_864715CDC158EE73B473B3FAB437D71C27B7B327ACB9E6");
  var_0 = scripts\engine\utility::getStructArray("_encstr_B27B1C9238F27B547503AE6578859D9733D3584F6D3B6BDB9FF03FFCF758", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_0[0].origin = (940, 2160, 25);
  var_0[1].origin = (1124, 2160, 25);
  var_0[2].origin = (960, 2160, 25);
  var_1 = scripts\engine\utility::getStructArray("_encstr_B27B1C9238F27B547503AE6578859D9733D3584F6D3B6BDB9FF03FFCF758", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_3 in var_1)
  var_4 = var_3 scripts\cp\laser_traps\cp_laser_traps::spawn_ai(0);

  bonus_targets((-278.627, 410.686, 152), 1, 700);
  var_1 = scripts\engine\utility::getStructArray("_encstr_83D41A66B763B3097ABBE85892D5C5CEFF30FFE41E17DB4F69F36838", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_3 in var_1) {
    var_4 = var_3 scripts\cp\laser_traps\cp_laser_traps::spawn_ai(0);
    var_4._id_12DC3 = 1;
    var_4.goalradius = 200;

    if(!isDefined(var_4.target))
      var_4 setgoalpos((-914, 2137, 394));

    var_4 thread no_more_wire_to_cut();
  }

  var_8 = scripts\engine\utility::getStructArray("_encstr_84D31A1A50F5FAF353AD737C4B1853093740A2D3E04BF297AE197567", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_3 in var_8) {
    var_4 = var_3 scripts\cp\laser_traps\cp_laser_traps::spawn_ai(0);
    var_4._id_12DC3 = 1;
    var_4.goalradius = 200;
    var_4 thread no_more_wire_to_cut();
  }

  var_11 = (2648, 2623, 169);
  var_12 = scripts\engine\utility::spawn_tag_origin((-818, 2119, 855), (0, 270, 0));
  _id_1356E(var_11, var_12, "_encstr_83DB1813B68FB873B7F2B35EBA132F716715879B3233E13147AA");
  var_12 = scripts\engine\utility::spawn_tag_origin((-1040, 1890, 545), (0, 270, 0));
  _id_1356E(var_11, var_12, "_encstr_83DB1813B68FB873B7F2B35EBA132F716715879B3233E13147AA");
  var_12 = scripts\engine\utility::spawn_tag_origin((-318, 1923, 225), (0, 270, 0));
  _id_1356E(var_11, var_12, "_encstr_83DB1813B68FB873B7F2B35EBA132F716715879B3233E13147AA");

  if(level.players.size > 2) {
    var_12 = scripts\engine\utility::spawn_tag_origin((18, 1865, 713), (0, 230, 0));
    _id_1356E(var_11, var_12, "_encstr_83DB1813B68FB873B7F2B35EBA132F716715879B3233E13147AA", "_encstr_922406F1A6FD5E05");
  }

  scripts\engine\utility::flag_clear("_encstr_864715CDC158EE73B473B3FAB437D71C27B7B327ACB9E6");
}

_id_1356E(var_0, var_1, var_2, var_3) {
  var_4 = _encstr_AAA6354790C3F99371266D768F9F1AB9EB68BE9FA0DE3BAACF35C52E7F0F3359D840BBE720305F72935ECE625EE3C91D1B88439A68EBDB::_id_1352B(var_2, var_0, (0, 0, 0), undefined, 1);
  var_4 allowedstances("_encstr_922406F1A6FD5E05");
  var_4.og_fov = 1;
  wait 1;
  var_4 forceteleport(var_1.origin);
  var_4.ignoresuppression = 1;

  if(isDefined(var_3))
    var_4 allowedstances(var_3);
  else
    var_4 allowedstances("_encstr_A5AD069B231F0BAF", "_encstr_B13D076BED70539F23");

  var_4 linkTo(var_1);
}

_id_135EB(var_0, var_1) {
  var_2 = getEnt("_encstr_93760E2017E370A781B25FEF8BAA8B7B", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_3 = var_2 scripts\common\utility::spawn_vehicle();
  scripts\engine\utility::delaythread(0.5, ::_id_12364, var_3);
  _id_13562(var_3);
  var_3 scripts\common\vehicle::attach_vehicle_and_gopath(var_0);
  var_2.count = 1;
  var_3.targetname = var_1;
  return var_3;
}

_id_13562(var_0) {
  var_1 = _encstr_AAA6354790C3F99371266D768F9F1AB9EB68BE9FA0DE3BAACF35C52E7F0F3359D840BBE720305F72935ECE625EE3C91D1B88439A68EBDB::_id_134EB("_encstr_ABDB186AF08DF718B197283FAB1022F7A50983929BDD87D248F7", var_0, 0);
  var_1 = _encstr_AAA6354790C3F99371266D768F9F1AB9EB68BE9FA0DE3BAACF35C52E7F0F3359D840BBE720305F72935ECE625EE3C91D1B88439A68EBDB::_id_134EB("_encstr_A2F11CA3D33AD9B827A68B66CECC20188247073BCB5388A038BDF379F3A6", var_0, 1);
  var_1 = _encstr_AAA6354790C3F99371266D768F9F1AB9EB68BE9FA0DE3BAACF35C52E7F0F3359D840BBE720305F72935ECE625EE3C91D1B88439A68EBDB::_id_134EB("_encstr_ABDB186AF08DF718B197283FAB1022F7A50983929BDD87D248F7", var_0, 2);
  var_1 = _encstr_AAA6354790C3F99371266D768F9F1AB9EB68BE9FA0DE3BAACF35C52E7F0F3359D840BBE720305F72935ECE625EE3C91D1B88439A68EBDB::_id_134EB("_encstr_A2F11CA3D33AD9B827A68B66CECC20188247073BCB5388A038BDF379F3A6", var_0, 3);
  var_1 = _encstr_AAA6354790C3F99371266D768F9F1AB9EB68BE9FA0DE3BAACF35C52E7F0F3359D840BBE720305F72935ECE625EE3C91D1B88439A68EBDB::_id_134EB("_encstr_AC8117D01AA7DB2A77732FB0498313F74F32E8A8B3BB07E12B", var_0, 4);
  var_1 = _encstr_AAA6354790C3F99371266D768F9F1AB9EB68BE9FA0DE3BAACF35C52E7F0F3359D840BBE720305F72935ECE625EE3C91D1B88439A68EBDB::_id_134EB("_encstr_AC8117D01AA7DB2A77732FB0498313F74F32E8A8B3BB07E12B", var_0, 5);
}

keep_trying_to_kill_off_ai() {
  scripts\engine\utility::flag_set("_encstr_BEFA0D4F27C315518361D34B96AA40");
}

_id_12364(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  var_0 endon("_encstr_AD75063D571AE108");
  waitframe();
  var_1 = playFXOnTag(scripts\engine\utility::getfx("_encstr_9605101D9CBA6CB6AF86AC58238D2DB3863A"), var_0, "_encstr_BA6B157338FFF99B08AC7064A8313B3D0568496AB0456B");
  wait 7.0;
}

keephudhiddentillfadein() {
  for(;;) {
    if(scripts\engine\utility::flag("_encstr_9B93128E4E16739B9956E47D8DBD6B0E8DB28EAC")) {
      break;
    }

    _encstr_AAA6354790C3F99371266D768F9F1AB9EB68BE9FA0DE3BAACF35C52E7F0F3359D840BBE720305F72935ECE625EE3C91D1B88439A68EBDB::_id_134ED("_encstr_93AE1A8013CD0853694AB737A392A3130FD31810876E616702F7A445", 5);
    bonus_targets((-221, -588, 34), 0, 1000);

    while(getaiarray("_encstr_8E8405EA382B2A").size > 3 && !scripts\engine\utility::flag("_encstr_9B93128E4E16739B9956E47D8DBD6B0E8DB28EAC"))
      wait 0.1;
  }
}

min_pt() {
  var_0 = scripts\engine\utility::getStruct("_encstr_A6880EB329BE53D79327D3DC55101E03", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = scripts\engine\utility::spawn_tag_origin(var_0.origin, var_0.angles);
  wait 0.15;
  var_1 playSound("_encstr_B6DE17618020B89BD9F71F0BCDA928A8150AFA0FC3D0AFD3C5");
  var_1 playLoopSound("_encstr_8F68148D0EBE33A51BB2D7479358379B669593FA1B0E");
  var_2 = 0;
  var_3 = int(getdvarint("_encstr_8E47138D0EBEDCB7EB46BD77E663DBC2231DD25BAC", 240));
  var_4 = var_3;
  setomnvar("_encstr_8249154F210549D0B8C17CC458B0DF735E87D7F3E3AE33", var_2);
  setomnvar("_encstr_9B8B12A60A43AF0D698FA0B853873E2FBBF72DBD", 20);
  setomnvar("_encstr_8CB111EE10B78EB9364220C86A4F1F231FA565", var_4);

  while(var_2 < var_3) {
    wait 1;
    var_2 = var_2 + 1;

    if(!scripts\engine\utility::flag("_encstr_AADC14E3F26BFA8C15B6817E8BDA49F3499D7EC048C5") && var_2 / var_3 > 0.25)
      scripts\engine\utility::flag_set("_encstr_AADC14E3F26BFA8C15B6817E8BDA49F3499D7EC048C5");

    if(!scripts\engine\utility::flag("_encstr_8BE714196FA3E0B88FBE611E323DE9277AF38F93D33B") && var_2 / var_3 > 0.35)
      scripts\engine\utility::flag_set("_encstr_8BE714196FA3E0B88FBE611E323DE9277AF38F93D33B");

    if(!scripts\engine\utility::flag("_encstr_9182142577C7D0F9FD3A10C11742E76BE7F23E2DDE13") && var_2 / var_3 > 0.5)
      scripts\engine\utility::flag_set("_encstr_9182142577C7D0F9FD3A10C11742E76BE7F23E2DDE13");

    if(!scripts\engine\utility::flag("_encstr_85BF142A1087FDD3B0E73417A4935702DB90C2B2A029") && var_2 / var_3 > 0.75)
      scripts\engine\utility::flag_set("_encstr_85BF142A1087FDD3B0E73417A4935702DB90C2B2A029");

    setomnvar("_encstr_8249154F210549D0B8C17CC458B0DF735E87D7F3E3AE33", var_2 / var_3);
    var_4 = var_4 - 1;
    setomnvar("_encstr_8CB111EE10B78EB9364220C86A4F1F231FA565", int(var_4));

    if(scripts\engine\utility::flag("_encstr_AD6110D48622E2CBC6305277899BEBCAE3F0")) {
      var_1 stoploopsound();
      var_1 playSound("_encstr_8EFC1663E1F99FAF39B9E9636387FB9268A30AD77F086513");
      setomnvar("_encstr_8CB111EE10B78EB9364220C86A4F1F231FA565", -1);
      scripts\engine\utility::flag_waitopen("_encstr_AD6110D48622E2CBC6305277899BEBCAE3F0");
      setomnvar("_encstr_8CB111EE10B78EB9364220C86A4F1F231FA565", int(var_4));
      var_1 playSound("_encstr_B6DE17618020B89BD9F71F0BCDA928A8150AFA0FC3D0AFD3C5");
      var_1 playLoopSound("_encstr_8F68148D0EBE33A51BB2D7479358379B669593FA1B0E");
    }
  }

  setomnvar("_encstr_8249154F210549D0B8C17CC458B0DF735E87D7F3E3AE33", -1);
  scripts\engine\utility::flag_set("_encstr_9B93128E4E16739B9956E47D8DBD6B0E8DB28EAC");
  level notify("_encstr_847B13A0EB573B8F1A7E26A5D9033B818B57F8986F");
}

starscores() {
  var_0 = getEnt("_encstr_911A0D5692C2A22F56D8BF63DB0AB2", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_0.shell = "_encstr_8B030FB8D8D3F0CDDBAAAAAF88682AC159";
  var_0 hidepart("_encstr_8B030FB8D8D3F0CDDBAAAAAF88682AC159", "_encstr_B2DF0F6B969BC6EBEEDA7DDABD393A1693");
  var_1 = scripts\engine\utility::spawn_tag_origin((-94, 299, 179.5), (0, 270, 0));
  var_1 show();
  wait 0.15;
  scripts\engine\utility::flag_wait("_encstr_B15D1BC979C0FB1F1B78AA83E0605B39C8D1795AF3B107CB37D1729A69");
  var_2 = spawnStruct();
  var_2.origin = var_0 gettagorigin("_encstr_A9810C98BF98634B92DDA911C7CB");
  playFXOnTag(scripts\engine\utility::getfx("_encstr_AB090F9D991E7DEC36F6DDAFE6A34B8DDA"), var_1, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");

  for(;;) {
    var_3 = var_2 _encstr_AAA6354790C3F99371266D768F9F1AB9EB68BE9FA0DE3BAACF35C52E7F0F3359D840BBE720305F72935ECE625EE3C91D1B88439A68EBDB::_id_11A9A(&"_encstr_937E1B6698B7A74F018889F9E02AAF3E9E7C9FE52E7F8C273FC4D16158");
    var_3 waittill("_encstr_8F5C086405E70FBA4B4A", var_4);
    var_3 delete();
    illumination_flare(var_0);
    wait 0.1;
  }
}

openbunkerdoor() {
  var_0 = scripts\engine\utility::spawn_tag_origin((-1879, -680, 100), (270, 181.41, 51.5176));
  var_0 show();
  wait 0.15;
  playFXOnTag(scripts\engine\utility::getfx("_encstr_AB090F9D991E7DEC36F6DDAFE6A34B8DDA"), var_0, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  wait 1;
}

illumination_flare(var_0) {
  var_1 = var_0 gettagorigin("_encstr_A9810C98BF98634B92DDA911C7CB");
  var_2 = 2.25;
  var_3 = undefined;
  var_4 = undefined;
  var_5 = level.flare_light.og_angles + (10, 60, 0);
  var_3 = (800, -200, 800);
  level.flare_light.intensity = 50;
  var_6 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0.origin);
  var_6 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_7 = 0.15;
  wait(var_7);
  playFX(level._effect["_encstr_8E8D10E3F50BC15D506B034E43F99E7AE61B"], var_1, anglesToForward(var_0.angles));
  var_0 playSound("_encstr_8F8D198F054F9B19C5FF15D48ACA3FFE928A4B971F74392FEE200B");
  var_6 scripts\engine\utility::delaycall(0.1, ::playsoundonmovingent, "_encstr_9A9B1A0F6B1ED2EFB5785AD116250948BCA8CAD8B6C7A42A9040E920");
  thread movemortar(var_6, var_1, var_3, var_2, 400);
  wait(var_2);
  level.flare_light moveTo(var_6.origin, 0.1);
  wait 0.1;
  scripts\engine\utility::flag_set("_encstr_A7C80BB9FD63FE5F9FE157FBCD");
  thread flare_light();
  playFXOnTag(scripts\engine\utility::getfx("_encstr_A9161DC328127FB2F1196B65F38D4A1C58F82BDF8048B9CBCBB873DD69ABD3"), var_6, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  waitframe();
  var_6 playSound("_encstr_911C184702C222A110C88503793B9FD1505B332310A24D0B1BFB");
  level.flare_light moveTo((1500, -200, var_3[2] - 200), level.flare_lifetime);
  var_6 moveTo((1500, -200, var_3[2] - 200), level.flare_lifetime);
  thread flare_countdown();
  wait(level.flare_lifetime);
  var_6 delete();
  scripts\engine\utility::flag_clear("_encstr_A7C80BB9FD63FE5F9FE157FBCD");
}

player_is_just_guessing(var_0) {
  wait 0.1;
  playfxontagforclients(scripts\engine\utility::getfx("_encstr_9773185082F857404F8AC5B76267A8F363AA4028899345996F8C"), self, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", level.players[0]);
}

flare_mover(var_0) {
  while(isDefined(self) && scripts\engine\utility::flag("_encstr_A7C80BB9FD63FE5F9FE157FBCD")) {
    var_1 = self.origin[0] + randomintrange(-5, 5);
    var_2 = self.origin[1] + randomintrange(-5, 5);
    var_3 = self.origin[2] - 15;
    self moveTo((var_1, var_2, var_3), 1);
    wait 1;
  }
}

flare_countdown() {
  level.flare_countdown = level.flare_lifetime;

  for(var_0 = level.flare_lifetime; var_0 > 0; var_0--) {
    level.flare_countdown--;
    wait 1;
  }
}

movemortar(var_0, var_1, var_2, var_3, var_4) {
  setdvarifuninitialized("_encstr_996F134B0A7A8790BFA860EBE0B6C11079C8D15089", "_encstr_87070320DF");

  if(getdvarint("_encstr_996F134B0A7A8790BFA860EBE0B6C11079C8D15089")) {
    var_0.origin = var_1;
    var_5 = getdvarint("_encstr_979A08F619C1EA8361C7");
    var_6 = distance(var_1, var_2);
    var_7 = var_2 - var_1;
    var_8 = 0.5 * var_5 * squared(var_3) * -1;
    var_9 = (var_7[0] / var_3, var_7[1] / var_3, (var_7[2] - var_8) / var_3);
    var_0 movegravity(var_9, var_3);
    var_10 = gettime() + var_3 * 1000;

    while(gettime() < var_10) {
      var_0 anglemortar();
      waitframe();
    }
  } else {
    var_11 = 1200;

    if(isDefined(var_4))
      var_11 = var_4;

    var_12 = 1 / (var_3 / 0.05);
    var_13 = 0;

    while(var_13 < 1) {
      var_0.origin = scripts\engine\math::get_point_on_parabola(var_1, var_2, var_11, var_13);
      var_0 anglemortar();
      var_13 = var_13 + var_12;
      wait 0.05;
    }

    var_0.origin = var_2;
  }
}

anglemortar() {
  if(!isDefined(self.prevorigin)) {
    self.prevorigin = self.origin;
    self.roll = 0;
    return;
  }

  self.angles = vectortoangles(self.origin - self.prevorigin);
  self.prevorigin = self.origin;
}

flare_light() {
  waitframe();
  var_0 = 100;
  var_1 = 2;
  var_2 = 0;
  var_3 = level.flare_light getlightradius();

  if(isDefined(level.flare_light.intensity))
    var_0 = level.flare_light.intensity;

  level.flare_light setlightcolor((1, 0.95, 1.25));
  level.flare_light setlightintensity(var_0);
  level.flare_light setlightradius(level.flare_light getlightradius() * 2);
  level.flare_light setlightfovrange(120, 40);
  wait(level.flare_lifetime - var_2);
  level.flare_light setlightradius(var_3);
  level.flare_light setlightintensity(0);
}