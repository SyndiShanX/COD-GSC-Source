/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: opaque\58255.gsc
***********************************************/

playertimestamp() {
  playertimestart();
  playertospectate();
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_B8B61C83D8EACD8CCA93D7B2F0D14EC2363AD7CC162DB1FA335DD847EDB9"] = "_encstr_B1EE2499824B48A0F7FBA759220BB87FE35DC95F38246E4399348F0637499C27D3FDB8F837CD";
  level._effect["_encstr_A2DF13DB1021F1200DCACB0A35575DF8DB435F109F"] = loadfx("_encstr_A1C5321C4ECBC8E3EBBFB9587395A75937F5A799A137E51597A3C1404B517B50639DAB983EAF10293DEAC978D272314B8A16BC83");
}

#using_animtree("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");

playertimestart() {
  level.scr_animtree["_encstr_BA8E0766EA368EDE9B"] = #animtree;
  level.scr_anim["_encstr_BA8E0766EA368EDE9B"]["_encstr_8D800C09937385C02DEF7741FD15"] = % _encstr_86021727901673B2FB3BCDC5928F4A3AB8C8CB136948C89A3D;
  level.scr_animname["_encstr_BA8E0766EA368EDE9B"]["_encstr_8D800C09937385C02DEF7741FD15"] = "_encstr_86021727901673B2FB3BCDC5928F4A3AB8C8CB136948C89A3D";
  level.scr_anim["_encstr_BA8E0766EA368EDE9B"]["_encstr_8F2511900D551107684E881B88F5171A628135"] = % _encstr_BD011CAF613E1F143B804A42F01F4F4390D50E34902D8B1D3B2132ABB8A5;
  level.scr_animname["_encstr_BA8E0766EA368EDE9B"]["_encstr_8F2511900D551107684E881B88F5171A628135"] = "_encstr_BD011CAF613E1F143B804A42F01F4F4390D50E34902D8B1D3B2132ABB8A5";
  level.scr_anim["_encstr_BA8E0766EA368EDE9B"]["_encstr_AA150FCC57B13A7B73D7A358B5567B9999"] = % _encstr_8A9A1A4CC7D120907FB8D7A8AA4F07222D6D02E3B1033F934B8FA3EC;
  level.scr_animname["_encstr_BA8E0766EA368EDE9B"]["_encstr_AA150FCC57B13A7B73D7A358B5567B9999"] = "_encstr_8A9A1A4CC7D120907FB8D7A8AA4F07222D6D02E3B1033F934B8FA3EC";
}

playertospectate() {
  var_0 = _encstr_9186249B6C39B438E8CD5EB6C1E5CE85B6953AF283599B9789C9AF83D8BAE69159E41776DC8D::_id_1278C("_encstr_961F1027C76B12F866F85BDF981BAC8B07D0", 1);
  var_0.type = 0;
  var_0.usetime = getdvarfloat("_encstr_B60C123B8E2AA16C33DB99A73BD92E88E4E46071", 0.75);
  var_0._id_14077 = 2;
  var_0._id_14075 = getdvarint("_encstr_A75B142EFB53766DFB6A10C0229B3F49F76DB8A55E93", 250);
  var_0._id_13ACC = 1;
  var_0._id_13AA5 = 1;
  var_0._id_14078 = "_encstr_B20D243B296FCE6E5579900508E5BDA19CFFD1E9F1F50D2609195B7331115755606F3D8DC1EC";
  var_0._id_14079 = "_encstr_9185276A0A97A1A09C399E2A7D888A41A74DA4A8FAD00AA9217D210A9826F43D93BE2654505994E48E";
  var_0._id_12F7D = "_encstr_B4A611709BF80DD00BD915C33580C83AB08241";
  var_0._id_12F7E = "_encstr_8E8607AB603B6E4341";
  var_0._id_12F77 = "_encstr_ADB209DDA0A3209B828060";
  var_0.origin_delta = getdvarint("_encstr_8E5514D07AD2EF998F0C5DD8168F60733DF3E0A8936D", 20);
  var_0.original_disablelongdeath = "_encstr_956E1D0BD3663691F3B446FDEE84B17818C3B7813F286429365F4E9445AF79";
  var_0.get_closest_enemy_near_turret = getdvarint("_encstr_8D7E13ABF20B1088EBDC417FF65E884FEF6A60B3BB", 1500);
  var_0.impactwatcher = ::playerupdatebesttimehud;
  var_0.org_in_bad_place = ::playerupdatehudstate;
  var_0.carriable_error_messsage_watch = ::playerupdatealivecounthuman;
  var_0.outline_enemy_ai_for_duration = "_encstr_BA8E0766EA368EDE9B";
  var_0.dropplunder = getdvarint("_encstr_A3D81637B14EBECC57D88EEDE688937B384163ABDC23569C", 1) > 0;
  var_0.get_chopper_boss_combat_action = getdvarint("_encstr_8A7A18D6AFD09030AB504847D2E65F4573B1AAE12BF6FD4FEF58", 1) > 0;
}

playersusing(var_0) {
  var_1 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0.origin);
  var_1 getuseholdkbmprofile(1);
  var_1 setModel("_encstr_86591C719C021333D97B605957FBAAA99A85FA90B70AED1E8D0B4980235B");
  var_1.angles = var_0.angles;
  var_1.owner = self;
  var_1.team = self.team;

  if(isDefined(var_0.moving_platform))
    var_1.moving_platform = var_0.moving_platform;

  var_1.animname = "_encstr_BA8E0766EA368EDE9B";
  var_1 scripts\common\anim::setanimtree();
  self.playerstartpowers = var_1;
  var_1 thread playerumpedfromplane();
}

playerswithoutdismemberment(var_0) {
  var_1 = _encstr_9186249B6C39B438E8CD5EB6C1E5CE85B6953AF283599B9789C9AF83D8BAE69159E41776DC8D::_id_1278C("_encstr_961F1027C76B12F866F85BDF981BAC8B07D0");
  thread _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::_id_13AC7("_encstr_96DC1C134EEBCCEA631DBD37D7260BC61BF6ED9B7D9B0DB7A3D732DBDDB9", self.owner, self.team);
  _encstr_9186249B6C39B438E8CD5EB6C1E5CE85B6953AF283599B9789C9AF83D8BAE69159E41776DC8D::num_rocket_per_attack(var_1.dropplunder);
  playFX(scripts\engine\utility::getfx("_encstr_A2DF13DB1021F1200DCACB0A35575DF8DB435F109F"), self.origin, anglesToForward(self.angles));
  playsoundatpos(self.origin, "_encstr_9ABB1669BA771895F2EB9F952F0A5BD0F2D6F12369B520CF");
  thread playerswapteam();
}

playerswapteam() {
  self notify("_encstr_AD75063D571AE108");

  if(isDefined(self.owner))
    self.owner.playerstartpowers = undefined;

  self hide();
  scripts\mp\damage::monitordamageend();
  self setscriptablepartstate("_encstr_B4A611709BF80DD00BD915C33580C83AB08241", "_encstr_ADB209DDA0A3209B828060", 0);
  self setscriptablepartstate("_encstr_860D1302CB51BBB573C7F5FB5B61FF538583CADA73", "_encstr_ADB209DDA0A3209B828060", 0);
  self setscriptablepartstate("_encstr_A2CC08B2333395D81D37", "_encstr_A7A408B9CA5D1D4E2C63", 0);
  _encstr_9186249B6C39B438E8CD5EB6C1E5CE85B6953AF283599B9789C9AF83D8BAE69159E41776DC8D::_id_12786(self);
  self stopanimScripted();

  if(isDefined(self.scenenode))
    self.scenenode delete();

  waitframe();

  if(isDefined(self))
    self delete();
}

playerwager(var_0) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");

  if(!istrue(level.br_plunder_enabled)) {
    return;
  }
  var_0 waittill("_encstr_8DE90E4D31C35370B84D709B4B6DEE42", var_1);

  if(isDefined(var_1)) {
    if(var_1 scripts\common\vehicle::isvehicle() || isDefined(var_1.classname) && var_1.classname == "_encstr_86440FCD8D9CD2833AFA3B2B34B4D81B56") {
      self playlocalsound("_encstr_ACA80FED33315369193F78E1B96C1575FB");
      scripts\mp\hud_message::showerrormessage("_encstr_AA4C1D4DD718F7A657A911F8D951AD8F4CB0D73BC79C7BFDB1F9E910B127D7");

      if(isDefined(self.super))
        playerunpackdatafromomnvar();

      var_0 delete();
      return;
    }

    if(getdvarint("_encstr_ADEC113D32478E608B08FB93917B98F013BD50", 1) == 1)
      playerstreamhintlocation(var_0, var_1);

    if(!isDefined(var_0.moving_platform)) {
      self playlocalsound("_encstr_ACA80FED33315369193F78E1B96C1575FB");
      scripts\mp\hud_message::showerrormessage("_encstr_AA4C1D4DD718F7A657A911F8D951AD8F4CB0D73BC79C7BFDB1F9E910B127D7");

      if(isDefined(self.super))
        playerunpackdatafromomnvar();

      var_0 delete();
      return;
    }
  }

  if(!playerstreamhintdroptoground(var_0)) {
    self playlocalsound("_encstr_ACA80FED33315369193F78E1B96C1575FB");
    scripts\mp\hud_message::showerrormessage("_encstr_B1A3186A82E534A04D12D7840A62263D3D27F590C4D3A1B41588");

    if(isDefined(self.super))
      playerunpackdatafromomnvar();

    var_0 delete();
    return;
  } else if(1 && isDefined(self.playerstartpowers)) {
    self playlocalsound("_encstr_ACA80FED33315369193F78E1B96C1575FB");
    scripts\mp\hud_message::showerrormessage("_encstr_8DCE1941B85685732278F919140DB1DC7F1EF045CFAF4E239EE431");

    if(isDefined(self.super))
      playerunpackdatafromomnvar();

    var_0 delete();
    return;
  }

  if(isDefined(self.super))
    scripts\mp\supers::superusefinished(undefined, undefined, undefined, 1);

  thread playersusing(var_0);

  if(isDefined(var_0))
    var_0 delete();
}

playerstreamhintlocation(var_0, var_1) {
  if(isDefined(var_1.write_to_dlog_runtime_struct_data)) {
    if(isDefined(var_1.write_to_dlog_runtime_struct_data.targetname)) {
      if(var_1.write_to_dlog_runtime_struct_data.targetname == "_encstr_8B4C098E39162DE6D777E9")
        var_0.moving_platform = var_1;
    }
  } else if(isDefined(var_1.targetname) && var_1.targetname == "_encstr_8B4C098E39162DE6D777E9")
    var_0.moving_platform = var_1;
}

playerumpedfromplane() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_A5310EF36003226B5E1DD0D4AEA10F6B");
  playsoundatpos(self.origin, "_encstr_8863102AE0915BFFF0985249ACFE9B622F60");
  thread _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::_id_13AC7("_encstr_B4A71850EB9E04DD031318120F1DF84BE032413153C161C32A5A", self.owner, self.team);
  var_0 = scripts\mp\utility\teams::getfriendlyplayers(self.team);
  _encstr_9186249B6C39B438E8CD5EB6C1E5CE85B6953AF283599B9789C9AF83D8BAE69159E41776DC8D::_id_12796(self, "_encstr_961F1027C76B12F866F85BDF981BAC8B07D0");
  thread _encstr_9186249B6C39B438E8CD5EB6C1E5CE85B6953AF283599B9789C9AF83D8BAE69159E41776DC8D::_id_127A4(self, var_0);
  _encstr_9186249B6C39B438E8CD5EB6C1E5CE85B6953AF283599B9789C9AF83D8BAE69159E41776DC8D::_id_127AA(self, var_0);
  var_1 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self.origin);
  var_1 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_1.angles = self.angles * (0, 1, 0);
  var_1.playerstartpowers = self;
  self.scenenode = var_1;

  if(isDefined(self.moving_platform)) {
    self linkTo(self.moving_platform);
    var_1 linkTo(self.moving_platform);
  }

  playertracking();
  var_2 = _encstr_9186249B6C39B438E8CD5EB6C1E5CE85B6953AF283599B9789C9AF83D8BAE69159E41776DC8D::_id_1278C("_encstr_961F1027C76B12F866F85BDF981BAC8B07D0", 1);

  if(var_2.get_chopper_boss_combat_action)
    thread scripts\mp\damage::monitordamage(500, "_encstr_B40101", ::playerteleporttoloc, ::playerteleportprop);
}

playertracking() {
  self setscriptablepartstate("_encstr_A2CC08B2333395D81D37", "_encstr_A6A90787BF8DEBC513", 0);
  self.scenenode scripts\common\anim::anim_single_solo(self, "_encstr_8D800C09937385C02DEF7741FD15");
  childthread playertryzombiespawn();
}

playertryzombiespawn() {
  for(;;)
    self.scenenode scripts\common\anim::anim_single_solo(self, "_encstr_8F2511900D551107684E881B88F5171A628135");
}

playerteleportprop(var_0) {
  var_1 = var_0.damage;

  if(!istrue(scripts\cp_mp\utility\player_utility::playersareenemies(var_0.attacker, self.owner)))
    var_1 = 0;
  else {
    var_1 = scripts\mp\damage::handleshotgundamage(var_0.objweapon, var_0.meansofdeath, var_0.damage);
    var_2 = undefined;

    if(var_0.meansofdeath == "_encstr_8DED0A21C79B660BC7588981")
      var_1 = int(ceil(self.maxhealth / 6));
    else if(isexplosivedamagemod(var_0.meansofdeath)) {
      if(var_0.damage >= 50)
        var_1 = int(ceil(self.maxhealth / 2));
    }
  }

  return var_1;
}

playerteleporttoloc(var_0) {
  thread playerswithoutdismemberment(var_0);
}

playerusehealslot(var_0, var_1, var_2) {
  var_3 = _encstr_9186249B6C39B438E8CD5EB6C1E5CE85B6953AF283599B9789C9AF83D8BAE69159E41776DC8D::_id_1278C("_encstr_961F1027C76B12F866F85BDF981BAC8B07D0");
  var_1 thread _encstr_9186249B6C39B438E8CD5EB6C1E5CE85B6953AF283599B9789C9AF83D8BAE69159E41776DC8D::_id_1261F(var_2, var_3._id_14077, var_0);
}

playerupdatebesttimehud(var_0, var_1) {
  if(isDefined(var_0.owner))
    var_0.owner.playerstartpowers = undefined;

  _encstr_9186249B6C39B438E8CD5EB6C1E5CE85B6953AF283599B9789C9AF83D8BAE69159E41776DC8D::_id_1279D(var_0);
}

playerupdatehudstate(var_0) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_1 = _encstr_9186249B6C39B438E8CD5EB6C1E5CE85B6953AF283599B9789C9AF83D8BAE69159E41776DC8D::_id_1278C("_encstr_961F1027C76B12F866F85BDF981BAC8B07D0");
  var_2 = undefined;
  var_0 scripts\mp\damage::monitordamageend();
  var_2 = _encstr_9186249B6C39B438E8CD5EB6C1E5CE85B6953AF283599B9789C9AF83D8BAE69159E41776DC8D::num_players_in_safehouse();
  thread _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::_id_13AC7("_encstr_A18024BA0D0126D30950F7F2C7D909ED0C303FE39696483BF2DAB7C302A765887BB77AB76A7B", self.owner, self.team);
  self notify("_encstr_AA150FCC57B13A7B73D7A358B5567B9999");
  self playsoundonmovingent("_encstr_A98E174002F9FAC323DD87A8490EC101F95F25B089BEFB9778");
  self.scenenode scripts\common\anim::anim_single_solo(self, "_encstr_AA150FCC57B13A7B73D7A358B5567B9999");
  thread playerswapteam();
}

playerupdatealivecounthuman(var_0) {
  thread _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::_id_13AC7("_encstr_B66417D39DAE6D0574B3C8D3B05A0AA0584F223DF9589FB095", var_0.owner, var_0.team);
}

playerstreamhintdroptoground(var_0) {
  if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::uniquelootitemid())
    return 1;

  var_1 = 25;
  var_2 = scripts\cp_mp\parachute::getc130height();
  var_3 = var_0.origin + (0, 0, var_1 + 1);
  var_4 = (var_0.origin[0], var_0.origin[1], var_2);
  var_5 = scripts\engine\trace::create_contents(0, 1, 1, 1, 1, 1, 0);
  var_6 = scripts\engine\trace::sphere_trace(var_3, var_4, var_1, var_0, var_5);
  return var_6["_encstr_A53009A25003666B9818C6"] == 1.0;
}

playerunpackdatafromomnvar() {
  self setweaponammoclip(self.super.staticdata.weapon, 1);
  self notify("_encstr_BE3D16D745322B1E5F4B7BA1F1635B908CBB6963FC51106E");
  self notify("_encstr_950113E6EA07CA93EBABB995FACCB4DCD26E0D2B19");
  scripts\cp\vehicles\vehicle_compass_cp::_id_12097(self.super, 1);
  var_0 = scripts\mp\supers::getcurrentsuper();
  scripts\mp\supers::_id_131C7(0);
  scripts\mp\supers::_id_131C6(0);
  var_0.wasrefunded = 1;
  scripts\mp\supers::setsuperbasepoints(scripts\mp\supers::getsuperpointsneeded());
}