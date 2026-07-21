/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\powers\cp_tactical_cover.gsc
***********************************************/

tac_cover_init() {
  if(!isDefined(level.taccovercollision)) {
    var_0 = getEntArray("_encstr_8F1213711FAAA5E8CBF638561EBF6855D37FD7FF83", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

    if(isDefined(var_0))
      level.taccovercollision = var_0[0];
  }
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

  foreach(var_2 in self.offhandinventory) {
    if(isDefined(var_2.basename) && var_2.basename == "_encstr_B80E0DD3FF027E48DD5E7582AF27A8")
      self takeweapon("_encstr_B80E0DD3FF027E48DD5E7582AF27A8");
  }

  if(isDefined(self._id_12879)) {
    self switchtoweapon(self._id_12879);
    self._id_12879 = undefined;
  }

  if(isDefined(var_0))
    var_0 delete();
}

tac_cover_on_fired(var_0, var_1, var_2, var_3) {
  self.taccoverrefund = 1;
  var_4 = physics_createcontents(["_encstr_925717EBF99B13491B7BD6DD30508D3AF527CF6349CFFB3DD0", "_encstr_959C16B3A1D35B0178338E95889855C22DEF872707F122C4", "_encstr_8E411B07D05E9B5AB1E6C6B7DCD1ACB947CD7D831B162F599CB136A51C", "_encstr_918816830DBCB9B4C6CDC6B7B98ECAB93ACDAFEE0B1D2B39", "_encstr_BDF91458130AEF44DF883AF28819BF634306EFD33A52", "_encstr_BDD01838A1F2E62DD8371BB79BA3B273A3B97DD956435AB1B1CA"]);
  var_5 = anglesToForward(self.angles);
  var_6 = self.origin + var_5 * 32;
  var_7 = _calloutmarkerping_handleluinotify_brinventoryslotrequest::_id_12F67(var_6, 140, 20);
  var_8 = undefined;
  var_9 = 0;

  foreach(var_11 in var_7) {
    var_12 = distancesquared(var_11.origin, var_6);

    if(isDefined(var_8) && var_9 <= var_12) {
      continue;
    }
    var_8 = var_11;
    var_9 = var_12;
  }

  if(isDefined(var_8)) {
    var_14 = var_8 scriptabledoorangle();
    var_15 = abs(var_14) > 65;
    var_16 = undefined;

    foreach(var_18 in var_7) {
      if(var_8 _calloutmarkerping_handleluinotify_brinventoryslotrequest::_id_12F68(var_18)) {
        var_16 = var_18;
        break;
      }
    }

    var_20 = 1;

    if(isDefined(var_16)) {
      var_21 = var_16 scriptabledoorangle();
      var_20 = abs(var_21) > 65;
    }

    if(var_9 < 1600 && var_15 && var_20) {
      var_8.tutonplayerkilled = 1;
      self.taccoverrefund = undefined;
      thread _id_139F6(var_8, var_16, var_3, var_4);

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_A5580B6C43B0B163CA9BB395CD", "_encstr_A18C12DEE6325A59B18C550EB393B032598ACDC8"))
        self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_A5580B6C43B0B163CA9BB395CD", "_encstr_A18C12DEE6325A59B18C550EB393B032598ACDC8")]]("_encstr_923A10D7F32F4262F18BA62E06F8B7AB0D55", 1);

      scripts\cp\agents\agents::incpersstat("_encstr_86E11446B2C136DE2F0B4CD82B1AEDEC2B93AAB95646", 1);
      return 1;
    } else if(var_9 < 6400) {
      tac_cover_fire_failed(1);
      return 0;
    }
  }

  var_22 = tac_cover_ignore_list(self);
  var_23 = self getplayerangles() * (0, 1, 0);
  var_24 = self.origin + (0, 0, 24);
  var_25 = anglesToForward(var_23);
  var_26 = 29.5;
  var_27 = var_24 + var_25 * var_26;
  var_28 = physics_raycast(var_24, var_27, var_4, var_22, 0, "_encstr_838C158FAC235780CB6F10381FF25AD76A558896473B11", 1);

  if(isDefined(var_28) && var_28.size > 0) {
    tac_cover_fire_failed();
    return 0;
  }

  var_29 = undefined;
  var_30 = undefined;
  var_24 = var_27;
  var_25 = anglestoright(var_23);
  var_26 = 55.5;
  var_31 = var_24 + var_25 * var_26;
  var_28 = physics_spherecast(var_24, var_31, 2.5, var_4, var_22, "_encstr_838C158FAC235780CB6F10381FF25AD76A558896473B11");

  if(isDefined(var_28) && var_28.size > 0) {
    var_32 = var_28[0]["_encstr_8F320F36949A6929DFBB08F0C72C609FD2"];
    var_29 = var_28[0]["_encstr_A53009A25003666B9818C6"];
  } else
    var_29 = 1;

  var_24 = var_27;
  var_25 = -1 * anglestoright(var_23);
  var_26 = 55.5;
  var_31 = var_24 + var_25 * var_26;
  var_28 = physics_spherecast(var_24, var_31, 2.5, var_4, var_22, "_encstr_838C158FAC235780CB6F10381FF25AD76A558896473B11");

  if(isDefined(var_28) && var_28.size > 0) {
    var_32 = var_28[0]["_encstr_8F320F36949A6929DFBB08F0C72C609FD2"];
    var_30 = var_28[0]["_encstr_A53009A25003666B9818C6"];
  } else
    var_30 = 1;

  if(var_30 + var_29 < 1) {
    tac_cover_fire_failed();
    return 0;
  } else if(var_29 < 0.5)
    var_27 = var_27 + var_25 * var_26 * (0.5 - var_29);
  else if(var_30 < 0.5)
    var_27 = var_27 + var_25 * var_26 * (0.5 - var_30) * -1;

  var_33 = var_23;
  var_24 = var_27;
  var_25 = (0, 0, -1);
  var_26 = 60;
  var_31 = var_24 + var_25 * var_26;
  var_34 = combineangles(var_33, (0, 0, 90));
  var_28 = physics_capsulecast(var_24, var_31, 2.5, 16.8, var_34, var_4, var_22, "_encstr_838C158FAC235780CB6F10381FF25AD76A558896473B11");

  if(!isDefined(var_28) || var_28.size <= 0) {
    tac_cover_fire_failed();
    return 0;
  }

  var_35 = var_28[0]["_encstr_850E077B0BF30318B9"];

  if(isDefined(var_35) && !_id_139F0(var_35)) {
    tac_cover_fire_failed();
    return 0;
  }

  var_36 = var_28[0]["_encstr_8F320F36949A6929DFBB08F0C72C609FD2"];
  var_32 = var_28[0]["_encstr_BD260953AA97E3F014279D"];
  var_37 = var_36 - (0, 0, 2.5);
  var_38 = 25.025;
  var_39 = pow(var_38 * 0.14, 2);
  var_40 = var_36;
  var_41 = distance2dsquared(var_40, var_32);
  var_42 = var_36 + anglestoright(var_23) * 14.3 * 1.75;
  var_43 = distance2dsquared(var_42, var_32);
  var_44 = var_36 + anglestoright(var_23) * 14.3 * 1.75 * -1;
  var_45 = distance2dsquared(var_44, var_32);
  var_46 = [];
  var_47 = 0;

  if(var_43 <= var_39 && var_43 < var_41 && var_43 < var_45) {
    var_47++;
    var_46 = [var_40, var_44];
  } else if(var_45 <= var_39 && var_45 < var_41 && var_45 < var_43) {
    var_47++;
    var_46 = [var_40, var_42];
  } else if(var_41 <= var_39) {
    var_47++;
    var_46 = [var_44, var_42];
  } else
    var_46 = [var_40, var_44, var_42];

  var_25 = (0, 0, -1);
  var_26 = 8.5;

  foreach(var_24 in var_46) {
    var_31 = var_24 + var_25 * var_26;
    var_28 = physics_raycast(var_24, var_31, var_4, var_22, 0, "_encstr_838C158FAC235780CB6F10381FF25AD76A558896473B11", 1);

    if(!isDefined(var_28) || var_28.size <= 0) {
      continue;
    }
    var_35 = var_28[0]["_encstr_850E077B0BF30318B9"];

    if(isDefined(var_35) && !_id_139F0(var_35)) {
      tac_cover_fire_failed();
      return 0;
    }

    var_47++;

    if(var_47 >= 2) {
      break;
    }
  }

  if(var_47 < 2) {
    tac_cover_fire_failed();
    return 0;
  }

  self.taccoverrefund = undefined;
  thread tac_cover_spawn(var_37, var_33, undefined, var_3, var_4);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_A5580B6C43B0B163CA9BB395CD", "_encstr_A18C12DEE6325A59B18C550EB393B032598ACDC8"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_A5580B6C43B0B163CA9BB395CD", "_encstr_A18C12DEE6325A59B18C550EB393B032598ACDC8")]]("_encstr_923A10D7F32F4262F18BA62E06F8B7AB0D55", 1);

  scripts\cp\agents\agents::incpersstat("_encstr_86E11446B2C136DE2F0B4CD82B1AEDEC2B93AAB95646", 1);
  return 1;
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

tac_cover_fire_failed(var_0) {
  var_1 = scripts\engine\utility::ter_op(istrue(var_0), "_encstr_8D921EA605E5515068D7349EAC2A497D82C4503451F54A39FA88A7F4297550AC", "_encstr_B6431A67FFFFB151E627568DF3DFEAE00F7EC8D4A7D3D73901E6B603");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF")]](var_1);

  if(soundexists("_encstr_A56C20FBF7AF80105D22C8A008017841D2EF676F1B82DE01603D119873D7900F4A4B"))
    self playsoundtoplayer("_encstr_A56C20FBF7AF80105D22C8A008017841D2EF676F1B82DE01603D119873D7900F4A4B", self);
}

_id_139F3() {
  if(self hasweapon("_encstr_B80E0DD3FF027E48DD5E7582AF27A8"))
    self takeweapon("_encstr_B80E0DD3FF027E48DD5E7582AF27A8");

  var_0 = scripts\cp\loot_system::get_empty_munition_slot(self);

  if(isDefined(var_0))
    scripts\cp\cp_munitions::give_munition_to_slot("_encstr_A6E3114659E036BD97B026B1CABE6CBD9D59C9", var_0);
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
  var_0 scriptabledoorfreeze(1);

  if(isDefined(var_1))
    var_1 scriptabledoorfreeze(1);

  var_10 = scripts\engine\utility::ter_op(var_8, (0, 90, 0), (0, -90, 0));
  var_11 = (0, 0, -1);
  var_12 = var_0.heli_intro_vo_done + var_11;
  var_13 = combineangles(var_0.heli_intro, var_10);
  var_14 = undefined;
  tac_cover_spawn(var_12, var_13, var_14, var_2, var_3, var_0, var_1);
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
  var_7.slot = "_encstr_BA7F0830B3A7859B60B0";
  var_7.exploding = 1;
  var_7.issuper = scripts\engine\utility::ter_op(var_3, 1, undefined);
  var_7 scripts\cp\utility::make_entity_sentient_cp(var_7.owner.team);
  var_7 setentityowner(self);
  var_7 setotherent(self);
  var_7 setModel("_encstr_99F71CED66991A0B9B91BE775BBE8CCA38D87B5E161336ACBE6C7B6795E4");
  var_7.equipmentref = "_encstr_867010E842EB0B29AF8B8886074E3F2CB506";

  if(isDefined(var_2)) {
    var_7 linkTo(var_2);
    var_7 thread tac_cover_destroy_on_unstuck();
  }

  var_8 = tac_cover_spawn_collision(var_7);
  var_7 getclosestenemy(var_8, level.taccovercollision);
  var_7.collision = var_8;
  var_8.cover = var_7;
  var_8.moverdoesnotkill = 1;

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

  var_7.streakinfo = scripts\cp_mp\utility\killstreak_utility::createstreakinfo("_encstr_BA630AEC27F9EF5657302A53", var_7.owner);

  if(isDefined(self.taccovers) && self.taccovers.size + 1 > 2) {
    var_9 = self.taccovers.size + 1 - 2;
    var_10 = self.taccovers;

    for(var_11 = 0; var_11 < var_9; var_11++)
      var_12 = var_10[var_11];
  }

  thread scripts\cp\cp_weapon::monitordisownedequipment(self, var_7);
  var_7 tac_cover_add_to_list(self);

  if(var_3) {
    var_7 thread tac_cover_destroy_on_disowned(self);
    var_7 thread tac_cover_destroy_on_timeout();
  }

  var_7 thread tac_cover_destroy_on_game_end();
  thread tac_cover_spawn_internal(var_7);
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
  var_1 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0.origin);
  var_1 dontinterpolate();
  var_1.angles = var_0.angles;
  var_1 clonebrushmodeltoscriptmodel(level.taccovercollision);
  var_1 linkTo(var_0);
  var_1 setentityowner(self);
  var_1 disconnectPaths();
  return var_1;
}

tac_cover_destroy(var_0, var_1) {
  var_2 = 0;

  if(!istrue(var_0))
    var_2 = 0.2 + tac_cover_get_destroy_anim_dur();

  var_3 = self.maxhealth;

  if(isDefined(self.damagetaken) && self.damagetaken < self.maxhealth)
    var_3 = self.damagetaken;

  self.owner scripts\cp_mp\utility\killstreak_utility::_id_12AA7(self.streakinfo);
  thread tac_cover_destroy_internal(var_2);
  thread tac_cover_delete(var_2);
}

tac_cover_destroy_internal(var_0) {
  if(isDefined(self.concussionused)) {
    self.concussionused scriptabledoorfreeze(0);
    self.concussionused.connected_vandalize_node = undefined;
  }

  if(isDefined(self.concusspushstart)) {
    self.concusspushstart scriptabledoorfreeze(0);
    self.concusspushstart.connected_vandalize_node = undefined;
  }

  if(var_0 > 0) {
    self setscriptablepartstate("_encstr_A2CC08B2333395D81D37", "_encstr_B2E30D23569BE84EEDF24DE885393A");
    wait(tac_cover_get_destroy_anim_dur());
    self setscriptablepartstate("_encstr_A2CC08B2333395D81D37", "_encstr_87B80B815763B02EEAC7A3EDAB");
  }

  if(isDefined(self.collision))
    self.collision delete();
}

tac_cover_delete(var_0) {
  self notify("_encstr_AD75063D571AE108");
  level.mines[self getentitynumber()] = undefined;
  var_1 = self.owner;

  if(1)
    self thermaldrawdisable();

  if(isDefined(self.collision))
    self.collision delete();

  wait(var_0);
  self delete();
}

tac_cover_destroy_on_timeout() {
  self endon("_encstr_AD75063D571AE108");
  wait 150;
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
      var_1 = scripts\cp\utility::_hasperk("_encstr_AA14156E0795B14B0B1BA35EAF27ABD99DCA91AF95B80E");
      var_2 = scripts\engine\utility::ter_op(var_1, 1250, 1000);
      var_3 = "_encstr_A2FB098A2035874AB0F358";
      thread scripts\cp\cp_weapon::monitordamage(var_2, var_3, ::tac_cover_handle_fatal_damage, ::tac_cover_handle_damage, 0);
      self thermaldrawenable();
    } else
      self thermaldrawdisable();
  }
}

tac_cover_handle_damage(var_0) {
  var_1 = var_0.attacker;
  var_2 = var_0.objweapon;
  var_3 = var_0.meansofdeath;
  var_4 = var_0.damage;
  var_5 = var_0.point;

  if(!isDefined(var_2))
    return var_4;

  if(var_2.basename == "_encstr_B29B0FE0E32573E3A23395B04E6BBF5898")
    return 200.0;

  if(var_2.basename == "_encstr_8AF511A30D4EDEDDB4CDB35BE6A5CC2BFA5B83")
    return 0;

  if(var_2.basename == "_encstr_88AC1394CB88B917A8A797F32F539A05376FD02DD3")
    return 0;

  if(var_3 == "_encstr_A1ED0BA9FF84562B60BA073E83" && var_2.classname == "_encstr_8C8D08671D451291C849")
    return var_4;

  if(var_3 == "_encstr_8D4E0A501FCB898912CB3FA3" && isDefined(var_0.inflictor) && var_0.inflictor.classname == "_encstr_86440FCD8D9CD2833AFA3B2B34B4D81B56") {
    if(isDefined(var_1) && !scripts\cp\cp_damage::friendlyfirecheck(self.owner, var_1)) {
      if(isDefined(var_0.inflictor.vehiclename) && _id_139EF(var_0.inflictor.vehiclename))
        return var_4;
      else
        return 0;
    }
  }

  if(isexplosivedamagemod(var_0.meansofdeath))
    return 700.0;

  if(var_3 == "_encstr_8DED0A21C79B660BC7588981" || var_3 == "_encstr_A1ED0BA9FF84562B60BA073E83")
    var_4 = 333.333;

  if(isDefined(var_1) && isDefined(self.owner) && var_1 == self.owner)
    var_4 = var_4 * 1;

  return var_4;
}

tac_cover_handle_fatal_damage(var_0) {
  var_1 = var_0.attacker;

  if(istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, var_1))) {
    if(isPlayer(var_1)) {
      var_1 thread scripts\cp\agents\gametype_cp_wave_sv::giveunifiedpoints("_encstr_85BB142A408F7BABB0EB352C9099EF43C38022B2A029");
      var_1 thread scripts\cp\cp_player_battlechatter::equipmentdestroyed(self);
    }

    var_1 notify("_encstr_85BB142A408F7BABB0EB352C9099EF43C38022B2A029");
  }

  thread tac_cover_destroy(undefined, 1);
}

_id_139EF(var_0) {
  switch (var_0) {
    case "_encstr_AF390B295782C3585F1B21D8C4":
    case "_encstr_86510C82737817CD40B38B720A15":
      return 1;
    default:
      break;
  }

  return 0;
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
  thread tac_cover_destroy(undefined, 0);
}

tac_cover_add_to_list(var_0) {
  if(!isDefined(var_0.taccovers))
    var_0.taccovers = [];

  var_0.taccovers[var_0.taccovers.size] = self;

  if(!isDefined(level.taccovers))
    level.taccovers = [];

  var_1 = self getentitynumber();
  level.taccovers[var_1] = self;
}

tac_cover_remove_from_list(var_0, var_1) {
  if(isDefined(var_0.taccovers)) {
    var_2 = [];

    foreach(var_4 in var_0.taccovers) {
      if(isDefined(var_4) && var_4 != self)
        var_2[var_2.size] = var_4;
    }

    var_0.taccovers = var_2;
  }

  if(isDefined(level.taccovers))
    level.taccovers[var_1] = undefined;
}

ricochet_bullet(var_0, var_1, var_2, var_3) {
  var_4 = scripts\engine\math::vector_reflect(var_0, var_1);
  magicbullet(var_3, var_2 + var_0 * 10, var_2 + var_0 * 10 + var_4);
}