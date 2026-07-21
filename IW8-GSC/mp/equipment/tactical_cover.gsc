/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\equipment\tactical_cover.gsc
***********************************************/

tac_cover_init() {
  if(!isDefined(level.taccovercollision)) {
    var_0 = getEntArray("_encstr_8F1213711FAAA5E8CBF638561EBF6855D37FD7FF83", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

    if(isDefined(var_0))
      level.taccovercollision = var_0[0];
  }

  level._id_139FF = getEntArray("_encstr_99810FC42E7043CF7571A2BA08AF84C70B", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level._id_139FD = getdvarfloat("_encstr_91DD1D6E8D937D3A586C687BB3ACC9BEA35AB559EDBAD1F4D95693E4B41959", 150.0);
}

tac_cover_on_give(var_0, var_1) {
  self notify("_encstr_8C07100CBB60A90F3043C2BB4E1C1F5BF83D");
}

tac_cover_on_take(var_0, var_1, var_2) {
  self notify("_encstr_A69810FB62FFC070BD1693B5172338928FEA");
  self.taccoverrefund = undefined;
}

tac_cover_used(var_0) {
  waitframe();

  if(isDefined(var_0))
    var_0 delete();
}

tac_cover_on_fired(var_0, var_1, var_2, var_3) {
  self.taccoverrefund = 1;
  var_4 = physics_createcontents(["_encstr_925717EBF99B13491B7BD6DD30508D3AF527CF6349CFFB3DD0", "_encstr_959C16B3A1D35B0178338E95889855C22DEF872707F122C4", "_encstr_8E411B07D05E9B5AB1E6C6B7DCD1ACB947CD7D831B162F599CB136A51C", "_encstr_918816830DBCB9B4C6CDC6B7B98ECAB93ACDAFEE0B1D2B39", "_encstr_BDF91458130AEF44DF883AF28819BF634306EFD33A52", "_encstr_BDD01838A1F2E62DD8371BB79BA3B273A3B97DD956435AB1B1CA"]);
  var_5 = tac_cover_ignore_list(self);
  var_6 = anglesToForward(self.angles);
  var_7 = self.origin + var_6 * 32;
  var_8 = _calloutmarkerping_handleluinotify_brinventoryslotrequest::_id_12F67(var_7, 140, 20);
  var_9 = undefined;
  var_10 = 0;

  if(_id_139EE(var_7)) {
    tac_cover_fire_failed(0);
    return 0;
  }

  if(scripts\cp_mp\auto_ascender::updatesixthsensevo(var_7))
    return 0;

  if(scripts\cp\utility\script::updatespecificfobindanger(var_7))
    return 0;

  var_4 = scripts\engine\trace::init_gas_trap_cloud();
  var_11 = getdvarfloat("_encstr_B840284A025BA850B1075BE17F8133FF3612857D1381307311F5330AEEB0A39651605AC94B9FBBA04737", 32.0);
  var_12 = scripts\engine\trace::sphere_trace_get_all_results(var_7, var_7 + (0, 0, 10), var_11, var_5, var_4, 1);

  foreach(var_14 in var_12) {
    if(isDefined(var_14["_encstr_999F0D032513EF1788D7CC45523773"])) {
      var_15 = 19;
      var_16 = 0;
      var_16 = var_16 | var_14["_encstr_999F0D032513EF1788D7CC45523773"] == 8;
      var_16 = var_16 | var_14["_encstr_999F0D032513EF1788D7CC45523773"] == 2048;
      var_16 = var_16 | var_14["_encstr_999F0D032513EF1788D7CC45523773"] == 9 << var_15;
      var_16 = var_16 | var_14["_encstr_999F0D032513EF1788D7CC45523773"] == 38 << var_15;
      var_16 = var_16 | var_14["_encstr_999F0D032513EF1788D7CC45523773"] == 39 << var_15;

      if(var_16) {
        tac_cover_fire_failed(0);
        return 0;
      }
    }
  }

  foreach(var_19 in var_8) {
    var_20 = distancesquared(var_19.origin, var_7);

    if(isDefined(var_9) && var_10 <= var_20) {
      continue;
    }
    var_9 = var_19;
    var_10 = var_20;
  }

  if(isDefined(var_9)) {
    var_22 = var_9 scriptabledoorangle();
    var_23 = abs(var_22) > 65;
    var_24 = undefined;

    foreach(var_26 in var_8) {
      if(var_9 _calloutmarkerping_handleluinotify_brinventoryslotrequest::_id_12F68(var_26)) {
        var_24 = var_26;
        break;
      }
    }

    var_28 = 1;

    if(isDefined(var_24)) {
      var_29 = var_24 scriptabledoorangle();
      var_28 = abs(var_29) > 65;
    }

    if(var_10 < 1600 && var_23 && var_28) {
      var_30 = _id_139F4(var_9);

      if(isDefined(var_24))
        var_30 = var_30 | _id_139F4(var_24);

      if(!istrue(var_30)) {
        tac_cover_fire_failed(1);
        return 0;
      }

      var_31 = self gettagorigin("_encstr_83890D9CA8EF0B79D830939788913A");
      var_32 = var_9.heli_intro_vo_done + (0, 0, 24);
      var_33 = physics_raycast(var_31, var_32, var_4, var_5, 0, "_encstr_93C411AA834B8BA9A950170FC8A381F1D32870", 1);

      if(isDefined(var_33) && var_33 > 0) {
        tac_cover_fire_failed(1);
        return 0;
      }

      var_9.tutonplayerkilled = 1;
      self.taccoverrefund = undefined;
      thread _id_139F6(var_9, var_24, var_3, var_4);
      scripts\mp\utility\stats::incpersstat("_encstr_86E11446B2C136DE2F0B4CD82B1AEDEC2B93AAB95646", 1);
      return 1;
    } else if(var_10 < 6400) {
      tac_cover_fire_failed(1);
      return 0;
    }
  }

  var_34 = self getplayerangles() * (0, 1, 0);
  var_35 = self.origin + (0, 0, 24);
  var_36 = anglesToForward(var_34);
  var_37 = 29.5;
  var_38 = var_35 + var_36 * var_37;
  var_33 = physics_raycast(var_35, var_38, var_4, var_5, 0, "_encstr_838C158FAC235780CB6F10381FF25AD76A558896473B11", 1);

  if(isDefined(var_33) && var_33.size > 0) {
    tac_cover_fire_failed();
    return 0;
  }

  var_39 = undefined;
  var_40 = undefined;
  var_35 = var_38;
  var_36 = anglestoright(var_34);
  var_37 = 55.5;
  var_41 = var_35 + var_36 * var_37;
  var_33 = physics_spherecast(var_35, var_41, 2.5, var_4, var_5, "_encstr_838C158FAC235780CB6F10381FF25AD76A558896473B11");

  if(isDefined(var_33) && var_33.size > 0) {
    var_42 = var_33[0]["_encstr_8F320F36949A6929DFBB08F0C72C609FD2"];
    var_39 = var_33[0]["_encstr_A53009A25003666B9818C6"];
  } else
    var_39 = 1;

  var_35 = var_38;
  var_36 = -1 * anglestoright(var_34);
  var_37 = 55.5;
  var_41 = var_35 + var_36 * var_37;
  var_33 = physics_spherecast(var_35, var_41, 2.5, var_4, var_5, "_encstr_838C158FAC235780CB6F10381FF25AD76A558896473B11");

  if(isDefined(var_33) && var_33.size > 0) {
    var_42 = var_33[0]["_encstr_8F320F36949A6929DFBB08F0C72C609FD2"];
    var_40 = var_33[0]["_encstr_A53009A25003666B9818C6"];
  } else
    var_40 = 1;

  if(var_40 + var_39 < 1) {
    tac_cover_fire_failed();
    return 0;
  } else if(var_39 < 0.5)
    var_38 = var_38 + var_36 * var_37 * (0.5 - var_39);
  else if(var_40 < 0.5)
    var_38 = var_38 + var_36 * var_37 * (0.5 - var_40) * -1;

  var_43 = var_34;
  var_35 = var_38;
  var_36 = (0, 0, -1);
  var_37 = 60;
  var_41 = var_35 + var_36 * var_37;
  var_44 = combineangles(var_43, (0, 0, 90));
  var_33 = physics_capsulecast(var_35, var_41, 2.5, 16.8, var_44, var_4, var_5, "_encstr_838C158FAC235780CB6F10381FF25AD76A558896473B11");

  if(!isDefined(var_33) || var_33.size <= 0) {
    tac_cover_fire_failed();
    return 0;
  }

  var_45 = var_33[0]["_encstr_850E077B0BF30318B9"];

  if(isDefined(var_45) && !_id_139F0(var_45)) {
    tac_cover_fire_failed();
    return 0;
  }

  var_46 = var_33[0]["_encstr_8F320F36949A6929DFBB08F0C72C609FD2"];
  var_42 = var_33[0]["_encstr_BD260953AA97E3F014279D"];
  var_47 = var_46 - (0, 0, 2.5);
  var_48 = _id_139F2(var_45);
  var_49 = 25.025;
  var_50 = pow(var_49 * 0.14, 2);
  var_51 = var_46;
  var_52 = distance2dsquared(var_51, var_42);
  var_53 = var_46 + anglestoright(var_34) * 14.3 * 1.75;
  var_54 = distance2dsquared(var_53, var_42);
  var_55 = var_46 + anglestoright(var_34) * 14.3 * 1.75 * -1;
  var_56 = distance2dsquared(var_55, var_42);
  var_57 = [];
  var_58 = 0;

  if(var_54 <= var_50 && var_54 < var_52 && var_54 < var_56) {
    var_58++;
    var_57 = [var_51, var_55];
  } else if(var_56 <= var_50 && var_56 < var_52 && var_56 < var_54) {
    var_58++;
    var_57 = [var_51, var_53];
  } else if(var_52 <= var_50) {
    var_58++;
    var_57 = [var_55, var_53];
  } else
    var_57 = [var_51, var_55, var_53];

  var_36 = (0, 0, -1);
  var_37 = 8.5;

  foreach(var_35 in var_57) {
    var_41 = var_35 + var_36 * var_37;
    var_33 = physics_raycast(var_35, var_41, var_4, var_5, 0, "_encstr_838C158FAC235780CB6F10381FF25AD76A558896473B11", 1);

    if(!isDefined(var_33) || var_33.size <= 0) {
      continue;
    }
    var_45 = var_33[0]["_encstr_850E077B0BF30318B9"];

    if(isDefined(var_45) && !_id_139F0(var_45)) {
      tac_cover_fire_failed();
      return 0;
    }

    var_58++;

    if(var_58 >= 2) {
      break;
    }
  }

  if(var_58 < 2) {
    tac_cover_fire_failed();
    return 0;
  }

  self.taccoverrefund = undefined;
  thread tac_cover_spawn(var_47, var_43, var_48, var_3, var_4);
  scripts\mp\utility\stats::incpersstat("_encstr_86E11446B2C136DE2F0B4CD82B1AEDEC2B93AAB95646", 1);
  return 1;
}

_id_139F2(var_0) {
  if(isDefined(var_0)) {
    if(_calloutmarkerping_handleluinotify_enemyrepinged::tugofwar_tank(var_0) || _calloutmarkerping_handleluinotify_enemyrepinged::tryspawnweapons(var_0) || _encstr_B61624E6867B8B5B24873A50F307F1D3D2AFDD6BDAE247681AABB108A76E69176AD678FCF23A::triggereliminatedoverlay(var_0) || _encstr_B43F26C27188711335EFBE4F1170AAB1A819BBC88B5813BE06C5773F070F51FC10A3779228F0DBB2::triggeraddobjectivetext(var_0))
      return var_0;
  }

  return undefined;
}

tac_cover_adjust_for_player_space(var_0, var_1, var_2) {
  var_3 = tac_cover_get_free_space(1, var_0, var_1, var_2, 32);

  if(!isDefined(var_3))
    return var_0;

  var_4 = tac_cover_get_free_space(0, var_0, var_1, var_2, 32);

  if(!isDefined(var_4))
    return var_0;

  var_5 = min(var_3, 15);
  var_6 = anglesToForward(var_1);
  var_7 = var_0 + var_6 * var_5;

  foreach(var_9 in level._id_139FF) {
    if(ispointinvolume(var_7 + (0, 0, 20), var_9)) {
      var_7 = var_7 + (0, 0, -6);
      break;
    }
  }

  return var_7;
}

tac_cover_get_free_space(var_0, var_1, var_2, var_3, var_4) {
  var_5 = anglestoleft(var_2);
  var_6 = anglesToForward(var_2);
  var_7 = -1 * var_6;
  var_8 = undefined;

  if(var_0)
    var_8 = var_6 * var_4;
  else
    var_8 = var_7 * var_4;

  var_9 = var_1 + (0, 0, 48);
  var_10 = var_9;
  var_11 = var_9 + var_8;
  var_12 = 2.5;
  var_13 = 29.0 + var_4;
  var_14 = combineangles(var_2, (0, 0, 90));
  var_3 = var_3;
  var_15 = [self];
  var_16 = "_encstr_838C158FAC235780CB6F10381FF25AD76A558896473B11";
  var_17 = physics_capsulecast(var_10, var_11, var_12, var_13, var_14, var_3, var_15, var_16);
  var_18 = var_17.size == 0;

  if(var_18)
    return undefined;

  var_25 = var_17[0]["_encstr_8F320F36949A6929DFBB08F0C72C609FD2"];
  var_26 = distance(var_25, var_9);
  return var_26;
}

_id_139EE(var_0) {
  if(isDefined(level.turrets)) {
    foreach(var_2 in level.turrets) {
      if(!isDefined(var_2)) {
        continue;
      }
      var_3 = distancesquared(var_2.origin, var_0);

      if(6400 >= var_3)
        return 1;
    }
  }

  if(isDefined(level.arenaflag_showflagoutlineplayer)) {
    foreach(var_2 in level.arenaflag_showflagoutlineplayer) {
      if(!isDefined(var_2)) {
        continue;
      }
      if(6400 >= distancesquared(var_2.origin, var_0))
        return 1;
    }
  }

  return 0;
}

tac_cover_fire_failed(var_0) {
  var_1 = scripts\engine\utility::ter_op(istrue(var_0), "_encstr_8D921EA605E5515068D7349EAC2A497D82C4503451F54A39FA88A7F4297550AC", "_encstr_B6431A67FFFFB151E627568DF3DFEAE00F7EC8D4A7D3D73901E6B603");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF")]](var_1);

  self playsoundtoplayer("_encstr_A56C20FBF7AF80105D22C8A008017841D2EF676F1B82DE01603D119873D7900F4A4B", self);

  if(scripts\mp\equipment::hasequipment("_encstr_867010E842EB0B29AF8B8886074E3F2CB506"))
    scripts\mp\equipment::incrementequipmentammo("_encstr_867010E842EB0B29AF8B8886074E3F2CB506", 1);
}

tac_cover_entmanagerdelete() {
  thread tac_cover_delete(0);
}

_id_139F6(var_0, var_1, var_2, var_3) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_A69810FB62FFC070BD1693B5172338928FEA");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_4 = anglesToForward(self.angles);
  var_5 = var_0.heli_intro + (0, 90, 0);
  var_6 = anglesToForward(var_5);
  var_7 = vectordot(var_4, var_6);
  var_8 = var_7 > 0;
  var_9 = var_0 scriptabledoorangle();
  var_0 _calloutmarkerping_handleluinotify_brinventoryslotrequest::matchslopekey(1, "_encstr_85340FF0D733A68FB2A38516F15ACFE88A");

  if(isDefined(var_1))
    var_1 _calloutmarkerping_handleluinotify_brinventoryslotrequest::matchslopekey(1, "_encstr_85340FF0D733A68FB2A38516F15ACFE88A");

  var_10 = scripts\engine\utility::ter_op(var_8, (0, 90, 0), (0, -90, 0));
  var_11 = (0, 0, -1);
  var_12 = var_0.heli_intro_vo_done + var_11;
  var_13 = combineangles(var_0.heli_intro, var_10);
  var_14 = undefined;
  tac_cover_spawn(var_12, var_13, var_14, var_2, var_3, var_0, var_1);
}

_id_139F4(var_0) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_A69810FB62FFC070BD1693B5172338928FEA");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 = var_0.angles;
  wait 0.05;
  return var_1 == var_0.angles;
}

tac_cover_spawn(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_A69810FB62FFC070BD1693B5172338928FEA");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  wait 0.05;
  var_0 = tac_cover_adjust_for_player_space(var_0, var_1, var_4);
  self notify("_encstr_AACC12E885C6FAD87B9DAC9CEBCD830BEEE65691");
  var_3 = istrue(var_3);
  var_7 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0);
  var_7.angles = var_1;
  var_7.owner = self;
  var_7.team = self.team;
  var_7.slot = scripts\mp\equipment::findequipmentslot("_encstr_867010E842EB0B29AF8B8886074E3F2CB506");
  var_7.exploding = 1;
  var_7.issuper = scripts\engine\utility::ter_op(var_3, 1, undefined);
  var_7.superid = level.superglobals.staticsuperdata["_encstr_923A10D7F32F4262F18BA62E06F8B7AB0D55"].id;
  var_7 scripts\cp_mp\ent_manager::registerspawn(2, ::tac_cover_entmanagerdelete);
  var_7 scripts\mp\sentientpoolmanager::registersentient("_encstr_962E10A2166CE896C6C21BF56A1D0B1DB48D", self);
  var_7 setentityowner(self);
  var_7 setotherent(self);
  var_7 setModel("_encstr_99F71CED66991A0B9B91BE775BBE8CCA38D87B5E161336ACBE6C7B6795E4");

  if(isDefined(var_2)) {
    var_7.moving_platform = var_2;
    var_8 = spawnStruct();
    var_8.linkparent = var_7.moving_platform;
    var_8.deathoverridecallback = ::_id_139F5;
    var_8.validateaccuratetouching = 1;
    var_7 thread scripts\mp\movers::handle_moving_platforms(var_8);
    var_7 thread tac_cover_destroy_on_unstuck();
  }

  var_9 = tac_cover_spawn_collision(var_7);
  var_7 getclosestenemy(var_9, level.taccovercollision);
  var_7.collision = var_9;
  var_9.cover = var_7;

  if(level.gametype == "_encstr_B607038AAB")
    var_7.threatbias = -2000;

  var_9.moverdoesnotkill = 1;

  if(isDefined(var_5)) {
    if(isDefined(var_5.connected_vandalize_node))
      var_5.connected_vandalize_node tac_cover_destroy();

    var_7.concussionused = var_5;
    var_5.connected_vandalize_node = var_7;
  }

  if(isDefined(var_6)) {
    var_7.concusspushstart = var_6;
    var_6.connected_vandalize_node = var_7;
  }

  scripts\mp\weapons::onequipmentplanted(var_7, "_encstr_867010E842EB0B29AF8B8886074E3F2CB506", ::tac_cover_destroy);
  thread scripts\mp\weapons::monitordisownedequipment(self, var_7);

  if(var_3) {
    var_7 thread tac_cover_destroy_on_disowned(self);
    var_7 thread tac_cover_destroy_on_timeout();
  }

  var_7 thread tac_cover_destroy_on_game_end();
  thread tac_cover_spawn_internal(var_7);
  thread scripts\mp\weapons::outlineequipmentforowner(var_7);
  var_7 thread scripts\mp\perks\perk_equipmentping::runequipmentping();
}

tac_cover_spawn_internal(var_0) {
  var_0 endon("_encstr_AD75063D571AE108");

  if(1 && 0)
    var_0 tac_cover_set_can_damage(1);

  if(isDefined(var_0.concussionused))
    var_0 setscriptablepartstate("_encstr_A2CC08B2333395D81D37", "_encstr_A6C60F1C8D85DCD1A9D18539A388DEB7C9", 0);
  else
    var_0 setscriptablepartstate("_encstr_A2CC08B2333395D81D37", "_encstr_99420B38ED637035896B4905E8", 0);

  wait(tac_cover_get_deploy_anim_dur());

  if(1 && !0)
    var_0 tac_cover_set_can_damage(1);

  if(isDefined(var_0.concussionused))
    var_0 setscriptablepartstate("_encstr_A2CC08B2333395D81D37", "_encstr_86260D032D17D613687868FD4F88DB", 0);
  else
    var_0 setscriptablepartstate("_encstr_A2CC08B2333395D81D37", "_encstr_AFD10938D885DC4715CD19", 0);
}

tac_cover_spawn_collision(var_0) {
  if(!isDefined(level.taccovercollision)) {
    return;
  }
  var_1 = var_0.origin + (0, 0, -2);
  var_2 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_1);
  var_2 dontinterpolate();
  var_2.angles = var_0.angles;
  var_2 clonebrushmodeltoscriptmodel(level.taccovercollision);
  var_2 linkTo(var_0);
  var_2 setentityowner(self);

  if(!isDefined(level._id_139FE))
    var_2 disconnectPaths();

  return var_2;
}

_id_139F1(var_0, var_1) {
  var_2 = 100;

  if(!isDefined(var_1))
    var_1 = var_2;

  var_3 = (var_1, var_1, var_1);
  var_4 = var_0 - var_3;
  var_5 = var_0 + var_3;
  var_6 = [];
  var_7 = physics_createcontents(["_encstr_A9D615B373CA8B4BDEFABEFFE0EB656594733F2BF3DBD3"]);
  var_8 = physics_aabbbroadphasequery(var_4, var_5, var_7, var_6);

  for(var_9 = 0; var_9 < var_8.size; var_9++) {
    var_10 = var_8[var_9];

    if(isDefined(var_10.equipmentref)) {
      if(var_10.equipmentref == "_encstr_867010E842EB0B29AF8B8886074E3F2CB506") {
        var_10 tac_cover_destroy(undefined, 1);
        var_10._id_11B0D = 1;
        continue;
      }
    }
  }
}

tac_cover_destroy(var_0, var_1, var_2) {
  var_3 = 0;

  if(!istrue(var_1))
    var_3 = 0.2 + tac_cover_get_destroy_anim_dur();

  var_4 = self.maxhealth;

  if(isDefined(self.damagetaken) && self.damagetaken < self.maxhealth)
    var_4 = self.damagetaken;

  if(!isDefined(var_4))
    var_4 = 1250;

  self.owner scripts\cp\vehicles\vehicle_compass_cp::_id_12032("_encstr_923A10D7F32F4262F18BA62E06F8B7AB0D55", int(var_4), var_0, var_2);
  scripts\mp\analyticslog::logevent_fieldupgradeexpired(self.owner, self.superid, int(var_4), istrue(var_2));
  thread tac_cover_destroy_internal(var_3);
  thread tac_cover_delete(var_3);
}

tac_cover_destroy_internal(var_0) {
  if(isDefined(self.concussionused)) {
    self.concussionused _calloutmarkerping_handleluinotify_brinventoryslotrequest::matchslopekey(0, "_encstr_85340FF0D733A68FB2A38516F15ACFE88A");
    self.concussionused.connected_vandalize_node = undefined;
  }

  if(isDefined(self.concusspushstart)) {
    self.concusspushstart _calloutmarkerping_handleluinotify_brinventoryslotrequest::matchslopekey(0, "_encstr_85340FF0D733A68FB2A38516F15ACFE88A");
    self.concusspushstart.connected_vandalize_node = undefined;
  }

  if(var_0 > 0) {
    self setscriptablepartstate("_encstr_A2CC08B2333395D81D37", "_encstr_B2E30D23569BE84EEDF24DE885393A");
    wait(tac_cover_get_destroy_anim_dur());
    self setscriptablepartstate("_encstr_A2CC08B2333395D81D37", "_encstr_87B80B815763B02EEAC7A3EDAB");
  }

  if(isDefined(self.collision)) {
    self.collision connectpaths();
    self.collision delete();
  }
}

tac_cover_delete(var_0) {
  self notify("_encstr_AD75063D571AE108");
  level.mines[self getentitynumber()] = undefined;
  var_1 = self.owner;

  if(isDefined(var_1))
    var_1 scripts\mp\weapons::removeequip(self);

  if(1) {
    scripts\mp\damage::monitordamageend();
    self thermaldrawdisable();
  }

  if(isDefined(self.collision)) {
    self.collision connectpaths();
    self.collision delete();
  }

  wait(var_0);
  self delete();
}

tac_cover_destroy_on_timeout() {
  self endon("_encstr_AD75063D571AE108");
  wait(level._id_139FD);
  tac_cover_destroy(undefined, 0);
}

tac_cover_destroy_on_game_end() {
  self endon("_encstr_AD75063D571AE108");
  level waittill("_encstr_9B1D0BC7932875276230426AA1");
  tac_cover_destroy(undefined, 0);
}

tac_cover_destroy_on_unstuck() {
  self endon("_encstr_AD75063D571AE108");

  while(isDefined(self getlinkedparent()))
    waitframe();

  tac_cover_destroy(undefined, 0);
}

tac_cover_set_can_damage(var_0) {
  if(1) {
    if(var_0) {
      var_1 = scripts\mp\utility\perk::_hasperk("_encstr_AA14156E0795B14B0B1BA35EAF27ABD99DCA91AF95B80E");
      var_2 = scripts\engine\utility::ter_op(var_1, 1250, 1000);
      var_3 = "_encstr_A2FB098A2035874AB0F358";
      thread scripts\mp\damage::monitordamage(var_2, var_3, ::tac_cover_handle_fatal_damage, ::tac_cover_handle_damage, 0);
      self thermaldrawenable();
    } else {
      scripts\mp\damage::monitordamageend();
      self thermaldrawdisable();
    }
  }
}

tac_cover_handle_damage(var_0) {
  var_1 = _id_139ED(var_0);

  if(isDefined(self.owner)) {
    var_2 = max(self.maxhealth - self.damagetaken, 0);
    var_3 = int(min(var_2, var_1));
    self.owner scripts\mp\supers::hide_plunderboxes("_encstr_923A10D7F32F4262F18BA62E06F8B7AB0D55", var_3);
  }

  return var_1;
}

_id_139ED(var_0) {
  var_1 = var_0.attacker;
  var_2 = var_0.objweapon;
  var_3 = var_0.meansofdeath;
  var_4 = var_0.damage;
  var_5 = var_0.point;

  if(var_2.basename == "_encstr_B29B0FE0E32573E3A23395B04E6BBF5898")
    return 200.0;

  if(scripts\mp\damage::usefaillaststandmsg(var_0.objweapon))
    return 0;

  if(var_2.basename == "_encstr_8E3B11F9785798B1A7BB5906C267F96061C579")
    return 83.3333;

  if(var_2.basename == "_encstr_B45E1514B148FADFDBFB2A718221077490ABE8D1476002")
    return 62.5;

  if(var_3 == "_encstr_8DED0A21C79B660BC7588981" || var_3 == "_encstr_A1ED0BA9FF84562B60BA073E83") {
    if(var_3 == "_encstr_A1ED0BA9FF84562B60BA073E83" && var_2.classname == "_encstr_8C8D08671D451291C849")
      return var_4;

    return 333.333;
  }

  if(scripts\mp\utility\weapon::isthrowingknife(var_2.basename))
    return 0;

  if(var_2.basename == "_encstr_88AC1394CB88B917A8A797F32F539A05376FD02DD3" && var_3 != "_encstr_8DED0A21C79B660BC7588981")
    return 0;

  if(var_3 == "_encstr_8D4E0A501FCB898912CB3FA3" && isDefined(var_0.inflictor) && var_0.inflictor.classname == "_encstr_86440FCD8D9CD2833AFA3B2B34B4D81B56") {
    if(isDefined(var_1) && !scripts\mp\weapons::friendlyfirecheck(self.owner, var_1))
      return var_4;
  }

  if(isexplosivedamagemod(var_0.meansofdeath)) {
    if(var_2.basename == "_encstr_8B9E13779010B4923960C8855327AA3913EA4FF7D0")
      return 333.333;

    return 700.0;
  }

  var_4 = scripts\mp\damage::handleapdamage(var_2, var_3, var_4);
  var_4 = scripts\mp\damage::handleshotgundamage(var_2, var_3, var_4);
  return var_4;
}

tac_cover_handle_fatal_damage(var_0) {
  var_1 = var_0.attacker;

  if(istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, var_1))) {
    var_1 notify("_encstr_85BB142A408F7BABB0EB352C9099EF43C38022B2A029");
    var_1 thread scripts\mp\utility\points::giveunifiedpoints("_encstr_85BB142A408F7BABB0EB352C9099EF43C38022B2A029");
    var_1 thread scripts\mp\battlechatter_mp::equipmentdestroyed(self);
  }

  thread tac_cover_destroy(var_1, undefined, 1);
}

tac_cover_deploy_freeze_controls() {
  if(!isDefined(self.taccoverfrozecontrols)) {
    var_0 = scripts\mp\equipment::findequipmentslot("_encstr_867010E842EB0B29AF8B8886074E3F2CB506");
    scripts\mp\equipment::allow_equipment_slot(var_0, 0, "_encstr_867010E842EB0B29AF8B8886074E3F2CB506");
    scripts\common\utility::allow_usability(0);
    scripts\mp\utility\player::allow_gesture(0);
    self.taccoverfrozecontrols = var_0;
  }
}

tac_cover_deploy_unfreeze_controls() {
  if(isDefined(self.taccoverfrozecontrols)) {
    var_0 = self.taccoverfrozecontrols;
    scripts\mp\equipment::allow_equipment_slot(var_0, 1, "_encstr_867010E842EB0B29AF8B8886074E3F2CB506");
    scripts\common\utility::allow_usability(1);
    scripts\mp\utility\player::allow_gesture(1);
    self.taccoverfrozecontrols = undefined;
  }
}

tac_cover_ignore_list(var_0) {
  var_1 = [var_0];

  if(isDefined(level.grenades)) {
    foreach(var_3 in level.grenades) {
      if(isDefined(var_3))
        var_1[var_1.size] = var_3;
    }
  }

  if(isDefined(level.missiles)) {
    foreach(var_6 in level.missiles) {
      if(isDefined(var_6))
        var_1[var_1.size] = var_6;
    }
  }

  if(isDefined(level.mines)) {
    foreach(var_9 in level.mines) {
      if(!isDefined(var_9)) {
        continue;
      }
      var_10 = isDefined(var_9.owner) && var_9.owner == var_0;
      var_11 = isDefined(var_9.equipmentref) && var_9.equipmentref == "_encstr_867010E842EB0B29AF8B8886074E3F2CB506";
      var_12 = isDefined(var_9.equipmentref) && var_9.equipmentref == "_encstr_B6820FFA831517AA4103A5BD071976473B";

      if(!var_10 && (var_11 || var_12)) {
        continue;
      }
      var_1[var_1.size] = var_9;

      if(isDefined(var_9.collision))
        var_1[var_1.size] = var_9.collision;
    }
  }

  return var_1;
}

_id_139F0(var_0) {
  if(isPlayer(var_0))
    return 0;

  if(var_0 getnonstick())
    return 0;

  if(istrue(var_0.mountmantlemodel))
    return 0;

  if(isDefined(var_0.cover) && isDefined(var_0.cover.equipmentref) && var_0.cover.equipmentref == "_encstr_867010E842EB0B29AF8B8886074E3F2CB506")
    return 0;

  if(var_0.classname == "_encstr_97710C6B2DCD1BAF3AD54E4E598E")
    return 0;

  if(var_0.classname == "_encstr_86440FCD8D9CD2833AFA3B2B34B4D81B56")
    return 0;

  return 1;
}

#using_animtree("_encstr_A5CF0C3B8E2A106723EFB5A117BB");

tac_cover_get_deploy_anim_dur() {
  return getanimlength(%_encstr_B60D1BBB0D0778ED63DBAF8B07AAA188EF662013B772E9156A93B15F7F);
}

tac_cover_get_destroy_anim_dur() {
  return 0;
}

tac_cover_on_fired_super() {
  return tac_cover_on_fired(undefined, undefined, undefined, 1);
}

tac_cover_on_take_super() {
  tac_cover_on_take(undefined, undefined, 1);
}

tac_cover_destroy_on_disowned(var_0) {
  self endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_A69810FB62FFC070BD1693B5172338928FEA");
  var_0 scripts\engine\utility::_id_143A5("_encstr_81170C244F9CBDE72C01BB99A298", "_encstr_8D820B49520F0EC02DDE6367EC");
  thread tac_cover_destroy(undefined, undefined, 0);
}

_id_139F5(var_0) {
  tac_cover_destroy(var_0.attacker, undefined, 0);
}