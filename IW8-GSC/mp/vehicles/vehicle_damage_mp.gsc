/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\vehicles\vehicle_damage_mp.gsc
***********************************************/

_id_1340D(var_0, var_1, var_2) {
  var_3 = newclienthudelem(self);
  var_3.x = 0;
  var_3.y = 0;
  var_3.alignx = "_encstr_A5AD056A019C63";
  var_3.aligny = "_encstr_AC190479FF92";
  var_3.sort = 1;
  var_3.horzalign = "_encstr_9A940B9FAB606CCB46157F7705";
  var_3.vertalign = "_encstr_9A940B9FAB606CCB46157F7705";
  var_3.foreground = 1;

  if(isDefined(var_0) && var_0 > 0)
    var_3.alpha = 0;
  else
    var_3.alpha = 1;

  var_3 setshader("_encstr_83AB065EE1391A7B", 640, 480);

  if(isDefined(var_0) && var_0 > 0) {
    self notify("_encstr_B60B0FCA9A60EFF8603C7D2137E1E7EBA9");
    var_3 fadeovertime(var_0);
    var_3.alpha = 1.0;
    wait(var_0);
    self notify("_encstr_846A12C7CB49F517D04F68A71A88850BD5F8BB35");
  }

  if(isDefined(var_1) && var_1 > 0)
    wait(var_1);

  self notify("_encstr_867E0DE2A9B51FDB1027D3DC7328DB");

  if(!isDefined(var_2))
    var_2 = 0.5;

  if(var_2 > 0) {
    var_3 fadeovertime(var_2);
    var_3.alpha = 0.0;
    wait(var_2);
  }

  self notify("_encstr_B43C108731387D4137B78F472BDF1AB56019");

  if(isDefined(var_3))
    var_3 destroy();
}

vehomn_updateomnvarsperframe() {
  scripts\cp\cp_modular_spawning::stop_all_groups();
  level.ambient_spawning_paused = 1;

  foreach(var_1 in level.agentarray) {
    if(!istrue(var_1.isactive)) {
      continue;
    }
    var_1.nocorpse = 1;
    var_1 dodamage(var_1.health + 1000, var_1.origin, undefined, undefined, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", "_encstr_A6EC1AF35710E12197F94BF3E22B6F6A11D54927EEEA28FD836280DA");
  }

  level.ambient_spawning_paused = 0;
}

regroup_blackscreen(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_0))
    var_0 = self;

  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 disableweapons();
  var_0 scripts\cp\utility::freezecontrolswrapper(1);
  var_0 setclientomnvar("_encstr_AA5B0CE53B662BDC495081EAC891", 1);
  var_4 = newclienthudelem(var_0);
  var_4.x = 0;
  var_4.y = 0;
  var_4 setshader("_encstr_83AB065EE1391A7B", 640, 480);
  var_4.alignx = "_encstr_A5AD056A019C63";
  var_4.aligny = "_encstr_AC190479FF92";
  var_4.sort = 1;
  var_4.horzalign = "_encstr_9A940B9FAB606CCB46157F7705";
  var_4.vertalign = "_encstr_9A940B9FAB606CCB46157F7705";
  var_4.alpha = 1;
  var_4.foreground = 1;
  level waittill(var_1);
  var_0 thread _id_1333E(var_2);
  level waittill(var_3);
  var_0 setclientomnvar("_encstr_87DC0D2B694129CB535A4F55F99218", 0);
  var_0 setclientomnvar("_encstr_AA5B0CE53B662BDC495081EAC891", 0);
  var_0 scripts\cp\utility::freezecontrolswrapper(0);
  var_0 enableweapons();
  var_4 fadeovertime(2);
  var_4.alpha = 0.5;
  wait 2;
  var_4 destroy();
}

_id_13BC2(var_0) {
  if(istrue(var_0)) {
    level.disable_hotjoin_via_ac130 = 1;
    level.dogtag_revive = 1;
    level.disable_munitions = 1;
    level._id_13666 = 1;
  } else {
    if(!istrue(level._id_12B73)) {
      level.disable_hotjoin_via_ac130 = 0;
      level.dogtag_revive = 0;
    }

    level.disable_munitions = 0;
    level._id_13666 = 0;
  }

  level notify("_encstr_87571A3ADED9ECC6ACEBCD85665643EDEA3795BEB956E83A9637CECD", var_0);

  if(var_0) {
    level thread scripts\cp\cp_kidnapper::togglekidnappers(0);
    level._id_127F6 = ::_id_127F6;
  } else {
    level thread scripts\cp\cp_kidnapper::togglekidnappers(1);
    level._id_127F6 = undefined;
  }

  foreach(var_2 in level.players)
  var_2 _id_13BBE(var_0);
}

_id_13BBE(var_0) {
  var_1 = self;

  if(var_0) {
    var_1 setdemeanorviewmodel("_encstr_B418059B8533CA", "_encstr_A975161B174F60E8BD020E61AF6D20A7C28FA5EFAF62B4B0");
    var_1 thread _id_142B1();
    var_1 disableweaponswitch();
    var_1 disableoffhandweapons();
    var_1 allowmelee(0);
    var_1 allowsupersprint(0);
    var_1 allowsprint(0);
    var_1 allowads(0);
    var_1 allowcrouch(0);
    var_1 allowprone(0);
    var_1 allowmantle(0);
    var_1 allowjump(0);
    var_1 setclientomnvar("_encstr_8E9B0C9D3B11763B4351629AD8AC", 1);
    var_1.brjuggernautcratedestroycallback = 0;
    var_1.ignoreme = 1;
  } else {
    var_1 notify("_encstr_8193107065B2A8770AAF112B5FA24F7877BA");
    var_1 setdemeanorviewmodel("_encstr_820E07FAE8780B3A4C");
    var_1 enableweaponswitch();
    var_1 enableoffhandweapons();
    var_1 allowmelee(1);
    var_1 allowsupersprint(1);
    var_1 allowsprint(1);
    var_1 allowads(1);
    var_1 allowcrouch(1);
    var_1 allowprone(1);
    var_1 allowmantle(1);
    var_1 allowjump(1);
    var_1 setclientomnvar("_encstr_8E9B0C9D3B11763B4351629AD8AC", 0);
    var_1.brjuggernautcratedestroycallback = 1;
    var_1.ignoreme = 0;
  }
}

_id_142B1() {
  self endon("_encstr_8193107065B2A8770AAF112B5FA24F7877BA");
  self notify("_encstr_BD901316B348BBDFD8F92A4266A537F5900BB6871D");
  self endon("_encstr_BD901316B348BBDFD8F92A4266A537F5900BB6871D");

  for(;;) {
    self waittill("_encstr_B4C40E582257FDB09BB4077FC103B8B0");
    wait 2;

    if(istrue(self.brjuggernautcratedestroycallback)) {
      self setdemeanorviewmodel("_encstr_820E07FAE8780B3A4C");
      continue;
    }

    self setdemeanorviewmodel("_encstr_B418059B8533CA", "_encstr_A975161B174F60E8BD020E61AF6D20A7C28FA5EFAF62B4B0");
  }
}

molotov_get_pool_level_data(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0.origin);
  var_1 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_1 scripts\cp\utility::sethintobject(undefined, "_encstr_BA110C20C7C0F307EDF9111CB7A1", undefined, &"_encstr_AF7C26E121774DB144675BC7308147D0E2396547315340E702F1D72B79091CD0A1C9B771E59FAF87", 25, "_encstr_82370F09B522B08D175A6876A32BC8E07B", "_encstr_BECC055CF3811A", 256, 65, 64, 65);
  var_1.headicon = deleteheadicon(var_1);
  setheadiconfriendlyimage(var_1.headicon, "_encstr_B10119D463E897520E670BD7472DABF638AB0E5DDE9875EADF0F03");
  setheadicondrawthroughgeo(var_1.headicon, 0);
  setheadiconsnaptoedges(var_1.headicon, 1024);
  setheadiconmaxdistance(var_1.headicon, 30);
  addclienttoheadiconmask(var_1.headicon, 10);

  for(;;) {
    var_1 waittill("_encstr_8F5C086405E70FBA4B4A", var_2);

    if(!var_2 scripts\cp\utility::is_valid_player()) {
      continue;
    }
    if(scripts\cp\cp_laststand::player_in_laststand(var_2)) {
      continue;
    }
    var_2 thread edit_loadout(var_1);
  }
}

edit_loadout(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_8CBE0BD1BED30936AB03C0B02B");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level thread _id_11952(self, var_0);
  var_0 disableplayeruse(self);
  self setclientomnvar("_encstr_83A50C1B07BEB70E2B73FAD885C6", -1);
  self setclientomnvar("_encstr_83FB10572DFADB0ED196B7736EF5D6CACD5D", 2);
  scripts\engine\utility::_id_143A5("_encstr_B4C40E582257FDB09BB4077FC103B8B0", "_encstr_A26014B9FAC2217A9FF9B95DA585BB79A34CFFD8CD71");
  wait 1;
  self setclientomnvar("_encstr_83A50C1B07BEB70E2B73FAD885C6", -2);
  var_0 enableplayeruse(self);
}

_id_11952(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  var_0 endon("_encstr_A26014B9FAC2217A9FF9B95DA585BB79A34CFFD8CD71");
  var_0 waittill("_encstr_8FE01132F817F3978BE5B9BEF5567FBB5B183B");
  level thread _id_124E0(var_0, var_1);
  var_0 setclientomnvar("_encstr_83A50C1B07BEB70E2B73FAD885C6", -2);
  var_0 clearsoundsubmix("_encstr_82630E1B1CAF6E47DB4ECABE8CEA36DA", 1);
}

_id_124E0(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 endon("_encstr_9695073995D94BD959");
  var_0 waittill("_encstr_956C0F7507A3AF90D73D46BBA5A9186DCB");

  if(isDefined(var_1) && isPlayer(var_0))
    var_1 enableplayeruse(var_0);
}

mission_select_think(var_0) {
  for(;;) {
    self waittill("_encstr_8F5C086405E70FBA4B4A", var_1);

    if(!var_1 scripts\cp\utility::is_valid_player()) {
      continue;
    }
    self makeunusable();
    scripts\cp\cp_dialogue::stop_current_dialogue();
    thread run_mission(var_0);
    level notify("_encstr_A25A1158A2EADF10FF26E0EE05DBD94793CA88", var_0);
    self.used = 1;
    return;
  }
}

run_mission(var_0) {
  scripts\engine\utility::delaythread(2, scripts\cp\cp_objectives::run_objective, var_0, "_encstr_BA7F0830B3A7859B60B0");
}

_id_12E5A(var_0) {
  foreach(var_4, var_2 in level.players) {
    var_3 = 0;

    if(scripts\cp\cp_laststand::player_in_laststand(var_2))
      var_3 = 1;

    var_2 thread _id_124CE(var_0, var_4, var_3);
  }
}

_id_124CE(var_0, var_1, var_2) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0[var_1].angles = scripts\engine\utility::ter_op(isDefined(var_0[var_1].angles), var_0[var_1].angles, (0, 0, 0));
  self.respawn_forcespawnorigin = var_0[var_1].origin;
  self.respawn_forcespawnangles = var_0[var_1].angles;

  if(istrue(var_2))
    scripts\cp\cp_laststand::instant_revive(self);

  if(isDefined(self.currentturret))
    self.currentturret notify("_encstr_932D0C087BD23CA6CBBB553A4DE8", 0, 0);

  if(isDefined(level.choppergunners)) {
    foreach(var_4 in level.choppergunners)
    var_4 scripts\cp_mp\killstreaks\chopper_gunner::choppergunner_returnplayer(0, 0);
  }

  if(isDefined(self.helperdrone))
    self.helperdrone scripts\cp_mp\killstreaks\helper_drone::helperdroneexplode(0);

  if(istrue(self isonladder())) {
    self setOrigin(getgroundposition(self.origin + anglesToForward(self.angles) * -50, 16));
    wait 0.1;
  }

  var_6 = scripts\cp_mp\utility\player_utility::getvehicle();

  if(isDefined(var_6)) {
    var_7 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getoccupantseat(var_6, self);
    scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_exit(var_6, var_7, self, undefined, 1);
  }

  self setOrigin(var_0[var_1].origin);
  self setplayerangles(var_0[var_1].angles);
}

_id_11F27(var_0) {
  var_1 = 0;

  if(isDefined(var_0)) {
    foreach(var_3 in level.players) {
      if(var_3 istouching(var_0))
        var_1++;
    }
  }

  return var_1;
}

_id_12E58(var_0, var_1) {
  var_2 = 0;
  var_3 = 0;

  while(var_2 < 31) {
    var_4 = _id_11F27(var_0);
    var_5 = raid_seq3_objectives_func();

    if(var_4 && var_5.size == 0) {
      level notify("_encstr_82A21DA8EA76C399F31FF5782CF723B39F6138B8A28F3910C75B8DF8063728");

      if(var_4 == level.players.size) {
        if(!var_3) {
          thread scripts\cp\utility::objective_update("_encstr_8F5B176323DB074A5F8B1BED082D773C30D3334FB4A3F7A0BE", 6, undefined, undefined, 1, undefined, 1, 1);
          var_3 = 1;
          var_2 = int(max(var_2, 25));
        }
      } else if(!var_3) {
        thread scripts\cp\utility::objective_update("_encstr_8F5B176323DB074A5F8B1BED082D773C30D3334FB4A3F7A0BE", 30, 20, 10, 1, undefined, 1, 1);
        var_3 = 1;
      }

      var_2++;
    } else {
      if(var_3) {
        scripts\cp\cp_objectives::lua_objective_complete("_encstr_8F5B176323DB074A5F8B1BED082D773C30D3334FB4A3F7A0BE");
        thread scripts\cp\utility::objective_update("_encstr_8D5311B3A74307D05D8B3B354F32CD10532B2D");
        var_3 = 0;
      }

      var_2 = 0;
    }

    wait 1;
  }

  if(isDefined(var_1) && scripts\engine\utility::flag_exist(var_1))
    scripts\engine\utility::flag_set(var_1);
}

raid_seq3_objectives_func() {
  var_0 = [];

  foreach(var_2 in level.players) {
    if(istrue(var_2._id_12982) || istrue(var_2 isparachuting()) || istrue(var_2 isskydiving()) || istrue(self.isreviving) || istrue(self.beingrevived))
      var_0[var_0.size] = var_2;
  }

  return var_0;
}

_id_12E56(var_0) {
  foreach(var_2 in var_0)
  var_2 thread scripts\cp\utility::create_fake_loot();
}

_id_13BC1(var_0, var_1, var_2, var_3, var_4) {
  var_5 = getentitylessscriptablearrayinradius("_encstr_81CF0C378D4EA5C18E2C891BB2FA" + var_3, var_4, var_1, var_2);

  foreach(var_7 in var_5) {
    if(var_7 scriptableisdoor()) {
      if(var_0) {
        var_8 = 0;
        var_7 vehicle_getinputvalue();

        while(!var_7 scriptabledoorisclosed() && var_8 < 10) {
          wait 0.1;
          var_8++;
        }

        var_7 scriptabledoorfreeze(1);
        continue;
      }

      var_7 scriptabledoorfreeze(0);
    }
  }
}

_id_14325(var_0, var_1, var_2, var_3) {
  var_4 = getentitylessscriptablearrayinradius("_encstr_81CF0C378D4EA5C18E2C891BB2FA" + var_2, var_3, var_0, var_1);

  foreach(var_6 in var_4) {
    if(var_6 scriptableisdoor())
      var_6 thread _id_14330();
  }
}

_id_14330() {
  while(self scriptabledoorisclosed())
    wait 1;

  level notify("_encstr_AA43162B312CB73C50DB4B25F77085D74E6E62A319F04FF7");
}

_id_12409(var_0) {
  var_1 = [];
  var_2 = [];
  var_1[var_1.size] = "_encstr_A1911BDC8B5E3FB24F592A82E043A1E7B078365FB0632BBE3518519FF2";
  var_1[var_1.size] = "_encstr_83911B7CE9E1C6E39EC6822AE8FF27BE085DE6CF0F58CB6FC69BD9675B";
  var_1[var_1.size] = "_encstr_9A911B1F0AF963FB4E4F4767037F31DBD05013A586C03C2226E18F16A1";
  var_2[var_2.size] = "_encstr_994D1B6AE897FEE373B87C69469B97060FB0D352696773DF0B154731FF";
  var_2[var_2.size] = "_encstr_A64D1BA1306F280F0B3F91939753C060E70D6B5811AB484F33FBFF3DB2";
  var_2[var_2.size] = "_encstr_BA4D1BE471795E4B367E5AB2C30EBF16A0358E67A7B023D75EF3619FC3";
  var_3 = undefined;

  if(isDefined(var_0)) {
    if(var_0 == "_encstr_A9D705DF574899")
      var_3 = scripts\engine\utility::random(var_1);
    else if(var_0 == "_encstr_AFAD05B58130DB")
      var_3 = scripts\engine\utility::random(var_2);
  } else if(scripts\engine\utility::cointoss())
    var_3 = scripts\engine\utility::random(var_1);
  else
    var_3 = scripts\engine\utility::random(var_2);

  level scripts\cp\cp_vo::try_to_play_vo_on_team(var_3, "_encstr_9A8507BA4040188D08");
  _id_12408(undefined, "_encstr_97E61347B0CDA621176D7DB7CED33A476B1883E3A8");
}

_id_12408(var_0, var_1) {
  var_2 = scripts\cp\utility::getplayersinteam("_encstr_9A8507BA4040188D08");
  var_3 = [];

  foreach(var_5 in var_2) {
    if(var_5 scripts\cp_mp\utility\player_utility::_isalive())
      var_3[var_3.size] = var_5;
  }

  var_7 = scripts\engine\utility::random(var_3);

  if(isDefined(var_0))
    var_7 = var_0;

  var_8 = level scripts\cp\cp_player_battlechatter::trysaylocalsound(var_7, var_1);

  if(isfloat(var_8))
    wait(var_8);

  wait(0.4 + randomfloat(0.4));
}

_id_12E57() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    level waittill("_encstr_957F0FC1B1C22FCAC9AFE6E016EEB9CA23", var_0);

    if(istrue(level._id_13666))
      var_0 thread _id_12E5B();
  }
}

_id_12E5B() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 = self;
  var_1 = 0;

  for(;;) {
    if(isDefined(level.initlocs_bunkertest)) {
      foreach(var_3 in level.initlocs_bunkertest) {
        if(!scripts\cp\utility::any_player_nearby(var_3.origin, 64)) {
          if(!isDefined(var_3.angles))
            var_3.angles = (0, 0, 0);

          var_0.respawn_forcespawnorigin = var_3.origin;
          var_0.respawn_forcespawnangles = var_3.angles;
          var_0 setOrigin(var_3.origin);
          var_0 setplayerangles(var_3.angles);
          var_0 dontinterpolate();
          var_0 _id_13BBE(1);
          var_1 = 1;
        }
      }
    }

    if(var_1) {
      return;
    }
    wait 0.05;
  }
}

_id_127F6() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  while(nullweapon(self getcurrentprimaryweapon()))
    wait 0.05;

  var_0 = self getcurrentprimaryweapon();
  self setspawnweapon(var_0, 1);

  if(istrue(level._id_13666)) {
    self setdemeanorviewmodel("_encstr_B418059B8533CA", "_encstr_A975161B174F60E8BD020E61AF6D20A7C28FA5EFAF62B4B0");
    _id_13BBE(1);
    self._id_124C8 = 1;
  }
}

_id_1333E(var_0) {
  var_1 = getDvar("_encstr_9A050BF1B1D21107C3D5B601E0");
  var_2 = "_encstr_911904535326" + var_1 + "_encstr_A6F310A6BAC37268E64CE3C545CA7A4E3F83";
  var_3 = int(tablelookup(var_2, 1, var_0, 0));
  self setclientomnvar("_encstr_AA5B0CE53B662BDC495081EAC891", 0);
  self setclientomnvar("_encstr_A7FE1805DC2832CA4A98C780F74FB3BEE3CB30035701807931E0", var_3);
  self setclientomnvar("_encstr_87DC0D2B694129CB535A4F55F99218", 1);
  wait 5;
  level notify("_encstr_BE95124BC1DCBBADD061D7E45360B3C7F53802A2");
}