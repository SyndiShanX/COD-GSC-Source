/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\cp_pickup_hostage.gsc
***********************************************/

#using_animtree("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0");

registerhvtscriptmodels() {
  level.scr_animtree["_encstr_B1190448CD80"] = #animtree;
  init_anims();
}

initdefaulthvtmodel(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(!isDefined(var_0)) {
    return;
  }
  if(!isDefined(var_1)) {
    if(istrue(var_7))
      var_1 = "_encstr_93021917D8EBC96A7B0E69DC783FA391112067B390C00C5257ADE8";
    else
      var_1 = "_encstr_951317DEBA8CD42FCFFCF7DAA7FB85D3B85F4BB88AA8984F30";
  }

  if(!isDefined(var_3))
    var_3 = &"_encstr_B1EF21FF41C1CD111FE9AB1D50819CF6BD3329137406F5271008AB342870B95767DD3F";

  if(!isDefined(var_4))
    var_4 = "_encstr_ADD813912A8DD0E08BD2B0D86B5F23702284231FA5";

  var_8 = physics_createcontents(["_encstr_BAC1197AA4A00BC432A281DA954387A2981390DFE5A0239BC8E8E4", "_encstr_B8431C7754DBAF6823F728509B6CA1DDB33A7871EC93775004C72040AF80", "_encstr_959C16B3A1D35B0178338E95889855C22DEF872707F122C4", "_encstr_990C1A3886E537A5B1CD1BBDB98EACB91DCDFA85D2CDDE9BA5EC1A8E"]);
  var_9 = scripts\engine\trace::ray_trace(var_0 + (0, 0, 100), var_0 - (0, 0, 100), undefined, var_8);
  var_10 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_9["_encstr_BD260953AA97E3F014279D"]);
  var_10.body = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_10.origin);
  var_10.body setModel(var_1);
  var_10.body linkTo(var_10);
  var_10.idleanim = scripts\engine\utility::ter_op(istrue(var_7), "_encstr_97C82ADBAFCA410EC3B701072FAB473875C9A173951008B4FACF07054743186837DC2948BF5718FDA21F1923", "_encstr_BABF29E6919CFA6C07FA1ABDB9A3C2CECAFA8C4EDBC1B799CCFA3B27EDBA7332BE4B9136ACEB0E9636B71D");
  var_10.shownonspectatingwinnersplash = scripts\engine\utility::ter_op(istrue(var_7), (-6, 1, 0), (-9, 1, 0));
  var_10._id_135AB = var_10.origin;

  if(isDefined(var_2)) {
    var_10.head = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_10.origin);
    var_10.head setModel(var_2);
    var_10.head linkTo(var_10.body, "_encstr_BDAB07BA596A43E9EB", var_10.shownonspectatingwinnersplash, (0, 0, 0));
    var_10.head.animname = "_encstr_B1190448CD80";
    var_10.head useanimtree(level.scr_animtree["_encstr_B1190448CD80"]);
    var_10.headmodel = var_2;
    var_10.head scriptmodelplayanim(var_10.idleanim);
  }

  var_10.gender = scripts\engine\utility::ter_op(istrue(var_7), "_encstr_B82907C2887BC62B39", "_encstr_A6A205ADB0632B");
  var_10.body.animname = "_encstr_B1190448CD80";
  var_10.body useanimtree(level.scr_animtree["_encstr_B1190448CD80"]);
  var_10.bodymodel = var_1;
  var_10.drophintstring = var_4;
  var_10.pickuphintstring = var_3;
  var_10.body scriptmodelplayanim(var_10.idleanim);
  var_10.carryobjectasset = scripts\engine\utility::ter_op(isDefined(var_6), var_6, "_encstr_967F0E0D8D02F91B1C19F113C32050CB");

  if(!isDefined(level.spawnjuggernautcrateatposition))
    level.spawnjuggernautcrateatposition = [];

  level.spawnjuggernautcrateatposition[level.spawnjuggernautcrateatposition.size] = var_10;
  var_10 thread hostage_enable_rescue(0, 0);
  var_10 thread _id_11D0A();
  return var_10;
}

hostagespawnwm(var_0, var_1, var_2, var_3) {
  var_4 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self gettagorigin("_encstr_B4DF0E4DFAC663163BD21B1B59AFB12B"));
  var_4.head = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self gettagorigin("_encstr_B4DF0E4DFAC663163BD21B1B59AFB12B"));
  var_4.angles = self gettagangles("_encstr_B4DF0E4DFAC663163BD21B1B59AFB12B");

  if(isDefined(var_0))
    var_4 setModel(var_0);

  if(isDefined(var_1))
    var_4.head setModel(var_1);

  if(!isDefined(var_2))
    var_2 = (-9, 1, 0);

  var_4.head linkTo(var_4, "_encstr_BDAB07BA596A43E9EB", var_2, (0, 0, 0));
  var_4 scriptmodelplayanim("_encstr_86C91C87817EB123B8DE34FD73B0698A5D5F0F47692A791018232B46E9C0");
  var_4 linkTo(self, "_encstr_B4DF0E4DFAC663163BD21B1B59AFB12B");

  if(!istrue(var_3)) {
    var_4 hide();
    var_4.head hide();
  }

  if(isPlayer(self)) {
    var_4 hidefromplayer(self);
    var_4.head hidefromplayer(self);
  }

  var_4.animname = "_encstr_B1190448CD80";
  var_4.head.animname = "_encstr_B1190448CD80";
  var_4.head useanimtree(level.scr_animtree["_encstr_B1190448CD80"]);
  var_4 useanimtree(level.scr_animtree["_encstr_B1190448CD80"]);
  self.wmhostage = var_4;
  return var_4;
}

deletepickuphostage() {
  if(isDefined(self.head))
    self.head delete();

  self notify("_encstr_A25F0710622DF3B3D7");
  waitframe();
  self delete();
}

hostagedrop(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  self endon("_encstr_A25F0710622DF3B3D7");

  if(!isDefined(var_0))
    var_0 = self.carrier;

  if(!isDefined(var_2))
    var_2 = var_1.origin;

  if(!isDefined(var_1))
    var_1 = self;

  if(!isDefined(var_7))
    var_7 = 0;

  var_0 notify("_encstr_87681634BDB91DB03B95FA19E4B7E0E0AC19FAC4F2F5B5B2");

  if(isDefined(self.objectiveent)) {
    self.objectiveent unlink();
    self.objectiveent.origin = self.origin;
    self.objectiveent linkTo(self);
    objective_setzoffset(self.objnum, 30);
    objective_unpinforclient(self.objnum, var_0);
  }

  if(isDefined(self.hostage_drop_override_data)) {
    var_4 = self.hostage_drop_override_data.waittime;
    var_5 = self.hostage_drop_override_data.forcepos;
    var_6 = self.hostage_drop_override_data.preventuse;
  }

  var_1.carried = 0;
  var_1.carrier = undefined;
  var_1 unlink();

  if(!var_0.inlaststand)
    var_0 enableusability();

  toggledrophintstring(0, var_0, var_1);
  var_0 notify("_encstr_884A10329CDEE0C1AC91D7D07B37D1C29DB2");

  if(istrue(var_5))
    var_1.origin = var_2;
  else {
    if(var_1 spawn_module_building_chopper1(var_0)) {
      if(isDefined(var_1.waittill_any_timeout_6))
        var_2 = var_1.waittill_any_timeout_6;
    }

    var_1.origin = _getphysicspointaboutnavmesh(var_2);

    if(var_1 triggermatchendtimer()) {
      if(isDefined(var_1.waittill_any_timeout_6)) {
        var_2 = var_1.waittill_any_timeout_6;
        var_1.origin = _getphysicspointaboutnavmesh(var_2);
      }
    }

    var_1 thread spawn_module_building_chopper2(var_0);
  }

  if(!istrue(var_7))
    var_1.angles = registerchallenge(var_1.origin, self);

  if(!isDefined(var_3) && isDefined(var_1.useobj))
    var_1.useobj.origin = var_1.origin;

  if(isDefined(var_0)) {
    var_0.carryobject = undefined;
    var_0.disable_map_tablet = undefined;

    if(isDefined(var_0.wmhostage)) {
      var_0.wmhostage unlink();

      if(isDefined(var_0.wmhostage.head))
        var_0.wmhostage.head delete();

      var_0.wmhostage delete();
      var_0.wmhostage = undefined;
    }

    var_0 player_restoreweapons();
    var_0 player_removecarrydebuff();
  }

  if(isDefined(var_4))
    wait(var_4);

  if(isDefined(var_0) && isDefined(var_0.hostagecarried)) {
    var_0.hostagecarried show();

    if(isDefined(var_0.hostagecarried.head))
      var_0.hostagecarried.head show();

    var_0.hostagecarried = undefined;
    var_0.trigger_water_fx = undefined;
  }

  if(istrue(var_6)) {
    var_1 hudoutlinedisable();

    if(isDefined(var_1.head))
      var_1.head hudoutlinedisable();

    var_1 notify("_encstr_88C60846397B83835919");
    var_0 scripts\cp\utility::hint_prompt("_encstr_9A9B1B477D5B97B539F44DE914073A508F18D1505097A44A90406F30A7", 0);
    return var_1;
  }

  var_1 togglehvtusable(1);

  if(!isDefined(var_1.pickuphintstring))
    var_1.pickuphintstring = &"_encstr_B1EF21FF41C1CD111FE9AB1D50819CF6BD3329137406F5271008AB342870B95767DD3F";

  if(!isDefined(var_1.hostage_drop_override_data)) {
    if(isDefined(var_1.idleanim)) {
      var_1.body scriptmodelplayanim(var_1.idleanim);

      if(isDefined(var_1.head))
        var_1.head scriptmodelplayanim(var_1.idleanim);
    }
  }

  if(!istrue(var_1.nowaypoint) && !isDefined(self.waypoint)) {
    var_1.waypoint = create_objective(var_1.origin + (0, 0, 30), "_encstr_AFD015B4C6BDDCF5DD2C5EC1B7D2E6A3AFB516276DACC9");
    objective_setplayintro(var_1.waypoint, 0);
    objective_setplayoutro(var_1.waypoint, 0);
  }

  var_1 thread hostage_enable_rescue(0);
  var_1 thread watchfordelete();
  var_1 thread _id_144C4();

  if(isDefined(var_1.hostage_drop_override_data)) {
    if(isDefined(var_1.hostage_drop_override_data.call_back_func))
      level thread[[var_1.hostage_drop_override_data.call_back_func]](var_1, var_1.hostage_drop_override_data);

    waitframe();
    var_1.vehicle = var_1.hostage_drop_override_data.vehicle;
    var_1.hostage_drop_override_data = undefined;
  }

  var_1 notify("_encstr_88C60846397B83835919");
  return var_1;
}

triggermatchendtimer() {
  if(isDefined(level.outofboundstriggers)) {
    foreach(var_1 in level.outofboundstriggers) {
      if(self istouching(var_1))
        return 1;
    }
  }

  return 0;
}

_getphysicspointaboutnavmesh(var_0) {
  var_1 = scripts\engine\trace::create_contents(undefined, 1, 1, undefined, undefined, undefined, undefined);
  var_2 = physics_raycast(var_0 + (0, 0, 48), var_0 - (0, 0, 48), var_1, undefined, 0, "_encstr_838C158FAC235780CB6F10381FF25AD76A558896473B11");
  var_3 = isDefined(var_2) && var_2.size > 0;

  if(var_3) {
    var_4 = var_2[0]["_encstr_BD260953AA97E3F014279D"];
    return var_4;
  }

  return var_0;
}

player_restoreweapons() {
  var_0 = self;

  if(istrue(var_0.inlaststand)) {
    return;
  }
  if(isDefined(var_0.spawn_module_intro4)) {
    var_0 scripts\cp\cp_weapons::_takeweapon(var_0.spawn_module_intro4);
    var_0.spawn_module_intro4 = undefined;
  }

  if(isDefined(var_0._id_12939)) {
    self switchtoweapon(var_0._id_12939);
    var_0._id_12939 = undefined;
  }
}

spawn_module_building_chopper2(var_0) {
  var_1 = hostage_confirm_good_angles(self.origin, self.angles, var_0);

  if(!istrue(var_1.failed)) {
    self.angles = var_1.angles;
    return;
  } else {
    var_2 = 0;
    var_3 = [];
    var_3[var_3.size] = var_1.initpropcircles;

    if(isDefined(var_1.initpropcircles)) {
      var_4 = var_1.initprematchspawnlocations;
      var_5 = getclosestpointonnavmesh(var_1.initpropcircles);

      for(var_6 = 0; var_6 < 10; var_6++) {
        var_7 = hostage_confirm_good_angles(var_5, self.angles, var_0);

        if(!istrue(var_7.failed)) {
          self.origin = var_7.origin;
          self.angles = var_7.angles;
          return;
        } else {
          var_3[var_3.size] = var_5;

          if(var_7.initprematchspawnlocations > var_4 && !scripts\engine\utility::array_contains(var_3, getclosestpointonnavmesh(var_7.initpropcircles))) {
            var_4 = var_7.initprematchspawnlocations;
            var_5 = getclosestpointonnavmesh(var_7.initpropcircles);
          } else {
            var_4 = 0;
            var_2 = var_2 + 512;
            var_8 = getrandomnavpoint(self.origin, var_2);
            var_5 = getclosestpointonnavmesh(var_8);
          }
        }

        wait 0.05;
      }
    }

    if(isDefined(self._id_135AB))
      self.origin = self._id_135AB;
  }
}

hostage_confirm_good_angles(var_0, var_1, var_2, var_3) {
  var_4 = scripts\engine\trace::create_contents(0, 1, 1, 1, 1, 1, 1);
  var_5 = var_1;
  var_6 = var_0 + (0, 0, 24);

  if(!isDefined(var_3))
    var_3 = 36.0;

  var_7 = spawnStruct();
  var_7.initprematchspawnlocations = 0;

  for(var_8 = 0; var_8 < 12; var_8++) {
    var_9 = var_0 + anglesToForward(var_5) * var_3 + (0, 0, 24);

    if(scripts\engine\trace::ray_trace_passed(var_6, var_9, self, var_4)) {
      var_10 = var_9 - (0, 0, 4);
      var_11 = var_9 + (0, 0, 4);
      var_12 = undefined;

      if(isPlayer(var_2))
        var_12 = var_2 scripts\engine\trace::player_trace(var_10, var_11, var_2.angles, var_2, var_4);
      else
        var_12 = var_2 scripts\engine\trace::capsule_trace(var_10, var_11, 30, 60, var_2.angles, var_2, var_4);

      var_13 = var_12["_encstr_A53009A25003666B9818C6"];

      if(isDefined(var_13) && var_13 >= 1) {
        var_7.origin = var_0;
        var_7.angles = var_5;
        var_14 = distancesquared(var_9, getclosestpointonnavmesh(var_9));

        if(var_14 > var_7.initprematchspawnlocations) {
          var_7.initprematchspawnlocations = var_14;
          var_7.initpropcircles = var_9;
        }

        return var_7;
      } else {
        var_14 = distancesquared(var_9, getclosestpointonnavmesh(var_9));

        if(var_14 > var_7.initprematchspawnlocations) {
          var_7.initprematchspawnlocations = var_14;
          var_7.initpropcircles = var_9;
        }
      }
    } else {}

    if(var_5[1] + 30 >= 360)
      var_5 = (var_5[0], var_5[1] - 360, var_5[2]);

    var_5 = (var_5[0], var_5[1] + 30, var_5[2]);
  }

  var_7.failed = 1;
  return var_7;
}

hostage_enable_rescue(var_0, var_1) {
  self endon("_encstr_A25F0710622DF3B3D7");
  var_2 = "_encstr_BA7610B09BFEB998E2F778C98342BC771BDD";

  if(istrue(var_1))
    var_2 = "_encstr_83D40EE5AD13F109BC1A8001C2D5C5C9";

  wait 1;
  togglehvtusable(1, "_encstr_BA7610B09BFEB998E2F778C98342BC771BDD");

  for(;;) {
    self.interaction_handle waittill("_encstr_8F5C086405E70FBA4B4A", var_3);

    if(!var_3 scripts\cp\utility::is_valid_player() || istrue(var_3.isjuggernaut)) {
      continue;
    }
    if(istrue(self.pickup_disabled)) {
      continue;
    }
    var_3 scripts\common\utility::allow_vehicle_use(0);
    togglehvtusable(0);
    waitframe();

    if(istrue(self.carried_by_vehicle) && !istrue(self.convoy_pickedup))
      hostage_onuse(var_3, "_encstr_ADA706A3E4BA1BB6");
    else if(istrue(self.convoy_pickedup)) {
      hostage_onuse(var_3, "_encstr_BD1910D56708E47B7426C24A0ED5335B08F7");
      self.convoy_pickedup = undefined;
    } else
      hostage_onuse(var_3);

    break;
  }

  if(var_0)
    self notify("_encstr_AC3510D86A42498937D51886AD1FB103AF42");
}

togglehvtusable(var_0, var_1) {
  if(!isDefined(self.interaction_handle)) {
    self.interaction_handle = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self.origin + (16, 0, 8));
    self.interaction_handle linkTo(self);
  }

  if(var_0) {
    self.pickup_disabled = 0;
    self.interaction_handle makeusable();

    if(!isDefined(self.interaction_handle.pickuphintstring))
      self.interaction_handle.pickuphintstring = &"_encstr_B1EF21FF41C1CD111FE9AB1D50819CF6BD3329137406F5271008AB342870B95767DD3F";

    self.interaction_handle setCursorHint("_encstr_BA110C20C7C0F307EDF9111CB7A1");
    self.interaction_handle setHintString(self.pickuphintstring);
    self.interaction_handle setuserange(64);
    self.interaction_handle sethintdisplayrange(128);
    self.interaction_handle sethintdisplayfov(80);
    self.interaction_handle sethintonobstruction("_encstr_BD1805CB69C063");

    if(isDefined(var_1))
      self.interaction_handle setuseholdduration(var_1);
    else
      self.interaction_handle setuseholdduration("_encstr_82370F09B522B08D175A6876A32BC8E07B");

    if(!isDefined(var_1) || var_1 == "_encstr_82370F09B522B08D175A6876A32BC8E07B")
      self.interaction_handle sethintrequiresholding(0);
    else
      self.interaction_handle sethintrequiresholding(1);

    if(!istrue(self.nowaypoint) && !isDefined(self.waypoint))
      self.waypoint = create_objective(self.origin + (0, 0, 30), "_encstr_AFD015B4C6BDDCF5DD2C5EC1B7D2E6A3AFB516276DACC9");
  } else {
    self.pickup_disabled = 1;
    self.interaction_handle makeunusable();

    if(!istrue(self.nowaypoint)) {
      self notify("_encstr_BAA50F4626B18F0FCF18A2AAE801840B69");
      scripts\cp\cp_objectives::freeworldid("_encstr_88190F07B4B1B5BA83F5A1BDB98E58CECA");

      if(isDefined(self.waypoint)) {
        objective_delete(self.waypoint);
        self.waypoint = undefined;
      }
    }
  }

  self notify("_encstr_938B18DC0B609F2A80593F6B5B3EC31110909963233869B36D01");
}

_id_11D0A() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_A25F0710622DF3B3D7");
  self notify("_encstr_9BCF156BF6CDB4D1F6E4BEB37BDB19EB2339DBE083BD6E");
  self endon("_encstr_9BCF156BF6CDB4D1F6E4BEB37BDB19EB2339DBE083BD6E");
  self.waittill_any_timeout_6 = self.origin;

  for(;;) {
    wait 1;

    if(spawn_module_building_chopper1()) {
      continue;
    }
    self.waittill_any_timeout_6 = self.origin;
  }
}

spawn_module_building_chopper1(var_0) {
  if(isDefined(self.carrier))
    var_0 = self.carrier;

  if(isDefined(var_0) && isPlayer(var_0)) {
    if(scripts\cp\cp_outofbounds::isoob(var_0, 0))
      return 1;
  }

  return 0;
}

watchfordelete() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = 0;

  if(isDefined(self.waypoint))
    var_0 = self.waypoint;

  scripts\engine\utility::_id_143A5("_encstr_8BE208E31FA8E1631D65", "_encstr_AD75063D571AE108");
  scripts\cp\cp_objectives::freeworldid("_encstr_88190F07B4B1B5BA83F5A1BDB98E58CECA");
  objective_delete(var_0);
  self.waypoint = undefined;

  if(scripts\engine\utility::array_contains(level.spawnjuggernautcrateatposition, self))
    scripts\engine\utility::array_remove(level.spawnjuggernautcrateatposition, self);
}

_id_144C4() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8BE208E31FA8E1631D65");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_835F199B4D57EB83E3D1826F521A25E306405BFF386FE2236FB7AB");
  self endon("_encstr_84EC1422F820C3C5E897405187100FF3D573791A6385");
  self notify("_encstr_B2B00D0C111046F060178C1C2A0782");
  self endon("_encstr_B2B00D0C111046F060178C1C2A0782");

  for(;;) {
    wait 2.5;
    var_0 = scripts\engine\trace::ray_trace(self.origin + (0, 0, 2), self.origin - (0, 0, 24));
    var_1 = var_0["_encstr_A53009A25003666B9818C6"];

    if(isDefined(var_1) && var_1 >= 1) {
      var_2 = scripts\engine\utility::drop_to_ground(self.origin, 72);
      self.origin = _getphysicspointaboutnavmesh(var_2) + (0, 0, 2);
    }
  }
}

#using_animtree("_encstr_B40101");

do_hvt_pickup_anim(var_0) {
  var_0._id_12939 = var_0 getcurrentweapon();
  var_0.ability_invulnerable = 1;
  level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(var_0, "_encstr_95530F2299E2A7C4503BAF88D310CCF717");
  var_1 = getcompleteweaponname("_encstr_9A0D0C4B54606F8F63C84B8B53EE");
  var_0 scripts\cp_mp\utility\inventory_utility::_giveweapon(var_1, undefined, undefined, 1);
  var_2 = var_0 scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(var_1, 0);
  var_0.gunlessweapon = var_1;
  var_0 scripts\common\utility::allow_weapon_switch(0);
  var_0 scripts\common\utility::allow_weapon_pickup(0, "_encstr_B1190448CD80");
  var_0 setstance("_encstr_A5AD069B231F0BAF");
  var_0 scripts\common\utility::allow_usability(0);
  var_0 scripts\engine\utility::_id_143B9(1, "_encstr_8A390E27D0D170F2D5A0CE0497ED4A2D");
  var_0 thread create_player_rig(var_0, "_encstr_9A6D12E0B9A16FDF658173FA788F1383DE136E7C");
  self.body scripts\common\anim::anim_first_frame_solo(var_0.player_rig, "_encstr_AA0E125077B3A023C3698394BB695FCB17BF2868");
  link_player_to_rig(var_0, 0.25);
  var_0.vmvip = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self.origin);
  var_0.vmvip.angles = self.angles;
  var_0.vmvip setModel(self.bodymodel);
  var_0.vmvip.animname = "_encstr_BAB607298EEB09D45F";

  if(!isDefined(self.gender))
    self.gender = "_encstr_A6A205ADB0632B";

  var_3 = scripts\engine\utility::ter_op(self.gender == "_encstr_B82907C2887BC62B39", "_encstr_85440EC84DA37173195EDA92606753B7", "_encstr_BAB607298EEB09D45F");
  var_0.vmvip useanimtree(level.scr_animtree[var_3]);

  if(self.gender == "_encstr_B82907C2887BC62B39")
    self.body useanimtree(level.scr_animtree["_encstr_BEEF0BF07538493B15ADA27A69"]);

  if(!isDefined(self.bodymodel))
    self.bodymodel = self.body.model;

  self.body scripts\common\anim::anim_first_frame_solo(var_0.vmvip, "_encstr_AA0E125077B3A023C3698394BB695FCB17BF2868");
  var_0.vmvip hide();
  var_0.vmvip showtoplayer(var_0);

  if(isDefined(var_0.vmvip.head)) {
    var_0.vmvip.head hide();
    var_0.vmvip.head showtoplayer(var_0);
  }

  if(isDefined(self.head))
    self.head hidefromplayer(var_0);

  self.body hidefromplayer(var_0);
  self.body thread scripts\common\anim::anim_single_solo(var_0.vmvip, "_encstr_AA0E125077B3A023C3698394BB695FCB17BF2868");
  self.body thread scripts\common\anim::anim_single_solo(self.body, "_encstr_AA0E125077B3A023C3698394BB695FCB17BF2868");
  self.body thread scripts\cp\cp_anim::anim_player_solo(var_0, var_0.player_rig, "_encstr_AA0E125077B3A023C3698394BB695FCB17BF2868");
  wait(getanimlength(%_encstr_8AB21888EAE987698322EBF009C3F07B4132C039D3FD3B22B74A));
  self.body hide();

  if(isDefined(self.head))
    self.head hide();

  self linkTo(var_0);
  self.body useanimtree(level.scr_animtree["_encstr_B1190448CD80"]);

  if(isDefined(var_0.vmvip.head))
    var_0.vmvip.head delete();

  var_0.vmvip delete();
  var_4 = run_stealth_funcs(var_0, self);
  var_0 setOrigin(var_4);
  var_0 notify("_encstr_BE840BF2FFD8B0A4DB6EE31FA1");
  var_0.ability_invulnerable = undefined;
}

do_fast_hvt_pickup(var_0) {
  var_0._id_12939 = var_0 getcurrentweapon();
  level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(var_0, "_encstr_95530F2299E2A7C4503BAF88D310CCF717");
  var_1 = getcompleteweaponname("_encstr_9A0D0C4B54606F8F63C84B8B53EE");
  var_0 scripts\cp_mp\utility\inventory_utility::_giveweapon(var_1, undefined, undefined, 1);
  var_2 = var_0 scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(var_1, 0);
  var_0.gunlessweapon = var_1;
  var_0 scripts\common\utility::allow_weapon_switch(0);
  var_0 scripts\common\utility::allow_weapon_pickup(0, "_encstr_B1190448CD80");
  var_0 setstance("_encstr_A5AD069B231F0BAF");
  var_0 scripts\engine\utility::_id_143B9(1, "_encstr_8A390E27D0D170F2D5A0CE0497ED4A2D");
  self.body hide();

  if(isDefined(self.head))
    self.head hide();

  self linkTo(var_0);
}

#using_animtree("_encstr_B40101");

create_player_rig(var_0, var_1, var_2) {
  if(!isDefined(var_0) || isDefined(var_0.player_rig)) {
    return;
  }
  var_0.animname = var_1;

  if(!isDefined(var_2))
    var_2 = "_encstr_A7C813BBBC6B7C6BBB68413B5883D623473903130A";

  var_0 predictstreampos(var_0.origin);
  var_3 = spawn("_encstr_BEFE0C2FAB5A88876B4181EB4A5F", var_0.origin, 0, 0, var_0);
  var_3.player = var_0;
  var_0.player_rig = var_3;
  var_0.player_rig hide();
  var_0.player_rig.animname = var_1;
  var_0.player_rig useanimtree(#animtree);
  var_0.player_rig.angles = scripts\engine\utility::ter_op(isDefined(var_0.angles), var_0.angles, (0, 0, 0));
  scripts\engine\utility::_id_143A6("_encstr_BE840BF2FFD8B0A4DB6EE31FA1", "_encstr_AD75063D571AE108", "_encstr_8D820B49520F0EC02DDE6367EC");
  remove_player_rig(var_0);
}

remove_player_rig(var_0) {
  if(!isDefined(var_0) || !isDefined(var_0.player_rig)) {
    return;
  }
  var_0 unlink();
  var_0.player_rig delete();
  var_0.player_rig = undefined;
}

link_player_to_rig(var_0, var_1) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(!isDefined(var_0) || !isDefined(var_0.player_rig)) {
    return;
  }
  if(!isDefined(var_1))
    var_1 = 0.25;

  var_0 playerlinktoblend(var_0.player_rig, "_encstr_8E010B996FB7B6B3C1D1183343", var_1, 0.1, 0.1);
  wait(var_1);
  var_0 playerlinktodelta(var_0.player_rig, "_encstr_8E010B996FB7B6B3C1D1183343", 1, 0, 0, 0, 0, 1, 1, 1);
  var_0.player_rig showonlytoplayer(var_0);
}

#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");

do_hvt_drop_anim(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = "_encstr_AB5E07609A5B7368E5";

  var_2 = getcompleteweaponname("_encstr_9A0D0C4B54606F8F63C84B8B53EE");
  var_0 scripts\cp_mp\utility\inventory_utility::_giveweapon(var_2, undefined, undefined, 1);
  var_3 = var_0 scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(var_2, 0);
  var_0 scripts\engine\utility::_id_143B9(1, "_encstr_8A390E27D0D170F2D5A0CE0497ED4A2D");
  var_0 resetcarryobject();
  var_0 setstance("_encstr_A5AD069B231F0BAF");
  var_0 scripts\common\utility::allow_usability(0);
  var_0 unlink();
  var_0 allowmovement(1);
  self unlink();
  self.body unlink();
  self.body show();
  self.body hidefromplayer(var_0);
  var_0.vmvip = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self.origin);
  var_0.vmvip.angles = self.angles;
  var_0.vmvip setModel(self.bodymodel);
  var_0.vmvip.animname = "_encstr_BAB607298EEB09D45F";
  var_0.vmvip useanimtree(level.scr_animtree["_encstr_BAB607298EEB09D45F"]);
  var_0.vmvip hide();
  var_0.vmvip showtoplayer(var_0);
  var_0 scripts\common\anim::anim_first_frame_solo(var_0.vmvip, "_encstr_96211067465F83D780204BDF90FBAF9B05D5");
  var_0 scripts\common\anim::anim_first_frame_solo(self.body, "_encstr_96211067465F83D780204BDF90FBAF9B05D5");

  if(isDefined(self.head) && isDefined(var_0.vmvip.head)) {
    var_0 scripts\common\anim::anim_first_frame_solo(var_0.vmvip.head, "_encstr_96211067465F83D780204BDF90FBAF9B05D5");
    var_0 scripts\common\anim::anim_first_frame_solo(self.head, "_encstr_96211067465F83D780204BDF90FBAF9B05D5");
  }

  var_4 = "_encstr_96211067465F83D780204BDF90FBAF9B05D5";
  var_0 thread create_player_rig(var_0, "_encstr_8ACD106F4D42A3E13A3F18A09750FED99BF3");
  var_0 scripts\common\anim::anim_first_frame_solo(var_0.player_rig, var_4);
  link_player_to_rig(var_0);
  var_0 scripts\common\anim::anim_first_frame_solo(var_0.vmvip, "_encstr_96211067465F83D780204BDF90FBAF9B05D5");
  var_0 scripts\common\anim::anim_first_frame_solo(self.body, "_encstr_96211067465F83D780204BDF90FBAF9B05D5");

  if(isDefined(self.head) && isDefined(var_0.vmvip.head)) {
    var_0 scripts\common\anim::anim_first_frame_solo(var_0.vmvip.head, "_encstr_96211067465F83D780204BDF90FBAF9B05D5");
    var_0 scripts\common\anim::anim_first_frame_solo(self.head, "_encstr_96211067465F83D780204BDF90FBAF9B05D5");
  }

  var_0 thread scripts\cp\cp_anim::anim_player_solo(var_0, var_0.player_rig, var_4);
  var_0 thread scripts\common\anim::anim_single_solo(self.body, var_4);
  var_0 thread scripts\common\anim::anim_single_solo(var_0.vmvip, var_4);
  var_5 = getanimlength(%_encstr_83A6259B46E4AF6C83FA43DBCDE8B03BCAFA8C27F683B799CCD7ECC97BEADC32D70E1B8597CA4E);
  var_6 = getanimlength(%_encstr_A15424DCC89CD7D883FA1AED6EA3C2D92BF58C93DE07DE3366BE9D39B7BA3719BE0EA563DE47);
  wait(var_5);
  var_0 notify("_encstr_BE840BF2FFD8B0A4DB6EE31FA1");
  var_0 scripts\cp\cp_weapons::_takeweapon(var_2);
  var_7 = run_stealth_funcs(var_0, self);
  var_0 setOrigin(var_7);
  var_0 thread player_restoreweapons();
  wait(var_6 - var_5);
  var_0.vmvip delete();
  self.body show();
  self.origin = self.body.origin;
  self.angles = self.body.angles;
  wait 0.25;
  self.body linkTo(self);
}

#using_animtree("_encstr_810A1AEA3847B3D39854493595C316A9992BE66BE3D770C29F5B901A");
#using_animtree("_encstr_B40101");

do_hvt_pickup_from_truck_anim(var_0) {
  init_anims();
  var_1 = self.vehicle;
  var_2 = self;
  var_0._id_12939 = var_0 getcurrentweapon();
  var_3 = getcompleteweaponname("_encstr_9A0D0C4B54606F8F63C84B8B53EE");
  var_0 scripts\cp_mp\utility\inventory_utility::_giveweapon(var_3, undefined, undefined, 1);
  var_4 = var_0 scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(var_3, 0);
  var_0.gunlessweapon = var_3;
  var_0 scripts\common\utility::allow_weapon_switch(0);
  var_0 scripts\common\utility::allow_weapon_pickup(0, "_encstr_B1190448CD80");
  var_0 freezecontrols(1);
  var_0 setstance("_encstr_A5AD069B231F0BAF");
  var_0 scripts\engine\utility::_id_143B9(1, "_encstr_8A390E27D0D170F2D5A0CE0497ED4A2D");
  var_0 thread create_player_rig(var_0, "_encstr_BD0111A8E1F937972D39DB22281F8F1F115B0F");
  var_1 scripts\common\anim::anim_first_frame_solo(var_0.player_rig, "_encstr_93EA117B3803D302078B5BD378017A9B68B8E3");
  link_player_to_rig(var_0, 0.5);
  var_0.vmvip = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self.origin);
  var_0.vmvip.angles = self.angles;
  var_0.vmvip setModel(self.body.model);
  var_0.vmvip.animname = "_encstr_BAB607298EEB09D45F";
  var_0.vmvip useanimtree(level.scr_animtree["_encstr_BAB607298EEB09D45F"]);

  if(isDefined(self.head)) {
    var_0.vmvip.head = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self.origin);
    var_0.vmvip.head setModel(self.head.model);
    var_0.vmvip.head linkTo(var_0.vmvip, "_encstr_BDAB07BA596A43E9EB", self.shownonspectatingwinnersplash, (0, 0, 0));
    var_0.vmvip.head.animname = "_encstr_BAB607298EEB09D45F";
    var_0.vmvip.head useanimtree(level.scr_animtree["_encstr_BAB607298EEB09D45F"]);
  }

  var_0.vmvip hide();

  if(isDefined(var_0.vmvip.head))
    var_0.vmvip.head hide();

  var_0.vmvip showtoplayer(var_0);

  if(isDefined(var_0.vmvip.head))
    var_0.vmvip.head showtoplayer(var_0);

  var_2.body hidefromplayer(var_0);

  if(isDefined(var_2.head))
    var_2.head hidefromplayer(var_0);

  var_1 scripts\common\anim::anim_first_frame_solo(var_2.body, "_encstr_93EA117B3803D302078B5BD378017A9B68B8E3");

  if(isDefined(var_2.head))
    var_1 scripts\common\anim::anim_first_frame_solo(var_2.head, "_encstr_93EA117B3803D302078B5BD378017A9B68B8E3");

  var_1 scripts\common\anim::anim_first_frame_solo(var_0.vmvip, "_encstr_93EA117B3803D302078B5BD378017A9B68B8E3");

  if(isDefined(var_0.vmvip.head))
    var_1 scripts\common\anim::anim_first_frame_solo(var_0.vmvip.head, "_encstr_93EA117B3803D302078B5BD378017A9B68B8E3");

  var_1 thread scripts\cp\cp_anim::anim_player_solo(var_0, var_0.player_rig, "_encstr_93EA117B3803D302078B5BD378017A9B68B8E3");
  var_1 thread scripts\common\anim::anim_single_solo(var_0.vmvip, "_encstr_93EA117B3803D302078B5BD378017A9B68B8E3");
  var_1 thread scripts\common\anim::anim_single_solo(var_2.body, "_encstr_93EA117B3803D302078B5BD378017A9B68B8E3");
  var_1 vehicleplayanim(%_encstr_87371EBB88D948EAAEF98F9F3340E3B1D0D0F38266D81A038EFF6F6B2B762AFF);
  wait(getanimlength(%_encstr_8FDE22C3D0153967EB70B0BF7E33377F53717BFA409F6BE3E6CD92BD1EF807478B388212));
  var_2.body hide();

  if(isDefined(var_2.head))
    var_2.head hide();

  var_2 linkTo(var_0);
  var_0.vmvip delete();

  if(isDefined(var_0.vmvip.head))
    var_0.vmvip.head delete();

  var_0 notify("_encstr_BE840BF2FFD8B0A4DB6EE31FA1");
  var_0 freezecontrols(0);
}

#using_animtree("_encstr_B40101");

do_hvt_load_on_truck_anim(var_0) {
  init_anims();
  self.hostage_drop_override_data = var_0.hostage_drop_override_data;
  var_1 = var_0.hostage_drop_override_data.vehicle;
  var_2 = self;
  var_3 = getcompleteweaponname("_encstr_9A0D0C4B54606F8F63C84B8B53EE");
  var_0 scripts\cp_mp\utility\inventory_utility::_giveweapon(var_3, undefined, undefined, 1);
  var_4 = var_0 scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(var_3, 0);
  var_0 scripts\engine\utility::_id_143B9(1, "_encstr_8A390E27D0D170F2D5A0CE0497ED4A2D");
  var_0 setstance("_encstr_A5AD069B231F0BAF");
  var_0 allowcrouch(0);
  var_0 unlink();
  var_0 allowmovement(1);
  self unlink();
  self.body unlink();
  var_2.animname = "_encstr_B1190448CD80";
  var_2 useanimtree(level.scr_animtree["_encstr_B1190448CD80"]);
  var_0 thread create_player_rig(var_0, "_encstr_BD0111A8E1F937972D39DB22281F8F1F115B0F");
  var_1 scripts\common\anim::anim_first_frame_solo(var_0.player_rig, "_encstr_BEEE12EC7D30460F08A0D3FB2EFD133D70DF7646");
  link_player_to_rig(var_0, 0.5);
  var_0 resetcarryobject();
  self.body show();
  self.body hidefromplayer(var_0);
  var_0.vmvip = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_1.origin);
  var_0.vmvip.angles = self.angles;
  var_0.vmvip setModel(self.bodymodel);
  var_0.vmvip.animname = "_encstr_BAB607298EEB09D45F";
  var_0.vmvip useanimtree(level.scr_animtree["_encstr_BAB607298EEB09D45F"]);
  var_0.vmvip hide();

  if(isDefined(var_0.vmvip.head))
    var_0.vmvip.head hide();

  var_0.vmvip showtoplayer(var_0);

  if(isDefined(var_0.vmvip.head))
    var_0.vmvip.head showtoplayer(var_0);

  var_2.body show();
  var_2.body hidefromplayer(var_0);
  var_1 scripts\common\anim::anim_first_frame_solo(var_2.body, "_encstr_BEEE12EC7D30460F08A0D3FB2EFD133D70DF7646");

  if(isDefined(var_2.head))
    var_1 scripts\common\anim::anim_first_frame_solo(var_2.head, "_encstr_BEEE12EC7D30460F08A0D3FB2EFD133D70DF7646");

  var_1 scripts\common\anim::anim_first_frame_solo(var_0.vmvip, "_encstr_BEEE12EC7D30460F08A0D3FB2EFD133D70DF7646");

  if(isDefined(var_0.vmvip.head))
    var_1 scripts\common\anim::anim_first_frame_solo(var_0.vmvip.head, "_encstr_BEEE12EC7D30460F08A0D3FB2EFD133D70DF7646");

  var_1 vehicleplayanim(%_encstr_8B7E1FD9D6AF43DBDCA385ECB2F58C9CBD1C7B99CCAF474ED56C5BEB3295C61A7B);
  var_1 thread scripts\cp\cp_anim::anim_player_solo(var_0, var_0.player_rig, "_encstr_BEEE12EC7D30460F08A0D3FB2EFD133D70DF7646", "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_1 thread scripts\common\anim::anim_single_solo(var_0.vmvip, "_encstr_BEEE12EC7D30460F08A0D3FB2EFD133D70DF7646", "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_1 thread scripts\common\anim::anim_single_solo(var_2.body, "_encstr_BEEE12EC7D30460F08A0D3FB2EFD133D70DF7646", "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  wait(getanimlength(level.scr_anim["_encstr_BD0111A8E1F937972D39DB22281F8F1F115B0F"]["_encstr_BEEE12EC7D30460F08A0D3FB2EFD133D70DF7646"]));

  if(isDefined(var_0.vmvip.head))
    var_0.vmvip.head delete();

  var_0.vmvip delete();
  var_2.body show();

  if(isDefined(var_2.head))
    var_2.head show();

  var_1 thread scripts\common\anim::anim_single_solo(var_2.body, "_encstr_9B0E0FE89CEA8DDA7D34673A7D4B463656", "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_0 notify("_encstr_BE840BF2FFD8B0A4DB6EE31FA1");
  var_0 allowcrouch(1);
  var_0 scripts\cp\cp_weapons::_takeweapon(var_3);
  self.origin = self.body.origin;
  self.angles = self.body.angles;
  self.body linkTo(self);
  self linkTo(var_1);
}

load_hvt(var_0, var_1, var_2) {
  var_1 notify("_encstr_BE450C38FF80DB9D8D08C1AA90F1");
  var_0 notify("_encstr_83AE16E0B51150C39A1F374143E3AFC0A6CB081E1C7D488B");

  if(!isDefined(var_2))
    var_2 = "_encstr_A5AD056A019C63";

  var_3 = "_encstr_B2D10D8DB84A58F9504C35D8EB29B4";
  var_4 = "_encstr_A20D2FF7F10EC153A8CE04CD63A0999A6D6F537B7FB78A0E60D6BE15D8B0A151A1D7EFBBD15531CFD0DBB2DD36B8E49A93";
  var_5 = "_encstr_B2743083E5828FFF936178E713439BEF6269881B1F1777E111C908904340B867C4BEA02C3161A668CDDBD338417BC02D5FAB";

  if(var_2 == "_encstr_8253060E2B5FE330") {
    var_3 = "_encstr_ACD10D136396B62CD7324EF607FA93";
    var_4 = "_encstr_95EA2F6E29138F3981C7C92FBE532781174E58CB60320294F9B72ACD4B45D889C2E744E91495F820132D7618E85199C068";
    var_5 = "_encstr_81F230AF61AAD7271A191BD7FF61F2B7A55161E8B8100782B931994C9A38E9891BA843B94DC56FA7E36B739F8E63A8997020";
  }

  var_6 = var_1.wmexfilally;
  var_7 = getcompleteweaponname("_encstr_9A0D0C4B54606F8F63C84B8B53EE");
  var_0 scripts\cp_mp\utility\inventory_utility::_giveweapon(var_7, undefined, undefined, 1);
  var_8 = var_0 scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(var_7, 0);
  var_0 scripts\engine\utility::_id_143B9(1, "_encstr_8A390E27D0D170F2D5A0CE0497ED4A2D");
  var_0 setstance("_encstr_A5AD069B231F0BAF");
  var_0 allowcrouch(0);
  var_9 = var_0.hostagecarried;
  var_9.onchopper = 1;
  var_0 unlink();
  var_0 allowmovement(1);
  var_9 unlink();
  var_9.body unlink();
  var_9.body useanimtree(level.scr_animtree["_encstr_B1190448CD80"]);
  var_9.body.animname = "_encstr_B1190448CD80";
  var_0 thread create_player_rig(var_0, "_encstr_95DC110B1D69C0BD3367CDFBF3C97630093551");
  var_1 scripts\common\anim::anim_first_frame_solo(var_0.player_rig, var_3);
  link_player_to_rig(var_0, 0.4);
  var_0 resetcarryobject();
  var_9.body show();
  var_9.body hidefromplayer(var_0);
  var_10 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_1.origin);
  var_10 setModel("_encstr_9AC718AB8029F13F41290B6854A584408CC3C15D3EEFBBEB8F02");
  var_10 useanimtree(level.scr_animtree["_encstr_B6F40B8D18B3B74D9970991A8A"]);
  var_10.animname = "_encstr_B6F40B8D18B3B74D9970991A8A";
  var_11 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_1.origin);
  var_11 setModel(var_9.bodymodel);
  var_11 useanimtree(level.scr_animtree["_encstr_BAB607298EEB09D45F"]);
  var_11.animname = "_encstr_BAB607298EEB09D45F";

  if(isDefined(var_9.head)) {
    var_11.head = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_1.origin);
    var_11.head setModel(var_9.headmodel);
    var_11.head linkTo(var_11, "_encstr_BDAB07BA596A43E9EB", (-9, 1, 0), (0, 0, 0));
    var_11.head.animname = "_encstr_BAB607298EEB09D45F";
    var_11.head useanimtree(level.scr_animtree["_encstr_BAB607298EEB09D45F"]);
    var_11.head showonlytoplayer(var_0);
  }

  var_11 showonlytoplayer(var_0);
  var_10 showonlytoplayer(var_0);
  var_6 show();
  var_6 hidefromplayer(var_0);
  var_9.body show();
  var_9.body hidefromplayer(var_0);

  if(isDefined(var_9.head))
    var_9.head hidefromplayer(var_0);

  var_12 = getstartorigin(var_1.origin, var_1.angles, level.scr_anim["_encstr_B6F40B8D18B3B74D9970991A8A"][var_3]);
  var_13 = getstartangles(var_1.origin, var_1.angles, level.scr_anim["_encstr_B6F40B8D18B3B74D9970991A8A"][var_3]);
  var_14 = getstartorigin(var_1.origin, var_1.angles, level.scr_anim["_encstr_81480E01A90C8BB179D1D0CC784123D1"][var_3]);
  var_15 = getstartangles(var_1.origin, var_1.angles, level.scr_anim["_encstr_81480E01A90C8BB179D1D0CC784123D1"][var_3]);
  var_16 = getstartorigin(var_1.origin, var_1.angles, level.scr_anim["_encstr_BAB607298EEB09D45F"][var_3]);
  var_17 = getstartangles(var_1.origin, var_1.angles, level.scr_anim["_encstr_BAB607298EEB09D45F"][var_3]);
  var_6.origin = var_12;
  var_6.angles = var_13;
  var_10.origin = var_14;
  var_10.angles = var_15;
  var_11.origin = var_16;
  var_11.angles = var_17;
  var_9.origin = var_16;
  var_9.angles = var_17;
  var_10 linkTo(var_1);
  var_11 linkTo(var_1);
  var_9 linkTo(var_1);
  var_1.vmexfilally = var_10;
  var_1.vmhvt = var_11;
  var_18 = getstartorigin(var_1.origin, var_1.angles, level.scr_anim["_encstr_95DC110B1D69C0BD3367CDFBF3C97630093551"][var_3]);
  var_19 = getstartangles(var_1.origin, var_1.angles, level.scr_anim["_encstr_95DC110B1D69C0BD3367CDFBF3C97630093551"][var_3]);
  var_0 allowcrouch(0);
  var_0 setstance("_encstr_A5AD069B231F0BAF");
  var_6 notify("_encstr_8EC80FCDD17B387DA5918D56EB16CD4BDA");
  var_1 thread scripts\cp\cp_anim::anim_player_solo(var_0, var_0.player_rig, var_3, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_1 thread scripts\common\anim::anim_single_solo(var_10, var_3, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_1 thread scripts\common\anim::anim_single_solo(var_6, var_3, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_1 thread scripts\common\anim::anim_single_solo(var_11, var_3, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_1 thread scripts\common\anim::anim_single_solo(var_9.body, var_3, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_20 = getanimlength(level.scr_anim["_encstr_95DC110B1D69C0BD3367CDFBF3C97630093551"][var_3]);
  var_21 = getanimlength(level.scr_anim["_encstr_B1190448CD80"][var_3]);
  wait(var_20);
  var_0 setstance("_encstr_A5AD069B231F0BAF");
  var_0 notify("_encstr_BE840BF2FFD8B0A4DB6EE31FA1");
  var_0 scripts\cp\cp_weapons::_takeweapon(var_7);
  var_0 allowcrouch(1);
  hostagedrop(var_0, var_0.hostagecarried, var_0.hostagecarried.origin, 0, 0.5, 1, 1, 1);
  wait(var_21 - var_20);
  var_9.body linkTo(var_9);

  if(isDefined(var_9.head))
    var_9.head linkTo(var_9.body);

  var_9 linkTo(var_1);

  if(isDefined(var_11.head))
    var_11.head delete();

  var_11 delete();
  var_10 delete();
  var_9.body show();

  if(isDefined(var_9.head))
    var_9.head show();

  var_6 show();
  var_9.body scriptmodelplayanim(var_5);
  var_6 scriptmodelplayanim(var_4);
}

hostage_onuse(var_0, var_1, var_2) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_88C60846397B83835919");

  if(!isDefined(var_1))
    var_1 = "_encstr_AD2307ECC9EDABDC32";

  if(isDefined(self.waypoint)) {
    objective_delete(self.waypoint);
    self.waypoint = undefined;
  }

  if(isDefined(self.objectiveent)) {
    self.objectiveent unlink();
    self.objectiveent.origin = var_0.origin;
    self.objectiveent linkTo(var_0);
    objective_setzoffset(self.objnum, 45);
    objective_pinforclient(self.objnum, var_0);
  }

  self.angles = (0, self.angles[1], 0);

  switch (var_1) {
    case "_encstr_B6CC0586B28D96":
      var_2[[level.hostage_onusefunc]](var_0, self);
      break;
    case "_encstr_ADA706A3E4BA1BB6":
      do_hvt_pickup_from_truck_anim(var_0);
      break;
    case "_encstr_AD2307ECC9EDABDC32":
      do_hvt_pickup_anim(var_0);
      break;
    case "_encstr_BD1910D56708E47B7426C24A0ED5335B08F7":
      do_fast_hvt_pickup(var_0);
      break;
  }

  var_0 setcarryobject(self.carryobjectasset);
  var_0 scripts\common\utility::allow_weapon_switch(1);
  var_0 scripts\common\utility::allow_weapon_pickup(1, "_encstr_B1190448CD80");

  if(isDefined(var_0.gunlessweapon)) {
    var_0 scripts\cp\cp_weapons::_takeweapon(var_0.gunlessweapon);
    var_0.gunlessweapon = undefined;
  }

  var_0 player_carrydebuff();
  var_0.carryobject = self;
  var_0 thread listen_for_super_triggered();
  thread hostage_watchdrop(var_0, self, self.useobj);
  thread hostage_laststandlistener(var_0);
  var_0 thread watchfordrophintstring(var_0, self);
  wait 0.3;
  var_0.hostagecarried = self;
  self.carried_by_vehicle = 0;
  level notify("_encstr_835F199B4D57EB83E3D1826F521A25E306405BFF386FE2236FB7AB", var_0);
  self notify("_encstr_835F199B4D57EB83E3D1826F521A25E306405BFF386FE2236FB7AB", var_0);
}

toggledrophintstring(var_0, var_1, var_2) {
  if(isDefined(var_2.overridehintstring))
    var_1 scripts\cp\utility::hint_prompt(var_2.overridehintstring, var_0);
  else if(!isDefined(var_2.drophintstring))
    var_1 scripts\cp\utility::hint_prompt("_encstr_ADD813912A8DD0E08BD2B0D86B5F23702284231FA5", var_0);
  else
    var_1 scripts\cp\utility::hint_prompt(var_2.drophintstring, var_0);
}

watchfordrophintstring(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_87681634BDB91DB03B95FA19E4B7E0E0AC19FAC4F2F5B5B2");
  var_0 endon("_encstr_83AE16E0B51150C39A1F374143E3AFC0A6CB081E1C7D488B");
  var_1 endon("_encstr_88C60846397B83835919");

  for(;;) {
    if(candrophostage(var_0))
      toggledrophintstring(1, var_0, var_1);
    else
      toggledrophintstring(0, var_0, var_1);

    waitframe();
  }
}

hostage_laststandlistener(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_88C60846397B83835919");
  var_0 scripts\engine\utility::_id_143A6("_encstr_8CBE0BD1BED30936AB03C0B02B", "_encstr_8D820B49520F0EC02DDE6367EC", "_encstr_838B0E86EF226D41F76F30801BF5D9A1");
  var_0 disableusability();
  var_0 resetcarryobject();
  toggledrophintstring(0, var_0, self);
  self.body show();

  if(isDefined(self.head))
    self.head show();

  var_0 thread x1ops6();
  hostagedrop(var_0, self, var_0.origin);
}

x1ops6() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self waittill("_encstr_9695073995D94BD959");

  while(isDefined(self.bspawningviaac130))
    self waittill("_encstr_BD3B15285AD599F9CB3FD75C0C17C3273AE25850F22BD5");

  if(isDefined(self.spawn_module_intro4)) {
    scripts\cp\cp_weapons::_takeweapon(self.spawn_module_intro4);
    self.spawn_module_intro4 = undefined;

    if(isDefined(self.weaponlist) && self.weaponlist.size > 0)
      scripts\cp\cp_weapons::switchtoweaponreliable(self.weaponlist[0]);
  }
}

hostage_watchdrop(var_0, var_1, var_2) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_A70E14FCCFFBD3561967B6E75C5A63A501A77D728803");
  self endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_8CBE0BD1BED30936AB03C0B02B");
  var_0 endon("_encstr_83AE16E0B51150C39A1F374143E3AFC0A6CB081E1C7D488B");
  self.carried = 1;
  var_3 = 0;
  self.carrier = var_0;
  var_4 = 0.05;

  while(self.carried) {
    if(!var_0 useButtonPressed())
      var_3 = 1;

    if(!istrue(candrophostage(var_0))) {
      waitframe();
      continue;
    }

    var_5 = 0;
    var_0 setclientomnvar("_encstr_9BB011D3B5BE862D3747AFC1C9F63BC9596E37", var_5);
    var_0 allowmovement(1);

    while(var_3 && var_0 useButtonPressed()) {
      var_5 = var_5 + var_4;
      var_0 allowmovement(0);

      if(var_5 > 0.3 && candrophostage(var_0)) {
        var_0.trigger_water_fx = 1;

        if(isDefined(var_0.wmhostage)) {
          var_0.wmhostage unlink();

          if(isDefined(var_0.wmhostage.head))
            var_0.wmhostage.head delete();

          var_0.wmhostage delete();
          var_0.wmhostage = undefined;
        }

        var_0.ability_invulnerable = 1;
        var_0 notify("_encstr_87681634BDB91DB03B95FA19E4B7E0E0AC19FAC4F2F5B5B2");
        toggledrophintstring(0, var_0, var_1);
        var_6 = 0;

        if(isDefined(var_0.hostage_drop_override_data)) {
          do_hvt_load_on_truck_anim(var_0);
          var_6 = 1;
        } else
          do_hvt_drop_anim(var_0, "_encstr_AB5E07609A5B7368E5");

        var_7 = self.origin;
        hostagedrop(var_0, var_1, var_7, undefined, 0.4, 0, 0, var_6);
        var_0.ability_invulnerable = undefined;
        return;
      }

      var_0 setclientomnvar("_encstr_9BB011D3B5BE862D3747AFC1C9F63BC9596E37", var_5 / 0.3);
      wait(var_4);
    }

    waitframe();
  }
}

candrophostage(var_0) {
  if(var_0 isonladder())
    return 0;

  if(isDefined(var_0.hostage_drop_override_data))
    return 1;

  if(isDefined(level.oldkey) && distance2d(level.oldkey.origin, var_0.origin) <= 512)
    return 0;

  var_1 = var_0.origin + anglesToForward(var_0.angles) * 72.0 + (0, 0, 24);
  var_2 = scripts\engine\trace::ray_trace(var_0.origin + (0, 0, 24), var_1);

  if(var_2["_encstr_A53009A25003666B9818C6"] >= 1) {
    var_3 = scripts\engine\utility::drop_to_ground(var_1, 24);

    if(abs(var_3[2] - var_1[2]) > 40) {
      return 0;
      return;
    }

    return 1;
    return;
  } else
    return 0;
}

get_hostage_drop_pos(var_0) {
  var_1 = var_0.origin + anglesToForward(var_0.angles) * 72.0 + (0, 0, 24);
  var_2 = scripts\engine\trace::ray_trace(var_0.origin + (0, 0, 24), var_1);

  if(var_2["_encstr_A53009A25003666B9818C6"] >= 1)
    var_3 = getclosestpointonnavmesh(var_1, var_0);
  else
    var_3 = var_0.origin;

  return var_3;
}

registerchallenge(var_0, var_1) {
  var_2 = var_0 + (0, 0, 30);
  var_3 = var_0;
  var_4 = scripts\engine\trace::ray_trace(var_2, var_3, [self.body, self]);
  var_5 = var_4["_encstr_820E07FAE8780B3A4C"];
  var_6 = vectortoangles(var_5);

  if(!isDefined(var_5) || var_5 == (0, 0, 0))
    return self.angles;

  var_7 = generateaxisanglesfromupvector(var_5, self.angles);
  return var_7;
}

create_objective(var_0, var_1) {
  var_2 = scripts\cp\cp_objectives::requestworldid("_encstr_88190F07B4B1B5BA83F5A1BDB98E58CECA", 10);

  if(!isDefined(var_1))
    var_1 = "_encstr_AFD015B4C6BDDCF5DD2C5EC1B7D2E6A3AFB516276DACC9";

  objective_setplayintro(var_2, 0);
  objective_state(var_2, "_encstr_AF5A081BBAC993AC73A3");
  objective_icon(var_2, var_1);

  if(!isDefined(self.attach_entity))
    objective_position(var_2, var_0);
  else {
    objective_onentity(var_2, self.attach_entity);
    objective_setzoffset(var_2, 32);
  }

  objective_setbackground(var_2, 2);
  var_3 = "_encstr_BD3C1A68A0AF9049BE6A2B49A5FAA7099415D02AA4595435BC90B245";

  if(isDefined(self.label))
    var_3 = self.label;

  objective_setlabel(var_2, var_3);
  return var_2;
}

set_hvt_label(var_0, var_1) {
  if(!isDefined(self.waypoint)) {
    return;
  }
  objective_setlabel(self.waypoint, var_0);
  self.label = var_0;

  if(isDefined(var_1))
    objective_setshowoncompass(self.waypoint, 1);
}

listen_for_super_triggered() {
  self endon("_encstr_8CBE0BD1BED30936AB03C0B02B");
  self endon("_encstr_884A10329CDEE0C1AC91D7D07B37D1C29DB2");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  for(;;) {
    if(self secondaryoffhandbuttonPressed() && self fragButtonPressed()) {
      if(istrue(self.super_activated) || !self.super_ready) {
        waitframe();
        continue;
      }

      var_0 = getcompleteweaponname("_encstr_BEB611F03B72BB3B07E435BCF9772051117388");
      self notify("_encstr_A2600E386AB2399AF3D9B99FA3BDBAA0", var_0);
      wait 1;
    }

    waitframe();
  }
}

player_removecarrydebuff() {
  scripts\common\utility::allow_mantle(1);
  scripts\common\utility::allow_prone(1);
  scripts\common\utility::allow_crouch(1);
  scripts\common\utility::allow_sprint(1);

  if(!istrue(self.disable_hvt_nomantle))
    scripts\common\utility::allow_jump(1);

  scripts\cp\utility::allow_secondary_offhand_weapons(1);
  scripts\cp\utility::brjugg_playerwelcomesplashes(1);
  self enableoffhandweapons();
  self allowmountside(1);
  self allowmounttop(1);
  scripts\common\utility::allow_melee(1);
  self allowjog(1);
  scripts\common\utility::allow_vehicle_use(1);
  scripts\cp\cp_kidnapper::setimmunetokidnapper(0);

  if(isDefined(self.suit))
    self setsuit(self.suit);
  else
    self setsuit("_encstr_AB6C0C1784D2171608824D4727A0");

  self disableemptyclipweaponswitch(0);
  self notify("_encstr_878827C01B85818ECB1FCE45E90F316FEEE340A8A29AA7C3C72CDEB3C903394F97DAD891CA750FBBD7");
  scripts\cp\utility::_unsetperk("_encstr_ADBE1520D8B843E906A483BA51C3791B2DB02C51D1FB40");
  self.overrideweaponspeed_speedscale = undefined;
  self[[level.move_speed_scale]]();
  scripts\common\utility::allow_weapon_switch(1);
  scripts\common\utility::allow_weapon_switch_clip(1);
  self enableusability();
  scripts\common\utility::allow_weapon_pickup(1, "_encstr_B1190448CD80");
  scripts\common\utility::allow_usability(1);
}

player_carrydebuff() {
  scripts\common\utility::allow_mantle(0);

  if(!istrue(self.disable_hvt_nomantle))
    scripts\common\utility::allow_jump(0);

  scripts\common\utility::allow_prone(0);
  scripts\common\utility::allow_crouch(0);
  scripts\common\utility::allow_sprint(0);
  scripts\common\utility::allow_melee(0);
  scripts\cp\utility::brjugg_playerwelcomesplashes(0);
  self disableoffhandweapons();
  self allowmountside(0);
  self allowmounttop(0);
  scripts\cp\utility::allow_secondary_offhand_weapons(0);
  self allowjog(0);
  scripts\cp\utility::giveperk("_encstr_ADBE1520D8B843E906A483BA51C3791B2DB02C51D1FB40");
  self.overrideweaponspeed_speedscale = 0.75;
  self[[level.move_speed_scale]]();
  scripts\cp\cp_kidnapper::setimmunetokidnapper(1);

  if(isDefined(self._id_12939)) {
    if(turret_fob_self_destruct(self._id_12939))
      var_0 = scripts\cp\cp_weapons::switchtoweaponreliable(self._id_12939, 0);
    else {
      self.spawn_module_intro4 = scripts\cp\cp_weapon::buildweapon("_encstr_9106102387E011DF472978E0722F376ADAB9", [], "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99", -1);
      scripts\cp_mp\utility\inventory_utility::_giveweapon(self.spawn_module_intro4, undefined, undefined, 1);
      var_0 = scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(self.spawn_module_intro4, 0);

      if((self._id_12939.basename == "_encstr_A22812C4735AC7E2B64317C3CF560A3128DE7D0A" || self._id_12939.basename == "_encstr_95D71524C4F171FB83E84B7380FB9FFB1F50EA5FB8F33B") && isDefined(self.primaryweaponobj))
        self._id_12939 = self.primaryweaponobj;
    }
  }

  thread scripts\cp\utility::_id_14441();
  scripts\common\utility::allow_weapon_switch(0);
  scripts\common\utility::allow_weapon_switch_clip(0);
  self disableusability();
  scripts\common\utility::allow_weapon_pickup(0, "_encstr_B1190448CD80");
  scripts\common\utility::allow_usability(0);
  self disableemptyclipweaponswitch(1);
  self.disable_map_tablet = 1;
}

_id_144D1() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_884A10329CDEE0C1AC91D7D07B37D1C29DB2");
  self endon("_encstr_878827C01B85818ECB1FCE45E90F316FEEE340A8A29AA7C3C72CDEB3C903394F97DAD891CA750FBBD7");
  var_0 = self;
  var_1 = 64;
  var_2 = 1.5;
  var_3 = ["_encstr_AC822360CA62D30BDB7126294D4FB1978D438938627D71615BA737972ECFF82FF5CB118A3F", "_encstr_85B92416A340A97F83B1429915A66FB8E0B04FABAFEFC59FDB515AA7353D48B46190D39961EA"];

  for(;;) {
    var_4 = [];
    var_5 = getentitylessscriptablearrayinradius(undefined, undefined, var_0.origin, var_1);

    for(var_6 = 0; var_6 < var_5.size; var_6++) {
      if(var_5[var_6] scriptableisdoor())
        var_4[var_4.size] = var_5[var_6];
    }

    for(var_7 = 0; var_7 < var_4.size; var_7++)
      var_4[var_7] setscriptablepartstate("_encstr_B16705D9AFE22E", "_encstr_A6E508181F1B0BDEA2F0", 0);

    wait(var_2);
  }
}

player_refillammo() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_884A10329CDEE0C1AC91D7D07B37D1C29DB2");

  for(;;) {
    self waittill("_encstr_AF4D07932B1BDE5846");
    self givestartammo(self.currentprimaryweapon);
  }
}

player_refillsinglecountammo() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_A70E14FCCFFBD3561967B6E75C5A63A501A77D728803");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_884A10329CDEE0C1AC91D7D07B37D1C29DB2");
  self endon("_encstr_87681634BDB91DB03B95FA19E4B7E0E0AC19FAC4F2F5B5B2");

  for(;;) {
    if(scripts\cp_mp\utility\player_utility::_isalive() && self.team != "_encstr_AF8C0A1B6A1D6045925B4F7D" && self getcurrentweaponclipammo() <= 0 && self getweaponammostock(self.currentprimaryweapon) <= 0) {
      self givestartammo(self.currentprimaryweapon);
      wait 1;
      continue;
    }

    waitframe();
  }
}

run_stealth_funcs(var_0, var_1) {
  if(!isDefined(var_0)) {
    return;
  }
  var_2 = var_0.origin[2];
  var_3 = scripts\engine\trace::create_solid_ai_contents(1);
  var_4 = var_0.origin + (0, 0, 12);
  var_5 = var_0.origin - (0, 0, 24);
  var_6 = [var_0, var_0.player_rig, var_1.body];

  if(isDefined(var_1.head))
    var_6[var_6.size] = var_1.head;

  var_7 = var_0 scripts\engine\trace::player_trace(var_4, var_5, var_0.angles, var_6, var_3)["_encstr_8F320F36949A6929DFBB08F0C72C609FD2"];
  return var_7;
}

turret_fob_self_destruct(var_0) {
  if(!isDefined(var_0) || !isDefined(var_0.classname) || !isDefined(var_0.basename))
    return 0;

  if(istrue(self isalternatemode(var_0)))
    return 0;

  if(var_0 hasattachment("_encstr_AD9C07E0478148252A", 1))
    return 0;

  if(istrue(var_0.isalternate) && var_0.classname == "_encstr_8C8D08671D451291C849")
    return 0;

  if(var_0.basename == "_encstr_A62113273882D79A7538C5FC1A73878F706823C208" || getsubstr(var_0.basename, 0, 19) == "_encstr_8B1314E1674A5917AE76933A1986038E4A9B324FFBB0")
    return 0;

  if(getsubstr(var_0.basename, 0, 7) == "_encstr_B2E0084B77C1BE0E2DBE" || getsubstr(var_0.basename, 0, 7) == "_encstr_A7E00814142896A7DDA9" || getsubstr(var_0.basename, 0, 7) == "_encstr_84E108DAA3532F0EC8DF" || var_0.basename == "_encstr_850C10636F4181D09FDDE07886D04250DADB" || var_0.basename == "_encstr_A1AF15733C88381B0A0E8743929044085DAF9A1DBF905B" || var_0.basename == "_encstr_9A45126853289743936788FE33DF2B13F279F028") {
    if(getsubstr(var_0.basename, 0, 7) == "_encstr_B2E0084B77C1BE0E2DBE" && var_0 hasattachment("_encstr_B1AD067FC8C8B2A7", 1))
      return 0;

    return 1;
  }

  return 0;
}

_id_12350(var_0) {
  var_0 playsoundonmovingent("_encstr_B8EA2257B8D3FF92779761A470379B8919286FE37829333B6138775A6813F254A6E83B63");
}

_id_12351(var_0) {
  var_0 playsoundonmovingent("_encstr_92B1276AA54B094940708F29986F8092C1587160403B1A4B1969E7634FF388834919013368D5993E8E");
}

modeplayerkilledspawn(var_0) {
  var_0 playsoundonmovingent("_encstr_822822E6477BE73920374340FF5C31DF5221D5EE1DB37F411E1F70A0A775280159925976");
}

modeplayerskipdialog(var_0) {
  var_0 playsoundonmovingent("_encstr_AA7E264B5353C73E8BB1E9572EBB62C775F9BD7E70EB3F87E94957F3F5DB056DB7BFF49837085831");
}

_id_1234F(var_0) {
  var_0 playsoundonmovingent("_encstr_814024BF3CCAA9FEF743D638DAEF2D0B27955F31A976C03DB3A9A963E22FE8E071F8BB91471B");
}

modeonexitlaststandfunc(var_0) {
  var_0 playsoundonmovingent("_encstr_A15424DCC89CD7D883FA1AED6EA3C2D92BF58C93DE07DE3366BE9D39B7BA3719BE0EA563DE47");
}

#using_animtree("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");

init_anims() {
  level.scr_animtree["_encstr_9A6D12E0B9A16FDF658173FA788F1383DE136E7C"] = #animtree;
  level.scr_anim["_encstr_9A6D12E0B9A16FDF658173FA788F1383DE136E7C"]["_encstr_AA0E125077B3A023C3698394BB695FCB17BF2868"] = % _encstr_8AB21888EAE987698322EBF009C3F07B4132C039D3FD3B22B74A;
  level.scr_animname["_encstr_9A6D12E0B9A16FDF658173FA788F1383DE136E7C"]["_encstr_AA0E125077B3A023C3698394BB695FCB17BF2868"] = "_encstr_8AB21888EAE987698322EBF009C3F07B4132C039D3FD3B22B74A";
  level.scr_eventanim["_encstr_9A6D12E0B9A16FDF658173FA788F1383DE136E7C"]["_encstr_AA0E125077B3A023C3698394BB695FCB17BF2868"] = "_encstr_B49F12F494CB77CBA937E8AB63C76165823B6075";
  scripts\common\anim::addnotetrack_customfunction("_encstr_9A6D12E0B9A16FDF658173FA788F1383DE136E7C", "_encstr_B8EA2257B8D3FF92779761A470379B8919286FE37829333B6138775A6813F254A6E83B63", ::_id_12350);
  scripts\common\anim::addnotetrack_customfunction("_encstr_9A6D12E0B9A16FDF658173FA788F1383DE136E7C", "_encstr_BA4926F349105107389B6922400E1396E023A778CB30E4875F96E28B2865430FC9B11CE20FA0EA97", ::_id_12351);
  level.scr_animtree["_encstr_8ACD106F4D42A3E13A3F18A09750FED99BF3"] = #animtree;
  level.scr_anim["_encstr_8ACD106F4D42A3E13A3F18A09750FED99BF3"]["_encstr_96211067465F83D780204BDF90FBAF9B05D5"] = % _encstr_9991193455F9CF297233381167B44033417D2DBDA1638911518768;
  level.scr_animname["_encstr_8ACD106F4D42A3E13A3F18A09750FED99BF3"]["_encstr_96211067465F83D780204BDF90FBAF9B05D5"] = "_encstr_9991193455F9CF297233381167B44033417D2DBDA1638911518768";
  level.scr_eventanim["_encstr_8ACD106F4D42A3E13A3F18A09750FED99BF3"]["_encstr_96211067465F83D780204BDF90FBAF9B05D5"] = "_encstr_922813FD2B3A6F041A47734866065F50A2F74B90E0";
  scripts\common\anim::addnotetrack_customfunction("_encstr_8ACD106F4D42A3E13A3F18A09750FED99BF3", "_encstr_822822E6477BE73920374340FF5C31DF5221D5EE1DB37F411E1F70A0A775280159925976", ::modeplayerkilledspawn);
  scripts\common\anim::addnotetrack_customfunction("_encstr_8ACD106F4D42A3E13A3F18A09750FED99BF3", "_encstr_AA7E264B5353C73E8BB1E9572EBB62C775F9BD7E70EB3F87E94957F3F5DB056DB7BFF49837085831", ::modeplayerskipdialog);
  level.scr_animtree["_encstr_B1190448CD80"] = #animtree;
  level.scr_anim["_encstr_B1190448CD80"]["_encstr_AA0E125077B3A023C3698394BB695FCB17BF2868"] = % _encstr_9AD82337C84EAFC638F586ED9B8E16B3B2FA0E5A36AD5D38EB3B4EEDAE7346FA074BB1EDA3;
  level.scr_animname["_encstr_B1190448CD80"]["_encstr_AA0E125077B3A023C3698394BB695FCB17BF2868"] = "_encstr_9AD82337C84EAFC638F586ED9B8E16B3B2FA0E5A36AD5D38EB3B4EEDAE7346FA074BB1EDA3";
  level.scr_animtree["_encstr_BEEF0BF07538493B15ADA27A69"] = #animtree;
  level.scr_anim["_encstr_BEEF0BF07538493B15ADA27A69"]["_encstr_AA0E125077B3A023C3698394BB695FCB17BF2868"] = % _encstr_99892ACD19277D1B0ED7A1DEDCD10BEC59FA0796D85BBA83FA76C97BBA7323D738968DF6D1EB33956BC263B2;
  level.scr_animname["_encstr_BEEF0BF07538493B15ADA27A69"]["_encstr_AA0E125077B3A023C3698394BB695FCB17BF2868"] = "_encstr_99892ACD19277D1B0ED7A1DEDCD10BEC59FA0796D85BBA83FA76C97BBA7323D738968DF6D1EB33956BC263B2";
  level.scr_anim["_encstr_B1190448CD80"]["_encstr_96211067465F83D780204BDF90FBAF9B05D5"] = % _encstr_A15424DCC89CD7D883FA1AED6EA3C2D92BF58C93DE07DE3366BE9D39B7BA3719BE0EA563DE47;
  level.scr_animname["_encstr_B1190448CD80"]["_encstr_96211067465F83D780204BDF90FBAF9B05D5"] = "_encstr_A15424DCC89CD7D883FA1AED6EA3C2D92BF58C93DE07DE3366BE9D39B7BA3719BE0EA563DE47";
  level.scr_animtree["_encstr_BAB607298EEB09D45F"] = #animtree;
  level.scr_anim["_encstr_BAB607298EEB09D45F"]["_encstr_AA0E125077B3A023C3698394BB695FCB17BF2868"] = % _encstr_925A1653588FF6AF6B26614FB77043B867805A5990516D87;
  level.scr_animname["_encstr_BAB607298EEB09D45F"]["_encstr_AA0E125077B3A023C3698394BB695FCB17BF2868"] = "_encstr_925A1653588FF6AF6B26614FB77043B867805A5990516D87";
  level.scr_animtree["_encstr_85440EC84DA37173195EDA92606753B7"] = #animtree;
  level.scr_anim["_encstr_85440EC84DA37173195EDA92606753B7"]["_encstr_AA0E125077B3A023C3698394BB695FCB17BF2868"] = % _encstr_95FF1DB3ADFAD80B9CE497F558B136E5AFA5E67D58D8B15EFA33596B58C6CA;
  level.scr_animname["_encstr_85440EC84DA37173195EDA92606753B7"]["_encstr_AA0E125077B3A023C3698394BB695FCB17BF2868"] = "_encstr_95FF1DB3ADFAD80B9CE497F558B136E5AFA5E67D58D8B15EFA33596B58C6CA";
  level.scr_anim["_encstr_BAB607298EEB09D45F"]["_encstr_96211067465F83D780204BDF90FBAF9B05D5"] = % _encstr_A66317862B092E7FC64B9BE131118360B1871D0C3790B5736B;
  level.scr_animname["_encstr_BAB607298EEB09D45F"]["_encstr_96211067465F83D780204BDF90FBAF9B05D5"] = "_encstr_A66317862B092E7FC64B9BE131118360B1871D0C3790B5736B";
  level.scr_animtree["_encstr_B1190448CD80"] = #animtree;
  level.scr_anim["_encstr_B1190448CD80"]["_encstr_ACD10D136396B62CD7324EF607FA93"] = % _encstr_86D4252B5F3AB1FE5327B1B7BF3B37A8C5793183058078244A3F9DA92F720F218AC13B786DF718;
  level.scr_animname["_encstr_B1190448CD80"]["_encstr_ACD10D136396B62CD7324EF607FA93"] = "_encstr_86D4252B5F3AB1FE5327B1B7BF3B37A8C5793183058078244A3F9DA92F720F21AAC13B786DF718";
  level.scr_anim["_encstr_B1190448CD80"]["_encstr_B4AF1226C6D2AD85BEC8E4DB0EBE27EB9623B1CA"] = % _encstr_81F230AF61AAD7271A191BD7FF61F2B7A55161E8B8100782B931994C9A38E9899BA843B94DC56FA7E36B739F8E63A8997020;
  level.scr_animname["_encstr_B1190448CD80"]["_encstr_B4AF1226C6D2AD85BEC8E4DB0EBE27EB9623B1CA"] = "_encstr_81F230AF61AAD7271A191BD7FF61F2B7A55161E8B8100782B931994C9A38E9891BA843B94DC56FA7E36B739F8E63A8997020";
  level.scr_anim["_encstr_B1190448CD80"]["_encstr_B2D10D8DB84A58F9504C35D8EB29B4"] = % _encstr_B49E2576D7EB77A9B0C7F0D06FECA14F22B1657EED23CF318EAFA8C02F1D7987DA29E70B858AB1;
  level.scr_animname["_encstr_B1190448CD80"]["_encstr_B2D10D8DB84A58F9504C35D8EB29B4"] = "_encstr_B49E2576D7EB77A9B0C7F0D06FECA14F22B1657EED23CF318EAFA8C02F1D7987D829E70B858AB1";
  level.scr_anim["_encstr_B1190448CD80"]["_encstr_B22A1230E27CF3014F5C06F02027E8CF24CAF880"] = % _encstr_B2743083E5828FFF936178E713439BEF6269881B1F1777E111C908904340B867E4BEA02C3161A668CDDBD338417BC02D5FAB;
  level.scr_animname["_encstr_B1190448CD80"]["_encstr_B22A1230E27CF3014F5C06F02027E8CF24CAF880"] = "_encstr_B2743083E5828FFF936178E713439BEF6269881B1F1777E111C908904340B867C4BEA02C3161A668CDDBD338417BC02D5FAB";
  level.scr_animtree["_encstr_B6F40B8D18B3B74D9970991A8A"] = #animtree;
  level.scr_anim["_encstr_B6F40B8D18B3B74D9970991A8A"]["_encstr_B2D10D8DB84A58F9504C35D8EB29B4"] = % _encstr_8614243B49A3BFCFC88713C79ABB71977FE9ECC2A20708A7A477C56189E726F07CF761ED24B3;
  level.scr_animname["_encstr_B6F40B8D18B3B74D9970991A8A"]["_encstr_B2D10D8DB84A58F9504C35D8EB29B4"] = "_encstr_8614243B49A3BFCFC88713C79ABB71977FE9ECC2A20708A7A477C56189E726F05CF761ED24B3";
  level.scr_anim["_encstr_B6F40B8D18B3B74D9970991A8A"]["_encstr_852E15EA4C97655A0F384EBF5AAF0CA7B21520B50F738E"] = % _encstr_85642F425FB2E063F2AFC810F3198F91B7575943625240C3777722DD730B216760BF8A2DF0CD3EE7752CF308AE2F1AD142;
  level.scr_animname["_encstr_B6F40B8D18B3B74D9970991A8A"]["_encstr_852E15EA4C97655A0F384EBF5AAF0CA7B21520B50F738E"] = "_encstr_85642F425FB2E063F2AFC810F3198F91B7575943625240C3777722DD730B216764BF8A2DF0CD3EE7752CF308AE2F1AD142";
  level.scr_anim["_encstr_B6F40B8D18B3B74D9970991A8A"]["_encstr_960B16A0B082C1EA4E324B38018EF967E3ED7A45764AC8BB"] = % _encstr_A20D2FF7F10EC153A8CE04CD63A0999A6D6F537B7FB78A0E60D6BE15D8B0A151B1D7EFBBD15531CFD0DBB2DD36B8E49A93;
  level.scr_animname["_encstr_B6F40B8D18B3B74D9970991A8A"]["_encstr_960B16A0B082C1EA4E324B38018EF967E3ED7A45764AC8BB"] = "_encstr_A20D2FF7F10EC153A8CE04CD63A0999A6D6F537B7FB78A0E60D6BE15D8B0A151A1D7EFBBD15531CFD0DBB2DD36B8E49A93";
  level.scr_anim["_encstr_B6F40B8D18B3B74D9970991A8A"]["_encstr_ACD10D136396B62CD7324EF607FA93"] = % _encstr_B43F24C29188472237B7A34717DDCAB7E85EBF0A68F00F2A049F83430B09B2D7F8A6761560CB;
  level.scr_animname["_encstr_B6F40B8D18B3B74D9970991A8A"]["_encstr_ACD10D136396B62CD7324EF607FA93"] = "_encstr_B43F24C29188472237B7A34717DDCAB7E85EBF0A68F00F2A049F83430B09B2D7F9A6761560CB";
  level.scr_anim["_encstr_B6F40B8D18B3B74D9970991A8A"]["_encstr_86CD150808DF9A4329B9AAF5F3878DE73127420A603370"] = % _encstr_BA302F53E9B0F1A717DEBAB2236DE7B75037FCDA6748056B34F6128A48C91F61404F79548958411FE88B0BA2961763E5E0;
  level.scr_animname["_encstr_B6F40B8D18B3B74D9970991A8A"]["_encstr_86CD150808DF9A4329B9AAF5F3878DE73127420A603370"] = "_encstr_BA302F53E9B0F1A717DEBAB2236DE7B75037FCDA6748056B34F6128A48C91F61414F79548958411FE88B0BA2961763E5E0";
  level.scr_anim["_encstr_B6F40B8D18B3B74D9970991A8A"]["_encstr_9ADD1626D82DB6C2AF4627ED83EB27AFB4238D59F5BD5D3A"] = % _encstr_95EA2F6E29138F3981C7C92FBE532781174E58CB60320294F9B72ACD4B45D889E2E744E91495F820132D7618E85199C068;
  level.scr_animname["_encstr_B6F40B8D18B3B74D9970991A8A"]["_encstr_9ADD1626D82DB6C2AF4627ED83EB27AFB4238D59F5BD5D3A"] = "_encstr_95EA2F6E29138F3981C7C92FBE532781174E58CB60320294F9B72ACD4B45D889C2E744E91495F820132D7618E85199C068";
  level.scr_anim["_encstr_81480E01A90C8BB179D1D0CC784123D1"]["_encstr_B2D10D8DB84A58F9504C35D8EB29B4"] = % _encstr_8107205B2547F0C7FB1309F795EF71BA9FEA6555F6D713F2BF7FB0A9E0696A80AA27;
  level.scr_animname["_encstr_81480E01A90C8BB179D1D0CC784123D1"]["_encstr_B2D10D8DB84A58F9504C35D8EB29B4"] = "_encstr_8107205B2547F0C7FB1309F795EF71BA9FEA6555F6D713F2BF7FB0A9E1696A80AA27";
  level.scr_anim["_encstr_81480E01A90C8BB179D1D0CC784123D1"]["_encstr_ACD10D136396B62CD7324EF607FA93"] = % _encstr_B16820FDA7E12360533B01D9671770669ABB57553349FE80915509D6CA2F80910207;
  level.scr_animname["_encstr_81480E01A90C8BB179D1D0CC784123D1"]["_encstr_ACD10D136396B62CD7324EF607FA93"] = "_encstr_B16820FDA7E12360533B01D9671770669ABB57553349FE80915509D6C22F80910207";
  level.scr_animtree["_encstr_95DC110B1D69C0BD3367CDFBF3C97630093551"] = #animtree;
  level.scr_anim["_encstr_95DC110B1D69C0BD3367CDFBF3C97630093551"]["_encstr_B2D10D8DB84A58F9504C35D8EB29B4"] = % _encstr_BA312256FBD93C9796BB2A32E1F8F3F27B69F7CE75314643B3B022B9E8D05BADD8037542;
  level.scr_animname["_encstr_95DC110B1D69C0BD3367CDFBF3C97630093551"]["_encstr_B2D10D8DB84A58F9504C35D8EB29B4"] = "_encstr_BA312256FBD93C9796BB2A32E1F8F3F27B69F7CE75314643B3B022B9ECD05BADD8037542";
  level.scr_eventanim["_encstr_95DC110B1D69C0BD3367CDFBF3C97630093551"]["_encstr_B2D10D8DB84A58F9504C35D8EB29B4"] = "_encstr_BE8816F0BD783E30FDA8A3C70104E3F00B91593BFA83FFFC";
  level.scr_anim["_encstr_95DC110B1D69C0BD3367CDFBF3C97630093551"]["_encstr_ACD10D136396B62CD7324EF607FA93"] = % _encstr_A7BD22D3D80FB417CBA5F9F73596E3FA87C8CA4A28B76E53E001C1D756BEFB05C3289283;
  level.scr_animname["_encstr_95DC110B1D69C0BD3367CDFBF3C97630093551"]["_encstr_ACD10D136396B62CD7324EF607FA93"] = "_encstr_A7BD22D3D80FB417CBA5F9F73596E3FA87C8CA4A28B76E53E001C1D746BEFB05C3289283";
  level.scr_eventanim["_encstr_95DC110B1D69C0BD3367CDFBF3C97630093551"]["_encstr_ACD10D136396B62CD7324EF607FA93"] = "_encstr_A988164002982D260BB1E748924B28CB46D918D8AA723FDB";
  level.scr_anim["_encstr_BAB607298EEB09D45F"]["_encstr_B2D10D8DB84A58F9504C35D8EB29B4"] = % _encstr_9B532146EBC92C8786CB5A22F1C8E3E2F079C7DE052176B3A38052A9F8206B9C80DF54;
  level.scr_animname["_encstr_BAB607298EEB09D45F"]["_encstr_B2D10D8DB84A58F9504C35D8EB29B4"] = "_encstr_9B532146EBC92C8786CB5A22F1C8E3E2F079C7DE052176B3A38052A9FC206B9C80DF54";
  level.scr_anim["_encstr_BAB607298EEB09D45F"]["_encstr_ACD10D136396B62CD7324EF607FA93"] = % _encstr_A5D321CEDABED0BD374716CE95F5469C7B83DB99CC7DC4D8B46BC2F527F5C1D2B17B1D;
  level.scr_animname["_encstr_BAB607298EEB09D45F"]["_encstr_ACD10D136396B62CD7324EF607FA93"] = "_encstr_A5D321CEDABED0BD374716CE95F5469C7B83DB99CC7DC4D8B46BC2F525F5C1D2B17B1D";
  level.scr_anim["_encstr_BAB607298EEB09D45F"]["_encstr_93EA117B3803D302078B5BD378017A9B68B8E3"] = % _encstr_81441E36CD3F582802ABEBFFCF4E434AEA7C35DF0F9382DF370A4F194A8C88D1;
  level.scr_animname["_encstr_BAB607298EEB09D45F"]["_encstr_93EA117B3803D302078B5BD378017A9B68B8E3"] = "_encstr_81441E36CD3F582802ABEBFFCF4E434AEA7C35DF0F9382DF370A4F194A8C88D1";
  level.scr_anim["_encstr_BAB607298EEB09D45F"]["_encstr_BEEE12EC7D30460F08A0D3FB2EFD133D70DF7646"] = % _encstr_960B1FB3B8E1430ACB337A3C2B8EE9D3E0E74AC45149C03A306AB210B228E530B3;
  level.scr_animname["_encstr_BAB607298EEB09D45F"]["_encstr_BEEE12EC7D30460F08A0D3FB2EFD133D70DF7646"] = "_encstr_960B1FB3B8E1430ACB337A3C2B8EE9D3E0E74AC45149C03A306AB210B228E530B3";
  level.scr_animtree["_encstr_B1190448CD80"] = #animtree;
  level.scr_anim["_encstr_B1190448CD80"]["_encstr_ACD10D136396B62CD7324EF607FA93"] = % _encstr_86D4252B5F3AB1FE5327B1B7BF3B37A8C5793183058078244A3F9DA92F720F218AC13B786DF718;
  level.scr_animname["_encstr_B1190448CD80"]["_encstr_ACD10D136396B62CD7324EF607FA93"] = "_encstr_86D4252B5F3AB1FE5327B1B7BF3B37A8C5793183058078244A3F9DA92F720F21AAC13B786DF718";
  level.scr_anim["_encstr_B1190448CD80"]["_encstr_B4AF1226C6D2AD85BEC8E4DB0EBE27EB9623B1CA"] = % _encstr_81F230AF61AAD7271A191BD7FF61F2B7A55161E8B8100782B931994C9A38E9899BA843B94DC56FA7E36B739F8E63A8997020;
  level.scr_animname["_encstr_B1190448CD80"]["_encstr_B4AF1226C6D2AD85BEC8E4DB0EBE27EB9623B1CA"] = "_encstr_81F230AF61AAD7271A191BD7FF61F2B7A55161E8B8100782B931994C9A38E9891BA843B94DC56FA7E36B739F8E63A8997020";
  level.scr_anim["_encstr_B1190448CD80"]["_encstr_B2D10D8DB84A58F9504C35D8EB29B4"] = % _encstr_B49E2576D7EB77A9B0C7F0D06FECA14F22B1657EED23CF318EAFA8C02F1D7987DA29E70B858AB1;
  level.scr_animname["_encstr_B1190448CD80"]["_encstr_B2D10D8DB84A58F9504C35D8EB29B4"] = "_encstr_B49E2576D7EB77A9B0C7F0D06FECA14F22B1657EED23CF318EAFA8C02F1D7987D829E70B858AB1";
  level.scr_anim["_encstr_B1190448CD80"]["_encstr_B22A1230E27CF3014F5C06F02027E8CF24CAF880"] = % _encstr_B2743083E5828FFF936178E713439BEF6269881B1F1777E111C908904340B867E4BEA02C3161A668CDDBD338417BC02D5FAB;
  level.scr_animname["_encstr_B1190448CD80"]["_encstr_B22A1230E27CF3014F5C06F02027E8CF24CAF880"] = "_encstr_B2743083E5828FFF936178E713439BEF6269881B1F1777E111C908904340B867C4BEA02C3161A668CDDBD338417BC02D5FAB";
  level.scr_anim["_encstr_B1190448CD80"]["_encstr_BEEE12EC7D30460F08A0D3FB2EFD133D70DF7646"] = % _encstr_AF9923961C1B272F7039D05827931994D077449B754848F503F14433E3A64A091B70A1F7CB;
  level.scr_animname["_encstr_B1190448CD80"]["_encstr_BEEE12EC7D30460F08A0D3FB2EFD133D70DF7646"] = "_encstr_AF9923961C1B272F7039D05827931994D077449B754848F503F14433E3A64A091B70A1F7CB";
  level.scr_anim["_encstr_B1190448CD80"]["_encstr_93EA117B3803D302078B5BD378017A9B68B8E3"] = % _encstr_9A9322DA89905FCACF4F4B5F3FF5D2DF80769224015B3D33B0E13B0F0712797018B8CDEB;
  level.scr_animname["_encstr_B1190448CD80"]["_encstr_93EA117B3803D302078B5BD378017A9B68B8E3"] = "_encstr_9A9322DA89905FCACF4F4B5F3FF5D2DF80769224015B3D33B0E13B0F0712797018B8CDEB";
  level.scr_anim["_encstr_B1190448CD80"]["_encstr_9B0E0FE89CEA8DDA7D34673A7D4B463656"] = % _encstr_AFCC28B9C8C9BE36C1EB1ABDB9E8163BB27D4627ED0EBDCCCCEB474E5DC6ADF5D2191B95EBC1A5D87BE8;
  level.scr_animname["_encstr_B1190448CD80"]["_encstr_9B0E0FE89CEA8DDA7D34673A7D4B463656"] = "_encstr_AFCC28B9C8C9BE36C1EB1ABDB9E8163BB27D4627ED0EBDCCCCEB474E5DC6ADF5D2191B95EBC1A5D87BE8";
  level.scr_animtree["_encstr_B6F40B8D18B3B74D9970991A8A"] = #animtree;
  level.scr_anim["_encstr_B6F40B8D18B3B74D9970991A8A"]["_encstr_B2D10D8DB84A58F9504C35D8EB29B4"] = % _encstr_8614243B49A3BFCFC88713C79ABB71977FE9ECC2A20708A7A477C56189E726F07CF761ED24B3;
  level.scr_animname["_encstr_B6F40B8D18B3B74D9970991A8A"]["_encstr_B2D10D8DB84A58F9504C35D8EB29B4"] = "_encstr_8614243B49A3BFCFC88713C79ABB71977FE9ECC2A20708A7A477C56189E726F05CF761ED24B3";
  level.scr_anim["_encstr_B6F40B8D18B3B74D9970991A8A"]["_encstr_852E15EA4C97655A0F384EBF5AAF0CA7B21520B50F738E"] = % _encstr_85642F425FB2E063F2AFC810F3198F91B7575943625240C3777722DD730B216760BF8A2DF0CD3EE7752CF308AE2F1AD142;
  level.scr_animname["_encstr_B6F40B8D18B3B74D9970991A8A"]["_encstr_852E15EA4C97655A0F384EBF5AAF0CA7B21520B50F738E"] = "_encstr_85642F425FB2E063F2AFC810F3198F91B7575943625240C3777722DD730B216764BF8A2DF0CD3EE7752CF308AE2F1AD142";
  level.scr_anim["_encstr_B6F40B8D18B3B74D9970991A8A"]["_encstr_960B16A0B082C1EA4E324B38018EF967E3ED7A45764AC8BB"] = % _encstr_A20D2FF7F10EC153A8CE04CD63A0999A6D6F537B7FB78A0E60D6BE15D8B0A151B1D7EFBBD15531CFD0DBB2DD36B8E49A93;
  level.scr_animname["_encstr_B6F40B8D18B3B74D9970991A8A"]["_encstr_960B16A0B082C1EA4E324B38018EF967E3ED7A45764AC8BB"] = "_encstr_A20D2FF7F10EC153A8CE04CD63A0999A6D6F537B7FB78A0E60D6BE15D8B0A151A1D7EFBBD15531CFD0DBB2DD36B8E49A93";
  level.scr_anim["_encstr_B6F40B8D18B3B74D9970991A8A"]["_encstr_ACD10D136396B62CD7324EF607FA93"] = % _encstr_B43F24C29188472237B7A34717DDCAB7E85EBF0A68F00F2A049F83430B09B2D7F8A6761560CB;
  level.scr_animname["_encstr_B6F40B8D18B3B74D9970991A8A"]["_encstr_ACD10D136396B62CD7324EF607FA93"] = "_encstr_B43F24C29188472237B7A34717DDCAB7E85EBF0A68F00F2A049F83430B09B2D7F9A6761560CB";
  level.scr_anim["_encstr_B6F40B8D18B3B74D9970991A8A"]["_encstr_86CD150808DF9A4329B9AAF5F3878DE73127420A603370"] = % _encstr_BA302F53E9B0F1A717DEBAB2236DE7B75037FCDA6748056B34F6128A48C91F61404F79548958411FE88B0BA2961763E5E0;
  level.scr_animname["_encstr_B6F40B8D18B3B74D9970991A8A"]["_encstr_86CD150808DF9A4329B9AAF5F3878DE73127420A603370"] = "_encstr_BA302F53E9B0F1A717DEBAB2236DE7B75037FCDA6748056B34F6128A48C91F61414F79548958411FE88B0BA2961763E5E0";
  level.scr_anim["_encstr_B6F40B8D18B3B74D9970991A8A"]["_encstr_9ADD1626D82DB6C2AF4627ED83EB27AFB4238D59F5BD5D3A"] = % _encstr_95EA2F6E29138F3981C7C92FBE532781174E58CB60320294F9B72ACD4B45D889E2E744E91495F820132D7618E85199C068;
  level.scr_animname["_encstr_B6F40B8D18B3B74D9970991A8A"]["_encstr_9ADD1626D82DB6C2AF4627ED83EB27AFB4238D59F5BD5D3A"] = "_encstr_95EA2F6E29138F3981C7C92FBE532781174E58CB60320294F9B72ACD4B45D889C2E744E91495F820132D7618E85199C068";
  level.scr_anim["_encstr_81480E01A90C8BB179D1D0CC784123D1"]["_encstr_B2D10D8DB84A58F9504C35D8EB29B4"] = % _encstr_8107205B2547F0C7FB1309F795EF71BA9FEA6555F6D713F2BF7FB0A9E0696A80AA27;
  level.scr_animname["_encstr_81480E01A90C8BB179D1D0CC784123D1"]["_encstr_B2D10D8DB84A58F9504C35D8EB29B4"] = "_encstr_8107205B2547F0C7FB1309F795EF71BA9FEA6555F6D713F2BF7FB0A9E1696A80AA27";
  level.scr_anim["_encstr_81480E01A90C8BB179D1D0CC784123D1"]["_encstr_ACD10D136396B62CD7324EF607FA93"] = % _encstr_B16820FDA7E12360533B01D9671770669ABB57553349FE80915509D6CA2F80910207;
  level.scr_animname["_encstr_81480E01A90C8BB179D1D0CC784123D1"]["_encstr_ACD10D136396B62CD7324EF607FA93"] = "_encstr_B16820FDA7E12360533B01D9671770669ABB57553349FE80915509D6C22F80910207";
  level.scr_animtree["_encstr_B6F40B8D18B3B74D9970991A8A"] = #animtree;
  level.scr_anim["_encstr_B6F40B8D18B3B74D9970991A8A"]["_encstr_BA1D0A8407054D36417ADB5B"] = % _encstr_8E8531CBD81D217FE34888B7764B3F776B69C25318B1E5B3D9508ABC033007B191D14BCBC0755AC7B3A39FA630F8374629A003;
  level.scr_animname["_encstr_B6F40B8D18B3B74D9970991A8A"]["_encstr_BA1D0A8407054D36417ADB5B"] = "_encstr_8E8531CBD81D217FE34888B7764B3F776B69C25318B1E5B3D9508ABC033007B1D1D14BCBC0755AC7B3A39FA630FC374629A003";
  level.scr_anim["_encstr_B6F40B8D18B3B74D9970991A8A"]["_encstr_963F0B118D6A8040237231D88B"] = % _encstr_BE63316791D658DFB8B99CE76AB0DEBFB0A61CE6DF03A06E9B59B043C8DADFA842C758537FFD43C1E3D337B0C9366E77894813;
  level.scr_animname["_encstr_B6F40B8D18B3B74D9970991A8A"]["_encstr_963F0B118D6A8040237231D88B"] = "_encstr_BE63316791D658DFB8B99CE76AB0DEBFB0A61CE6DF03A06E9B59B043C8DADFA840C758537FFD43C1E3D337B0C9266E77894813";
  level.scr_animtree["_encstr_BD0111A8E1F937972D39DB22281F8F1F115B0F"] = #animtree;
  level.scr_anim["_encstr_BD0111A8E1F937972D39DB22281F8F1F115B0F"]["_encstr_BEEE12EC7D30460F08A0D3FB2EFD133D70DF7646"] = % _encstr_A30220451F599BC8CBA3E9218FBFC8CEF2D3FFFDDBA15DE8E57ED03EF26428830AB3;
  level.scr_animname["_encstr_BD0111A8E1F937972D39DB22281F8F1F115B0F"]["_encstr_BEEE12EC7D30460F08A0D3FB2EFD133D70DF7646"] = "_encstr_A30220451F599BC8CBA3E9218FBFC8CEF2D3FFFDDBA15DE8E57ED03EF26428830AB3";
  level.scr_eventanim["_encstr_BD0111A8E1F937972D39DB22281F8F1F115B0F"]["_encstr_BEEE12EC7D30460F08A0D3FB2EFD133D70DF7646"] = "_encstr_B17E12485F881E39CB3DE76057A20723D2479828";
  level.scr_anim["_encstr_BD0111A8E1F937972D39DB22281F8F1F115B0F"]["_encstr_93EA117B3803D302078B5BD378017A9B68B8E3"] = % _encstr_95B11F9DD6BE34B737A32CB3ACF5C1A5365BAB837DE84EEA6C6DAFC163165EACC9;
  level.scr_animname["_encstr_BD0111A8E1F937972D39DB22281F8F1F115B0F"]["_encstr_93EA117B3803D302078B5BD378017A9B68B8E3"] = "_encstr_95B11F9DD6BE34B737A32CB3ACF5C1A5365BAB837DE84EEA6C6DAFC163165EACC9";
  level.scr_eventanim["_encstr_BD0111A8E1F937972D39DB22281F8F1F115B0F"]["_encstr_93EA117B3803D302078B5BD378017A9B68B8E3"] = "_encstr_924F11EC9607D70EA58D6D5707F5A3C9EAB1D6";
  level.scr_animtree["_encstr_8A6D0C32CA36D0BDBE8E93AB1BDA"] = #animtree;
  level.scr_anim["_encstr_8A6D0C32CA36D0BDBE8E93AB1BDA"]["_encstr_850111232B1B1ADEFAA13B3AF5C14B1B6DABE0"] = % _encstr_8FDE22C3D0153967EB70B0BF7E33377F53717BFA409F6BE3E6CD92BD1EF807478B388212;
  level.scr_animname["_encstr_8A6D0C32CA36D0BDBE8E93AB1BDA"]["_encstr_850111232B1B1ADEFAA13B3AF5C14B1B6DABE0"] = "_encstr_8FDE22C3D0153967EB70B0BF7E33377F53717BFA409F6BE3E6CD92BD1EF807478B388212";
  level.scr_anim["_encstr_8A6D0C32CA36D0BDBE8E93AB1BDA"]["_encstr_912412D0A22E29107F60342D7FBB7B9F52AA5848"] = % _encstr_87CA230701FE31A3385EB47DF330E90ADDDFC38BEF27FA9ED026AB022B703BC12533571B47;
  level.scr_animname["_encstr_8A6D0C32CA36D0BDBE8E93AB1BDA"]["_encstr_912412D0A22E29107F60342D7FBB7B9F52AA5848"] = "_encstr_87CA230701FE31A3385EB47DF330E90ADDDFC38BEF27FA9ED026AB022B703BC12533571B47";
  level.scr_animtree["_encstr_A2780FDF750F4ABF3E782B3FE8905773FB"] = #animtree;
  level.scr_anim["_encstr_A2780FDF750F4ABF3E782B3FE8905773FB"]["_encstr_850111232B1B1ADEFAA13B3AF5C14B1B6DABE0"] = % _encstr_87371EBB88D948EAAEF98F9F3340E3B1D0D0F38266D81A038EFF6F6B2B762AFF;
  level.scr_animname["_encstr_A2780FDF750F4ABF3E782B3FE8905773FB"]["_encstr_850111232B1B1ADEFAA13B3AF5C14B1B6DABE0"] = "_encstr_87371EBB88D948EAAEF98F9F3340E3B1D0D0F38266D81A038EFF6F6B2B762AFF";
  level.scr_anim["_encstr_A2780FDF750F4ABF3E782B3FE8905773FB"]["_encstr_912412D0A22E29107F60342D7FBB7B9F52AA5848"] = % _encstr_8B7E1FD9D6AF43DBDCA385ECB2F58C9CBD1C7B99CCAF474ED56C5BEB3295C61A7B;
  level.scr_animname["_encstr_A2780FDF750F4ABF3E782B3FE8905773FB"]["_encstr_912412D0A22E29107F60342D7FBB7B9F52AA5848"] = "_encstr_8B7E1FD9D6AF43DBDCA385ECB2F58C9CBD1C7B99CCAF474ED56C5BEB3295C61A7B";
}