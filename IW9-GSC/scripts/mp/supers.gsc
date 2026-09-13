/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\supers.gsc
***********************************************/

init() {
  if(!isDefined(level._id_7C7B046A6B9536FC)) {
    if(isDefined(level._id_62F6F7640E4431E3) && isDefined(level._id_62F6F7640E4431E3._id_63B618614D288401))
      level._id_7C7B046A6B9536FC = "superlist:" + level._id_62F6F7640E4431E3._id_63B618614D288401;
    else if(isDefined(level._id_1A2B600A06EC21F4) && isDefined(level._id_1A2B600A06EC21F4._id_63B618614D288401))
      level._id_7C7B046A6B9536FC = "superlist:" + level._id_1A2B600A06EC21F4._id_63B618614D288401;
  }

  _id_584994FAB4A8712B = spawnStruct();
  level.superglobals = _id_584994FAB4A8712B;
  _id_584994FAB4A8712B.staticsuperdata = [];
  _id_584994FAB4A8712B.superweapons = [];
  _id_584994FAB4A8712B.supersbyid = [];
  _id_584994FAB4A8712B.supersbyoffhand = [];
  _id_584994FAB4A8712B.supersbyextraweapon = [];
  _id_584994FAB4A8712B.pointeventdata = [];
  _id_E3234BE372F6209D(level._id_7C7B046A6B9536FC);
  registersupers();
  _id_B11714522B76C040();
  initsuperdvars();
  scripts\mp\utility\spawn_event_aggregator::registeronplayerspawncallback(::clearsuperreminderondeath);
  thread watchforgameend();

  if(getdvarint("dvar_350B9A835C1F30B8", 0) > 0)
    thread watchsuperlottery();

  if(level.allowsupers || scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508())
    level thread handlesuperearnovertime();

  level notify("init_supers");
  _id_407C3ADF846B725B::_id_BFEEEFE1B4413EF0();
  scripts\mp\equipment\tactical_cover::tac_cover_init();
  scripts\mp\equipment\support_box::supportbox_init();
  scripts\mp\supers\super_stoppingpower::stoppingpower_init();
  _id_1311C5C284DD1537::_id_E24031140ED11F4F();
  _id_51F5154861435B1E::_id_5027F03ACD35A5CA();
  _id_34E2C429F1463C06::_id_C35F8FE1F419BB40();
  _id_5E2DCB7FB9811781::_id_DCA5550C46B2A111();
  _id_30CD25DB3C981D4F::_id_D1F6522BC93ED94E();
  _id_28B451B2EA6DAE46::_id_A09BD8D12B478568();
  _id_45C10CA5CB8409BF::_id_735ED2B006DCE0EB();
  _id_4BEF961309209288::_id_D0930F871341093C();
  _id_19818A4D668D8841::_id_68300CD2B488BA4D();
  _id_1D393929CF0BD6A2::_id_9B095D72F2911EC8();
  _id_041297C155FDEE34::_id_4BEB6EA484D2DB90();
  _id_556B8AEAA691317F::_id_C916427F116F1206();
  _id_1B4114093CD44368::_id_234851F94416F178();

  if(istrue(level._id_7EBAD80A50484A39)) {
    _id_104E3370B024F998::init();
    _id_328CEEBB19C9CF51::_id_38A4F67440CF220E();
    _id_24933BC598A88C61::_id_9E8A4373C9755F3D();
  }

  waittillframeend;
  scripts\mp\utility\spawn_event_aggregator::registeronplayerspawncallback(::super_onspawned);
  level._id_3E969A1CC0AD79CC = strtok(getDvar("dvar_51BBC6411BD93FEA", ""), " ");
}

_id_E3234BE372F6209D(_id_7C7B046A6B9536FC) {
  _id_5D7589BF09BDF4D8 = getscriptbundle(_id_7C7B046A6B9536FC);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_5D7589BF09BDF4D8._id_63B618614D288401.size; _id_AC0E594AC96AA3A8++) {
    _id_EBEC497FF8B18A45 = _id_5D7589BF09BDF4D8._id_63B618614D288401[_id_AC0E594AC96AA3A8].ref;
    _id_2E7E6CDE22741AB3 = _id_5D7589BF09BDF4D8._id_63B618614D288401[_id_AC0E594AC96AA3A8]._id_D442547D75DFFD09;

    if(isDefined(_id_EBEC497FF8B18A45) && _id_EBEC497FF8B18A45 == "none") {
      continue;
    }
    if(isDefined(_id_2E7E6CDE22741AB3) && isDefined(_id_EBEC497FF8B18A45) && _id_EBEC497FF8B18A45 != "") {
      _id_19C643069B108770 = getscriptbundle("super:" + _id_2E7E6CDE22741AB3);

      if(isDefined(_id_19C643069B108770)) {
        staticdata = spawnStruct();
        level.superglobals.staticsuperdata[_id_EBEC497FF8B18A45] = staticdata;
        staticdata.id = _id_AC0E594AC96AA3A8;
        staticdata.ref = _id_EBEC497FF8B18A45;
        staticdata.weapon = _id_19C643069B108770.offhandweapon;
        staticdata._id_156B27CC0DA0F727 = _id_19C643069B108770._id_0CCA155763701359;
        staticdata._id_5C8E66E22B288B33 = _id_19C643069B108770._id_5C8E66E22B288B33;
        staticdata._id_D442547D75DFFD09 = _id_19C643069B108770;
        pointsneeded = undefined;
        usetime = undefined;
        graceperiod = undefined;

        if(scripts\mp\utility\game::isanymlgmatch()) {
          pointsneeded = _id_19C643069B108770._id_D90C4AE14206496F;
          usetime = _id_19C643069B108770._id_28B37DF55CA4858D;
          graceperiod = _id_19C643069B108770._id_9A13D90855396E3A;
        }

        if(!isDefined(pointsneeded))
          pointsneeded = _id_19C643069B108770.pointsneeded;

        if(!isDefined(usetime))
          usetime = _id_19C643069B108770.usetime;

        if(!isDefined(graceperiod))
          graceperiod = _id_19C643069B108770.graceperiod;

        staticdata.pointsneeded = scripts\engine\utility::ter_op(isDefined(pointsneeded), pointsneeded, 0);
        staticdata.usetime = usetime;
        staticdata.graceperiod = graceperiod;
        staticdata.refundondeath = _id_19C643069B108770.refundondeath;
        staticdata.useweapon = _id_19C643069B108770.useweapon;
        staticdata.useweaponclipammo = scripts\engine\utility::ter_op(isDefined(_id_19C643069B108770.useweaponclipammo), _id_19C643069B108770.useweaponclipammo, 0);
        staticdata.useweaponstockammo = scripts\engine\utility::ter_op(isDefined(_id_19C643069B108770.useweaponstockammo), _id_19C643069B108770.useweaponstockammo, 0);
        staticdata.useweapontrackstats = scripts\engine\utility::ter_op(isDefined(_id_19C643069B108770._id_A6AD55F6D5E63E36), _id_19C643069B108770._id_A6AD55F6D5E63E36, 0);
        staticdata.movespeed = _id_19C643069B108770.movespeed;
        staticdata.isweapon = _id_19C643069B108770.isweapon;
        staticdata.canuseinlaststand = _id_19C643069B108770.canuseinlaststand;
        staticdata._id_80B52426E4D315E0 = _id_19C643069B108770._id_80B52426E4D315E0;
        staticdata._id_FF2E3A3658646A3F = _id_19C643069B108770._id_FF2E3A3658646A3F;
        staticdata._id_6AF942BB3F913F9F = istrue(_id_19C643069B108770._id_CD006F80436A89FD);
        staticdata._id_D835CD7ABD661B88 = _id_19C643069B108770._id_6CCF992F8F601E2E;
        staticdata._id_94DEAC09D462D41E = _id_19C643069B108770._id_94DEAC09D462D41E;

        if(_id_19C643069B108770._id_41F94BCA374ED58A >= 0)
          staticdata._id_41F94BCA374ED58A = _id_19C643069B108770._id_41F94BCA374ED58A;

        staticdata.extraweapons = [];

        if(isDefined(staticdata.useweapon) && staticdata.useweapon != "")
          staticdata.useweapon = _id_2669878CF5A1B6BC::buildweapon_blueprint(staticdata.useweapon, "none", "none", 0);

        level.superglobals.supersbyid[_id_AC0E594AC96AA3A8] = _id_EBEC497FF8B18A45;

        if(!isDefined(staticdata.weapon))
          level.superglobals.staticsuperdata[_id_EBEC497FF8B18A45] = undefined;
        else
          level.superglobals.supersbyoffhand[staticdata.weapon] = staticdata;

        if(!isDefined(staticdata.pointsneeded))
          level.superglobals.staticsuperdata[_id_EBEC497FF8B18A45] = undefined;

        if(isDefined(staticdata.maxactivations)) {
          if(staticdata.maxactivations > 0)
            staticdata.activatepenalty = 1.0 / staticdata.maxactivations;
          else
            staticdata.activatepenalty = 1.0;
        }

        if(isDefined(staticdata.maxactivationsalt)) {
          if(staticdata.maxactivationsalt > 0)
            staticdata.activatepenaltyalt = 1.0 / staticdata.maxactivationsalt;
        }

        if(isDefined(staticdata.useweapon) && isweapon(staticdata.useweapon))
          level.superglobals.superweapons[staticdata.useweapon.basename] = staticdata;

        if(isDefined(staticdata.graceperiod))
          staticdata.graceperiod = staticdata.graceperiod * 1000.0;
        else
          staticdata.graceperiod = 0.0;
      }
    }
  }
}

_id_22BFF45FCF920417() {
  level._id_07DE15B4C7F0A425 = [];
}

_id_18A7C22094077FE9(_id_DB0176D05C1D9564) {
  _id_DB0176D05C1D9564 = scripts\engine\utility::_id_53C4C53197386572(_id_DB0176D05C1D9564, 96);
  _id_7BFB992CEE74D051 = 0.05 * (_id_DB0176D05C1D9564 / 60.0);
  _id_4D75A970580A253C("stat_1E5485EF2E9F9384", _id_7BFB992CEE74D051);
}

_id_4D75A970580A253C(eventref, points) {
  if(!isDefined(points)) {
    return;
  }
  level._id_07DE15B4C7F0A425[eventref] = points;
}

registersupers() {
  if(getdvarint("dvar_742CAA13B3C2E685")) {
    return;
  }
  _id_53110A12409D01DA("super_test", undefined, undefined, ::testsuperbeginuse, undefined, undefined, undefined, undefined);
  _id_53110A12409D01DA("super_br_extract", undefined, undefined, ::brcircleextract, undefined, undefined, undefined, undefined);
  _id_53110A12409D01DA("super_tac_cover", undefined, ::taccoverunset, ::taccoverbeginuse, undefined, undefined, undefined, undefined);
  _id_53110A12409D01DA("super_recon_drone", undefined, ::recondroneunset, ::recondronebeginuse, ::recondroneenduse, ::_id_3529248AA2D81ABC, undefined, undefined);
  _id_53110A12409D01DA("super_support_box", undefined, ::supportboxunset, ::stoppingpowerbeginuse, undefined, undefined, undefined, undefined);
  _id_53110A12409D01DA("super_trophy", ::trophyonset, undefined, undefined, undefined, undefined, undefined, undefined);
  _id_53110A12409D01DA("super_scramble", undefined, undefined, ::scramblebeginuse, ::scrambleusefinished, undefined, undefined, undefined);
  _id_53110A12409D01DA("super_deadsilence", undefined, undefined, ::deadsilencebeginuse, ::deadsilenceenduse, undefined, undefined, undefined);
  _id_53110A12409D01DA("super_tac_insert", ::tacinsertonset, ::tacinsertonunset, undefined, undefined, undefined, undefined, undefined);
  _id_53110A12409D01DA("super_weapon_drop", undefined, undefined, ::superweapondropbeginuse, undefined, undefined, undefined, undefined);
  _id_53110A12409D01DA("super_select", ::superselectonset, ::superselectonunset, ::superselectbeginuse, undefined, undefined, ::_id_BAF9EEEF4CF2BAC5, ::_id_FAD6D78D6B3B3359);
  _id_53110A12409D01DA("super_fulton", undefined, undefined, ::superfultonbeginuse, undefined, undefined, undefined, undefined);
  _id_53110A12409D01DA("super_supply_drop", undefined, undefined, ::supersupplydropbeginuse, undefined, undefined, undefined, undefined);
  _id_53110A12409D01DA("super_tac_camera", ::_id_D1BD30BE0C5EC282, ::_id_2EF8268013BDBE57, undefined, undefined, undefined, ::_id_DFC3421815005E62, ::_id_2B9E988CDB17F507);
  _id_53110A12409D01DA("super_recon_dart", ::_id_FAD76FFCE1BC5317, ::_id_AF1D2E4473F5057E, undefined, undefined, undefined, undefined, undefined);
  _id_53110A12409D01DA("super_suppression_rounds", undefined, ::_id_EF705D06883B52A7, ::_id_66C2B6FB2734CBAE, undefined, undefined, undefined, undefined);
  _id_53110A12409D01DA("super_emp_pulse", undefined, ::_id_0E050BB329310407, ::_id_2DE710D6B3C9388E, ::_id_CA449B017D946D26, undefined, ::_id_D93F331B74C647F2, undefined);
  _id_53110A12409D01DA("super_battlerage", undefined, undefined, ::_id_81A2DF228546136E, ::_id_D1B35AA1689BEB06, undefined, undefined, undefined);
  _id_53110A12409D01DA("super_stimpistol", ::_id_0AFD34C64E8C8D5D, ::_id_90A74A57A43C9808, ::_id_53025970EB68A86B, ::_id_FDFAE98BCFBF8C7F, undefined, undefined, undefined);
  _id_53110A12409D01DA("super_smoke_airdrop", undefined, ::_id_2E14B99891ECBBF4, ::_id_14761663823DBCB7, undefined, undefined, undefined, undefined);
  _id_53110A12409D01DA("super_balloon_extract", undefined, undefined, ::superfultonbeginuse, undefined, undefined, undefined, undefined);
  _id_53110A12409D01DA("super_loadout_drop", undefined, undefined, ::_id_8D6D142BCEB819F2, undefined, undefined, undefined, undefined);
  _id_53110A12409D01DA("super_door_barricade", undefined, undefined, ::_id_9C38F7EA2223B47C, undefined, undefined, undefined, undefined);
  _id_53110A12409D01DA("super_deployed_decoy", undefined, ::_id_CF92670CCE45E726, undefined, undefined, undefined, undefined, ::_id_25B1B1C8CAE25C68);
  _id_53110A12409D01DA("super_oxygen_mask", undefined, undefined, _id_1B4114093CD44368::_id_24A2E2FA6ADC7F55, undefined, ::_id_E3C0D84AA4294EE9, undefined, undefined);
  _id_53110A12409D01DA("super_deployable_kiosk", undefined, undefined, ::_id_03BC4F06F06E9C62, undefined, undefined, undefined, undefined);
  _id_53110A12409D01DA("super_vehicle_drop", undefined, undefined, ::_id_7EEAD274EF83E1B9, undefined, undefined, undefined, undefined);
  _id_53110A12409D01DA("super_temp_v", undefined, undefined, ::_id_19B0130D94D96B0B, ::_id_34956DA8DD3AFD1F, undefined, ::_id_CF347A049095421B, undefined);
  _id_53110A12409D01DA("super_laser_charge", undefined, undefined, ::_id_FC34A7D0E83B6D77, ::_id_A7043870418BF96B, undefined, undefined, undefined);
  _id_53110A12409D01DA("super_high_jump", undefined, undefined, ::_id_F98D4EC41407BC75, ::_id_975965422D6BCB49, undefined, undefined, undefined);
  _id_53110A12409D01DA("super_teleport_deploy", undefined, undefined, ::_id_E9993EE767C0ACF5, ::_id_EC715B4038AE47C9, undefined, undefined, undefined);
  _id_53110A12409D01DA("super_melee_jugg", undefined, undefined, ::_id_E67D9C8005D3F178, ::_id_13214DC30F36BF08, undefined, undefined, undefined);
  _id_53110A12409D01DA("super_electric_discharge", undefined, undefined, ::_id_8D08654F0023D631, ::_id_2B9DFA62D7E245F5, ::_id_3A1B0EE4F020AB35, undefined, undefined);

  if(isDefined(level._id_762C63041675C851))
    [[level._id_762C63041675C851]]();

  registersuperextraweapon("super_weapon_drop", "deploy_weapondrop_mp");
}

_id_53110A12409D01DA(ref, setfunc, unsetfunc, beginusefunc, endusefunc, _id_E0AF69536A727F03, _id_70B09ED29C10732F, _id_1BB8C2DE6198881A) {
  staticdata = level.superglobals.staticsuperdata[ref];

  if(!isDefined(staticdata)) {
    return;
  }
  staticdata.setfunc = setfunc;
  staticdata.unsetfunc = unsetfunc;
  staticdata.beginusefunc = beginusefunc;
  staticdata.endusefunc = endusefunc;
  staticdata._id_E0AF69536A727F03 = _id_E0AF69536A727F03;
  staticdata._id_70B09ED29C10732F = _id_70B09ED29C10732F;
  staticdata._id_1BB8C2DE6198881A = _id_1BB8C2DE6198881A;

  if(!isDefined(_id_E0AF69536A727F03) && istrue(staticdata._id_FF2E3A3658646A3F))
    staticdata._id_E0AF69536A727F03 = ::_id_97EECCE0124A7B50;
}

_id_B11714522B76C040() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("supers", "setSuperIsActive", ::_id_330825804EBBD918);
  scripts\cp_mp\utility\script_utility::registersharedfunc("supers", "isUsingSuperWeapon", ::_id_52E340D32E36DF3E);
  scripts\cp_mp\utility\script_utility::registersharedfunc("supers", "superHasTimedUsage", ::_id_C7372AB32E9D5636);
  scripts\cp_mp\utility\script_utility::registersharedfunc("supers", "superHasAmmoUsage", ::_id_CC6A20F09D95D319);
}

registersuperextraweapon(ref, weapon) {
  if(!isstring(weapon))
    weapon = weapon.basename;

  staticdata = level.superglobals.staticsuperdata[ref];

  if(!isDefined(staticdata)) {
    return;
  }
  staticdata.extraweapons[staticdata.extraweapons.size] = weapon;
  level.superglobals.supersbyextraweapon[weapon] = staticdata;
}

super_onspawned() {
  if(isDefined(self.super) && level.superglobals._id_88BF1CA5D31120C4 == 1) {
    givesuperpoints(getsuperpointsneeded(), undefined, 0);
    thread _id_66CC363DA0BF8520();
  }

  updatesuperuiprogress();
  updatesuperuistate();
  _id_E20AB7A8971EE3F2();
}

_id_66CC363DA0BF8520() {
  self endon("death_or_disconnect");
  level endon("game_ended");
  self notify("supers_watchingLoadoutchange");
  self endon("supers_watchingLoadoutChange");

  for(;;) {
    self waittill("super_set");
    givesuperpoints(getsuperpointsneeded());
  }
}

_id_9D0DE1F8996C57F8(_id_EBEC497FF8B18A45) {
  self endon("death_or_disconnect");
  level endon("game_ended");
  waitframe();
  self setclientomnvar("ui_super_ref", _id_EBEC497FF8B18A45);
}

givesuper(_id_EBEC497FF8B18A45, _id_6C70BF5AD211F464, immediate) {
  if(getdvarint("scr_supers_killswitch") != 0) {
    return;
  }
  clearsuper(_id_6C70BF5AD211F464, _id_EBEC497FF8B18A45);

  if(_id_EBEC497FF8B18A45 == "") {
    return;
  }
  staticdata = level.superglobals.staticsuperdata[_id_EBEC497FF8B18A45];

  if(!isDefined(staticdata)) {
    return;
  }
  _id_19163E14365D9264 = spawnStruct();
  self.super = _id_19163E14365D9264;
  _id_19163E14365D9264.staticdata = staticdata;
  _id_19163E14365D9264.allowrefund = 1;
  _id_19163E14365D9264.numkills = 0;
  _id_19163E14365D9264.wasrefunded = 0;
  _id_19163E14365D9264.canstow = 0;
  _id_19163E14365D9264.lifeid = scripts\cp_mp\utility\killstreak_utility::getcurrentplayerlifeidforkillstreak();
  _id_19163E14365D9264.basepoints = 0;
  _id_19163E14365D9264.extrapoints = 0;
  _id_19163E14365D9264.usestarttime = undefined;
  _id_19163E14365D9264.usepercent = 0.0;
  _id_19163E14365D9264.overridepointsneeded = undefined;
  setsuperisinuse(0);
  _id_330825804EBBD918(0);

  if(isDefined(_id_19163E14365D9264.staticdata.useweapon))
    _id_9AA5FDB675559E34();

  superonset(_id_EBEC497FF8B18A45);
  thread _id_9D0DE1F8996C57F8(_id_EBEC497FF8B18A45);
  _id_F11F403A652285AE = self.pers["superBasePoints"];

  if(!isDefined(_id_F11F403A652285AE))
    _id_F11F403A652285AE = 0;

  self.pers["superBasePoints"] = undefined;
  setsuperbasepoints(_id_F11F403A652285AE);
  _id_EEE788DC56616619 = self.pers["superExtraPoints"];

  if(!isDefined(_id_EEE788DC56616619))
    _id_EEE788DC56616619 = 0;

  self.pers["superExtraPoints"] = undefined;
  setsuperextrapoints(_id_EEE788DC56616619);

  if(!isDefined(self.pers["superExpended"]))
    setsuperexpended(0);

  if(istrue(immediate)) {
    givesuperpoints(getsuperpointsneeded());
    _id_19163E14365D9264.madeavailabletime = gettime();
    scripts\mp\analyticslog::logevent_superearned(_id_19163E14365D9264.madeavailabletime);
  }

  scripts\cp_mp\utility\inventory_utility::_giveweapon(staticdata.weapon);
  ammo = scripts\engine\utility::ter_op(issuperready(), 1, 0);
  self setweaponammoclip(staticdata.weapon, ammo);
  firstupgrade = level.superglobals.staticsuperdata[scripts\mp\perks\perkpackage::perkpackage_getfirstfieldupgrade()];
  secondupgrade = level.superglobals.staticsuperdata[scripts\mp\perks\perkpackage::perkpackage_getsecondfieldupgrade()];
  _id_4E7EA53A34C37FBE = "none";
  _id_294B52D8009B81DA = "none";

  if(isDefined(firstupgrade) && firstupgrade != staticdata)
    _id_4E7EA53A34C37FBE = firstupgrade.weapon;

  if(isDefined(secondupgrade) && secondupgrade != staticdata)
    _id_294B52D8009B81DA = secondupgrade.weapon;

  self assignweaponoffhandspecial(staticdata.weapon, _id_4E7EA53A34C37FBE, _id_294B52D8009B81DA);
  thread watchforsuperusebegin();
  thread handlespectating();

  if(!scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508() || level.allowsupers) {
    thread watchforrespawn();
    thread storesupercooldownforroundchange();
    thread handleteamchange();
  }
}

handlesuperearnovertime() {
  level endon("game_ended");

  if(!scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508())
    scripts\mp\flags::gameflagwait("prematch_done");

  starttime = gettime();
  waitframe();

  for(;;) {
    if(isDefined(level._id_D659494E95BD9496) && level._id_D659494E95BD9496) {
      starttime = gettime();
      waitframe();
      continue;
    }

    _id_D12A341B40354143 = level.players.size;
    _id_5C504378BDE978E1 = (gettime() - starttime) / 50;

    if(_id_5C504378BDE978E1 < 11) {
      wait((11 - _id_5C504378BDE978E1) * 0.05);
      _id_5C504378BDE978E1 = 11;
    }

    starttime = gettime();

    for(startplayer = 0; startplayer < _id_D12A341B40354143; startplayer = startplayer + 15) {
      for(_id_82555C709FBE7CCC = 0; _id_82555C709FBE7CCC < 15; _id_82555C709FBE7CCC++) {
        _id_EF50426720E1DBB8 = startplayer + _id_82555C709FBE7CCC;
        player = level.players[_id_EF50426720E1DBB8];

        if(!isDefined(player)) {
          continue;
        }
        if(istrue(player.pausesuperpointsovertime)) {
          continue;
        }
        if(!scripts\mp\utility\player::isreallyalive(player)) {
          continue;
        }
        if(isDefined(player getcurrentsuper()) && !player getcurrentsuper().isinuse && (isDefined(player._id_678855513F5076CA) || isDefined(level.allowsupers)))
          player givesuperpoints(0, "stat_1E5485EF2E9F9384", 0, _id_5C504378BDE978E1);
      }

      waitframe();
    }

    waitframe();
  }
}

_id_50F445936B3DDD9E(_id_D220971FFE40C601) {
  if(!isDefined(_id_D220971FFE40C601))
    return 1;

  if(!isDefined(self.perkpackagedata))
    return 1;

  if(_id_D220971FFE40C601 == "super_select")
    return 0;

  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {
    if(self.perkpackagedata.firstupgrade == _id_D220971FFE40C601)
      return 0;
    else
      return 1;
  }

  _id_B4A8899A61E7EEE9 = self.perkpackagedata._id_E5DA01E1954B6734;

  if(!isDefined(_id_B4A8899A61E7EEE9))
    return 1;

  if(_id_D220971FFE40C601 == _id_B4A8899A61E7EEE9)
    return 1;

  _id_1647B158AA996CF8 = _id_04B10D71720FC4A4(_id_B4A8899A61E7EEE9);
  _id_0327FC859A32AE60 = _id_04B10D71720FC4A4(_id_D220971FFE40C601);
  _id_35B042C5224A1646 = _id_D8F9E4158E12DE6B();

  if(_id_0327FC859A32AE60) {
    if(!isDefined(_id_35B042C5224A1646) || _id_35B042C5224A1646 != _id_D220971FFE40C601)
      _id_26F98B45FB791C0E();

    superonunset(_id_B4A8899A61E7EEE9);
    return 1;
  } else if(_id_1647B158AA996CF8 && !_id_0327FC859A32AE60) {
    _id_7ABBEE267D3AAD2F(_id_B4A8899A61E7EEE9);
    return 0;
  } else {
    superonunset(_id_B4A8899A61E7EEE9);
    return 1;
  }
}

_id_04B10D71720FC4A4(_id_EBEC497FF8B18A45) {
  staticdata = level.superglobals.staticsuperdata[_id_EBEC497FF8B18A45];

  if(!isDefined(staticdata))
    return 0;

  return istrue(staticdata._id_6AF942BB3F913F9F);
}

_id_7ABBEE267D3AAD2F(_id_EBEC497FF8B18A45) {
  if(isDefined(self._id_35B042C5224A1646) && self._id_35B042C5224A1646 != _id_EBEC497FF8B18A45)
    _id_26F98B45FB791C0E();

  self._id_35B042C5224A1646 = _id_EBEC497FF8B18A45;
}

_id_26F98B45FB791C0E() {
  if(!isDefined(self._id_35B042C5224A1646)) {
    return;
  }
  staticdata = level.superglobals.staticsuperdata[self._id_35B042C5224A1646];
  unsetfunc = staticdata.unsetfunc;

  if(!isDefined(unsetfunc)) {
    return;
  }
  self thread[[unsetfunc]]();
  self._id_35B042C5224A1646 = undefined;
}

_id_D8F9E4158E12DE6B() {
  return self._id_35B042C5224A1646;
}

clearsuper(_id_6C70BF5AD211F464, _id_D220971FFE40C601, _id_04C7CADAA72AF79D) {
  _id_19163E14365D9264 = getcurrentsuper();
  _id_FA91721E4A69C230 = scripts\mp\perks\perkfunctions::_id_66F0CBD5FF8458FE();

  if(issuperinuse() && (istrue(_id_19163E14365D9264.staticdata._id_80B52426E4D315E0) || _id_C7372AB32E9D5636() || _id_52E340D32E36DF3E()))
    superusefinished(0, istrue(_id_04C7CADAA72AF79D), 0, 0, 0, 1);

  if(isDefined(_id_19163E14365D9264) && isDefined(_id_19163E14365D9264.staticdata)) {
    if(_id_50F445936B3DDD9E(_id_D220971FFE40C601))
      superonunset(_id_19163E14365D9264.staticdata.ref);
  }

  if(istrue(_id_6C70BF5AD211F464) && isDefined(_id_19163E14365D9264))
    storesuperpoints();

  self clearoffhandspecial();

  if(isDefined(_id_19163E14365D9264))
    scripts\cp_mp\utility\inventory_utility::_takeweapon(_id_19163E14365D9264.staticdata.weapon);

  if(level.codcasterenabled && !isagent(self))
    self setspecialactive(0);

  self notify("remove_super");
  self.super = undefined;

  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508() && !_id_FA91721E4A69C230)
    self._id_1066FBD86C88A6DF = 0;

  thread _id_BDCBE42D37001209(0);
  thread _id_93B5448EA8F6277B(0);
  self setclientomnvar("ui_super_second_progress", 0);
  self setclientomnvar("ui_super_ref", "none");
}

superonset(_id_EBEC497FF8B18A45) {
  if(!isDefined(_id_EBEC497FF8B18A45)) {
    return;
  }
  if(_id_EBEC497FF8B18A45 == "none" || _id_EBEC497FF8B18A45 == "") {
    return;
  }
  staticdata = level.superglobals.staticsuperdata[_id_EBEC497FF8B18A45];

  if(!isDefined(staticdata)) {
    return;
  }
  clientnum = self getentitynumber();
  _id_548072087C9FD504::_id_F63556DC2AA67FDC(2, clientnum, undefined);

  if(isDefined(staticdata._id_E0AF69536A727F03))
    self setclientomnvar("ui_block_fu_not_ready_error", 1);

  self notify("super_set");
  setfunc = staticdata.setfunc;

  if(!isDefined(setfunc)) {
    return;
  }
  if(level.superglobals._id_88BF1CA5D31120C4 == 1)
    givesuperpoints(getsuperpointsneeded(), undefined, 0);

  self thread[[setfunc]]();
}

superonunset(_id_EBEC497FF8B18A45) {
  if(!isDefined(_id_EBEC497FF8B18A45)) {
    return;
  }
  if(_id_EBEC497FF8B18A45 == "none" || _id_EBEC497FF8B18A45 == "") {
    return;
  }
  staticdata = level.superglobals.staticsuperdata[_id_EBEC497FF8B18A45];

  if(!isDefined(staticdata)) {
    return;
  }
  if(isDefined(staticdata._id_E0AF69536A727F03))
    self setclientomnvar("ui_block_fu_not_ready_error", 0);

  self notify("unset_super");
  unsetfunc = staticdata.unsetfunc;

  if(!isDefined(unsetfunc)) {
    return;
  }
  self thread[[unsetfunc]]();
}

setsuperbasepoints(points, _id_2DD220C4D334A359, _id_5E5D91E0ED56109E) {
  _id_19163E14365D9264 = getcurrentsuper();
  _id_19163E14365D9264.basepoints = clamp(points, 0, getsuperpointsneeded());

  if(istrue(_id_2DD220C4D334A359)) {
    return;
  }
  superpointschanged(_id_5E5D91E0ED56109E);
}

setsuperextrapoints(points, _id_2DD220C4D334A359) {
  _id_19163E14365D9264 = getcurrentsuper();
  _id_19163E14365D9264.extrapoints = clamp(points, 0, getsuperpointsneeded());

  if(istrue(_id_2DD220C4D334A359)) {
    return;
  }
  superpointschanged();
}

_id_08C7B1312CF5986B(points, _id_2DD220C4D334A359) {
  _id_19163E14365D9264 = getcurrentsuper();

  if(isDefined(self._id_A68B289A82138067) && scripts\mp\utility\perk::_hasperk("specialty_overcharge_field_upgrade")) {
    self._id_A68B289A82138067 = clamp(points, 0, getsuperpointsneeded());

    if(!istrue(_id_2DD220C4D334A359)) {
      _id_B3D636936EC98AA0(self._id_A68B289A82138067);
      _id_E20AB7A8971EE3F2();
    }
  }
}

superpointschanged(_id_5E5D91E0ED56109E) {
  _id_19163E14365D9264 = getcurrentsuper();

  if(getcurrentsuperpoints() >= getsuperpointsneeded())
    superearned();
  else if(!istrue(_id_5E5D91E0ED56109E))
    self setweaponammoclip(_id_19163E14365D9264.staticdata.weapon, 0);

  updatesuperuiprogress();
  updatesuperuistate();
  _id_E20AB7A8971EE3F2();
}

givesuperpoints(points, _id_F0FA3B7B27926553, _id_B4B593FACAA83AF7, _id_53E3AF3B2C8752BD, _id_2569EC7D8016F67F, _id_7601733FB3A9AE73) {
  if(istrue(game["isLaunchChunk"]) || !level.allowsupers && !isDefined(self._id_678855513F5076CA)) {
    return;
  }
  if(!scripts\mp\perks\perkfunctions::_id_66F0CBD5FF8458FE()) {
    return;
  }
  if(getdvarint("dvar_EBA0EF12E9C9260B", 0) && !istrue(_id_B4B593FACAA83AF7)) {
    return;
  }
  if(isDefined(_id_F0FA3B7B27926553))
    points = getsuperpointsforevent(_id_F0FA3B7B27926553);

  if(isDefined(_id_53E3AF3B2C8752BD))
    points = points * _id_53E3AF3B2C8752BD;

  if(scripts\mp\utility\perk::_hasperk("specialty_faster_field_upgrade") && !isDefined(_id_2569EC7D8016F67F))
    points = points * getdvarfloat("perk_faster_field_upgrade_rate");

  if(isDefined(_id_F0FA3B7B27926553) && _id_F0FA3B7B27926553 == "stat_1E5485EF2E9F9384") {
    _id_2BC440C7D6A315D9 = points * level.superfastchargerate;

    if(scripts\cp_mp\utility\game_utility::_id_BA5574C7F287C587())
      _id_2BC440C7D6A315D9 = _id_2BC440C7D6A315D9 * 1.4;
  } else
    _id_2BC440C7D6A315D9 = points * level.superpointsmod;

  if(_id_2BC440C7D6A315D9 <= 0) {
    return;
  }
  _id_19163E14365D9264 = getcurrentsuper();

  if(!istrue(_id_7601733FB3A9AE73)) {
    if(!isDefined(_id_19163E14365D9264) || issuperready() || _id_19163E14365D9264.isinuse) {
      _id_89E09A97CD14A32A = !scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508() || istrue(self._id_0514192F8282796C);

      if(isDefined(_id_19163E14365D9264) && isDefined(self._id_A68B289A82138067) && scripts\mp\utility\perk::_hasperk("specialty_overcharge_field_upgrade") && _id_89E09A97CD14A32A)
        _id_08C7B1312CF5986B(self._id_A68B289A82138067 + _id_2BC440C7D6A315D9);

      updatesppm(points, 0, _id_F0FA3B7B27926553);
      return;
    }
  }

  _id_0E0859055A12A909 = min(_id_2BC440C7D6A315D9 + _id_19163E14365D9264.basepoints, getsuperpointsneeded());
  setsuperbasepoints(_id_0E0859055A12A909);
  scripts\mp\analyticslog::logevent_reportsuperscore(_id_2BC440C7D6A315D9, gettime());
  updatesppm(points, 1, _id_F0FA3B7B27926553);
}

_id_E20AB7A8971EE3F2() {
  _id_19163E14365D9264 = getcurrentsuper();

  if(!isDefined(_id_19163E14365D9264)) {
    return;
  }
  if(scripts\mp\utility\player::isinkillcam() || !isalive(self)) {
    self._id_6B4B4C0692F7BF67 = undefined;
    return;
  }

  if(!isDefined(self._id_491F93D0219D8D44))
    self._id_491F93D0219D8D44 = 1;

  pointsneeded = getsuperpointsneeded();
  progress = 0.0;

  if(_id_19163E14365D9264.isinuse)
    progress = getsuperuseuiprogress();
  else if(pointsneeded > 0)
    progress = clamp(getcurrentsuperbasepoints() / pointsneeded, 0.0, 1.0);

  _id_F52E8A5ADD0F7FF8 = 0;

  if(isDefined(self._id_A68B289A82138067)) {
    if(pointsneeded > 0)
      _id_F52E8A5ADD0F7FF8 = clamp(self._id_A68B289A82138067 / pointsneeded, 0.0, 1.0);
  }

  if(self._id_491F93D0219D8D44 > 0) {
    _id_9CF33E852E0E768A = progress + _id_F52E8A5ADD0F7FF8;
    self setplayersupermeterprogress(_id_9CF33E852E0E768A);
  }

  self._id_6B4B4C0692F7BF67 = self._id_491F93D0219D8D44;
}

_id_B3D636936EC98AA0(_id_0A8B48CD61729448) {
  _id_19163E14365D9264 = getcurrentsuper();

  if(!isDefined(_id_19163E14365D9264)) {
    return;
  }
  if(!isDefined(self._id_A68B289A82138067)) {
    return;
  }
  if(scripts\mp\utility\player::isinkillcam() || !isalive(self)) {
    self._id_2C0BF62A8DB71FD0 = undefined;
    return;
  }

  pointsneeded = getsuperpointsneeded();
  progress = 0;

  if(pointsneeded > 0)
    progress = clamp(_id_0A8B48CD61729448 / pointsneeded, 0.0, 1.0);

  if(!isDefined(self._id_2C0BF62A8DB71FD0) || progress != self._id_2C0BF62A8DB71FD0)
    self setclientomnvar("ui_super_second_progress", progress);

  self._id_2C0BF62A8DB71FD0 = progress;
}

updatesuperuiprogress() {
  _id_19163E14365D9264 = getcurrentsuper();

  if(!isDefined(_id_19163E14365D9264)) {
    return;
  }
  if(scripts\mp\utility\player::isinkillcam() || !isalive(self)) {
    _id_19163E14365D9264.oldprogress = undefined;
    return;
  }

  progress = 0.0;

  if(_id_19163E14365D9264.isinuse)
    progress = getsuperuseuiprogress();
  else {
    pointsneeded = getsuperpointsneeded();

    if(pointsneeded > 0)
      progress = clamp(getcurrentsuperbasepoints() / pointsneeded, 0.0, 1.0);
  }

  if(!isDefined(_id_19163E14365D9264.oldprogress) || progress != _id_19163E14365D9264.oldprogress)
    thread _id_93B5448EA8F6277B(progress);

  _id_19163E14365D9264.oldprogress = progress;
}

_id_BDCBE42D37001209(state) {
  self endon("disconnect");
  self endon("remove_super");
  level endon("game_ended");
  self notify("super_state_change");
  self endon("super_state_change");
  waittillframeend;
  self setclientomnvar("ui_super_state", state);
}

_id_93B5448EA8F6277B(progress) {
  self endon("disconnect");
  self endon("remove_super");
  level endon("game_ended");
  self notify("super_progress_change");
  self endon("super_progress_change");
  waittillframeend;
  self setclientomnvar("ui_super_progress", progress);
}

updatesuperuistate() {
  _id_19163E14365D9264 = getcurrentsuper();

  if(!isDefined(_id_19163E14365D9264)) {
    return;
  }
  if(!isDefined(_id_19163E14365D9264.isactive)) {
    return;
  }
  if(scripts\mp\utility\player::isinkillcam() || !isalive(self)) {
    _id_19163E14365D9264.state = undefined;
    return;
  }

  _id_38149715B031CF37 = _id_19163E14365D9264.state;
  state = 1;

  if(issuperexpended())
    state = 4;
  else if(issuperready()) {
    self setclientomnvar("ui_super_can_use", 1);
    state = 2;
  } else if(issuperinuse())
    state = 3;

  if(!isDefined(_id_38149715B031CF37) || state != _id_38149715B031CF37) {
    if(state == 1)
      self notify("super_use_charging");

    thread _id_BDCBE42D37001209(state);
  }

  _id_19163E14365D9264.state = state;
}

watchforrespawn() {
  _id_19163E14365D9264 = getcurrentsuper();
  self endon("disconnect");
  self endon("remove_super");

  for(;;) {
    self waittill("spawned_player");
    givesuperweapon(_id_19163E14365D9264);
  }
}

storesupercooldownforroundchange() {
  self endon("disconnect");
  self endon("remove_super");
  scripts\mp\flags::levelflagwait("game_over");

  if(istrue(game["practiceRound"])) {
    return;
  }
  storesuperpoints();
}

handlespectating() {
  self endon("disconnect");
  self endon("remove_super");
  self waittill("joined_spectators");

  if(issuperinuse())
    waitframe();

  thread clearsuper(1);
}

handleteamchange() {
  self endon("disconnect");
  self endon("remove_super");
  _id_8A04AA0E0755E7E3 = self.team;
  self waittill("joined_team");

  if(issuperinuse())
    waitframe();

  if(self.team != _id_8A04AA0E0755E7E3) {
    self.currentfirstupgrade = undefined;
    thread clearsuper(1);
  }
}

handlepointdecay() {
  self endon("disconnect");
  self endon("remove_super");
  level endon("game_ended");
  _id_19163E14365D9264 = getcurrentsuper();
  _id_F07E092064B5745A = getdvarfloat("scr_super_decay_rate", 6.0) * level.framedurationseconds;

  for(;;) {
    if(!issupercharging()) {
      waitframe();
      continue;
    }

    points = max(_id_19163E14365D9264.extrapoints - _id_F07E092064B5745A, 0);
    setsuperextrapoints(points);
    waitframe();
  }
}

superearned() {
  _id_19163E14365D9264 = getcurrentsuper();
  self setweaponammoclip(_id_19163E14365D9264.staticdata.weapon, 1);
  _id_8EF825FBC5430D59 = !_id_19163E14365D9264.wasrefunded;
  self notify("super_ready", _id_8EF825FBC5430D59);
  thread _id_E16C077503BBB00F();

  if(isDefined(_id_19163E14365D9264.staticdata.useweapon))
    _id_9AA5FDB675559E34();

  if(isDefined(_id_19163E14365D9264.staticdata._id_70B09ED29C10732F))
    self thread[[_id_19163E14365D9264.staticdata._id_70B09ED29C10732F]]();

  if(_id_8EF825FBC5430D59) {
    self.pers["supersEarned"]++;
    self notify("super_earned");
    recordsuperearnedanalytics(_id_19163E14365D9264);
  }

  _id_19163E14365D9264.madeavailabletime = gettime();
  _id_19163E14365D9264.numkills = 0;
  scripts\mp\analyticslog::logevent_superearned(_id_19163E14365D9264.madeavailabletime);
  setsuperextrapoints(0, 1);
  setsuperbasepoints(getsuperpointsneeded(), 1);

  if(isDefined(self.matchdatalifeindex))
    scripts\mp\analyticslog::logevent_fieldupgradeearned(self, _id_19163E14365D9264.staticdata.id);
}

watchforsuperusebegin() {
  self endon("disconnect");
  self endon("remove_super");

  for(;;) {
    self waittill("special_weapon_fired", objweapon);
    _id_113E50541ADBC51F = trysuperusebegin(objweapon);

    if(!istrue(_id_113E50541ADBC51F)) {
      refundsuper();
      continue;
    }

    self waittill("super_use_finished");
  }
}

_id_E16C077503BBB00F() {
  self endon("disconnect");
  self endon("super_use_finished");
  self notify("watchForSuperHold");
  self endon("watchForSuperHold");

  for(;;) {
    _id_19163E14365D9264 = getcurrentsuper();

    if(isDefined(self._id_333E1986ECF511BA))
      self._id_333E1986ECF511BA = undefined;

    self._id_333E1986ECF511BA = spawnStruct();
    childthread _id_C1B1E5BE45024C77(_id_19163E14365D9264);
    scripts\engine\utility::waittill_any_2("weapon_switch_started", "perkPackage_endThink");
    childthread _id_BAD0AA1C878DA781();
    childthread _id_45B568A3DC8BEADE();
    msg = scripts\engine\utility::waittill_any_return_2("superWeaponHoldFail", "superWeaponHoldSucceed");

    if(isDefined(msg) && msg == "superWeaponHoldSucceed") {
      if(isDefined(_id_19163E14365D9264) && isDefined(_id_19163E14365D9264.staticdata.weapon)) {
        objweapon = _id_19163E14365D9264.staticdata.weapon;

        if(self _meth_5304F90E15C214D2() || istrue(self._id_333E1986ECF511BA._id_77C833F50A563D4E)) {
          if(isDefined(_id_19163E14365D9264.staticdata._id_1BB8C2DE6198881A))
            self thread[[_id_19163E14365D9264.staticdata._id_1BB8C2DE6198881A]](objweapon);
        }
      }
    }
  }
}

_id_C1B1E5BE45024C77(_id_19163E14365D9264) {
  self endon("superHoldMonitoringOffhands");

  for(;;) {
    self waittill("offhand_pullback", weapon);
    _id_6CBF70934193B715 = 0;

    if(isDefined(_id_19163E14365D9264) && weapon.basename == _id_19163E14365D9264.staticdata.weapon)
      _id_6CBF70934193B715 = 1;

    if(_id_6CBF70934193B715) {
      self._id_333E1986ECF511BA._id_E8042A24357A2E1E = gettime();
      self._id_333E1986ECF511BA.objweapon = weapon;
    }

    waitframe();
  }
}

_id_45B568A3DC8BEADE() {
  waitframe();
  childthread _id_F605D1759FB37327();
  childthread _id_FABCA6D2E89350C5();
  childthread _id_6E3D8C7959967643();
  childthread _id_BE547DF7936C91DD();
}

_id_BE547DF7936C91DD() {
  self waittill("superWeaponForceHoldSucceed");
  wait 0.3;
  self notify("superWeaponHoldSucceed");
}

_id_F605D1759FB37327() {
  self endon("superWeaponHoldFail");
  self endon("superWeaponHoldSucceed");
  self endon("superWeaponForceHoldSucceed");
  self waittill("weapon_change");
  self notify("superWeaponHoldFail");
}

_id_FABCA6D2E89350C5() {
  self endon("superWeaponHoldFail");
  self endon("superWeaponHoldSucceed");
  self waittill("death");
  self notify("superWeaponHoldFail");
}

_id_6E3D8C7959967643() {
  self endon("superWeaponHoldFail");
  self endon("superWeaponForceHoldSucceed");
  self notify("superHoldMonitoringOffhands");
  objweapon = undefined;
  struct = self._id_333E1986ECF511BA;
  _id_503D210471627672 = 0;

  if(isDefined(struct._id_E8042A24357A2E1E)) {
    if(gettime() - struct._id_E8042A24357A2E1E < 500) {
      objweapon = struct.objweapon;
      _id_503D210471627672 = 1;
    }
  } else
    self waittill("offhand_pullback", objweapon);

  if(!isDefined(objweapon))
    self notify("superWeaponHoldFail");
  else {
    _id_4ADC98643BC5E471 = 1;

    if(!scripts\mp\utility\player::isreallyalive(self))
      _id_4ADC98643BC5E471 = 0;

    super = getcurrentsuper();

    if(isDefined(super) && objweapon.basename != super.staticdata.weapon)
      _id_4ADC98643BC5E471 = 0;

    if(!_id_3B64EB40368C1450::_id_E0751B03DFB9EB43("supers"))
      _id_4ADC98643BC5E471 = 0;

    if(_id_4ADC98643BC5E471) {
      if(_id_503D210471627672) {
        waitframe();
        self notify("superWeaponForceHoldSucceed");
        return;
      }

      self notify("superWeaponHoldSucceed");
      return;
      return;
    }

    self notify("superWeaponHoldFail");
  }
}

_id_BAD0AA1C878DA781() {
  self notify("checkSuperButtonHeld");
  self endon("checkSuperButtonHeld");
  counter = 0;

  while(self _meth_5304F90E15C214D2()) {
    self setclientomnvar("ui_super_activation_button_held", 1);

    if(counter >= 0.75) {
      self._id_333E1986ECF511BA._id_77C833F50A563D4E = 1;
      break;
    }

    counter = counter + level.framedurationseconds;
    waitframe();
  }

  self setclientomnvar("ui_super_activation_button_held", 0);
}

trysuperusebegin(objweapon) {
  if(!scripts\mp\utility\player::isreallyalive(self))
    return 0;

  if(objweapon.basename != getcurrentsuper().staticdata.weapon)
    return 0;

  if(!_id_3B64EB40368C1450::_id_E0751B03DFB9EB43("supers"))
    return 0;

  return beginsuperuse();
}

beginsuperuse() {
  self endon("disconnect");
  _id_19163E14365D9264 = getcurrentsuper();
  self notify("super_started");
  clientnum = self getentitynumber();
  _id_548072087C9FD504::_id_F63556DC2AA67FDC(3, clientnum, undefined);
  scripts\mp\gamelogic::sethasdonecombat(self, 1);

  if(_id_19163E14365D9264.staticdata.weapon == "support_box_mp")
    self playlocalsound("iw9_support_box_bring_up_plr_1");
  else if(_id_19163E14365D9264.staticdata.weapon == "tempv_mp" && soundexists("iw9_mtx_tb_stim_activate_plr")) {
    self playsoundtoplayer("iw9_mtx_tb_stim_activate_plr", self);

    if(isDefined(self.team) && soundexists("iw9_mtx_tb_stim_activate_npc"))
      self playsoundtoteam("iw9_mtx_tb_stim_activate_npc", self.team, self, self);
  }

  if(isDefined(_id_19163E14365D9264) && !_id_19163E14365D9264.isinuse) {
    _id_62E9AFC6790FF7B2 = !istrue(self.inlaststand) || istrue(_id_19163E14365D9264.staticdata.canuseinlaststand);
    _id_C0FE8DEE01B2ADAC(1);
    _id_1338411613704F7A = 1;

    if(isDefined(_id_19163E14365D9264.staticdata.useweapon)) {
      if(scripts\mp\arbitrary_up::isinarbitraryup() && superdisabledinarbitraryup(_id_19163E14365D9264.staticdata.ref)) {
        superdisabledinarbitraryupmessage();
        _id_1338411613704F7A = 0;
      } else if(!_id_62E9AFC6790FF7B2)
        _id_1338411613704F7A = 0;
      else
        _id_1338411613704F7A = trygiveuseweapon(_id_19163E14365D9264.staticdata.useweapon);
    }

    if(istrue(_id_1338411613704F7A) && istrue(_id_62E9AFC6790FF7B2)) {
      scripts\mp\utility\print::printgameaction("super use started - " + _id_19163E14365D9264.staticdata.ref, self);

      if(!isDefined(_id_19163E14365D9264.staticdata.beginusefunc) || istrue(self[[_id_19163E14365D9264.staticdata.beginusefunc]]())) {
        _id_C0FE8DEE01B2ADAC(0);
        _id_612C93CFB9F62839 = [];
        _id_612C93CFB9F62839[0] = "super_use_finished_lb";
        _id_612C93CFB9F62839[1] = "super_switched";
        setsuperbasepoints(0.0);
        setsuperextrapoints(0.0);
        setsuperisinuse(1);
        _id_330825804EBBD918(1);

        if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508())
          self._id_1066FBD86C88A6DF = 0;

        _id_19163E14365D9264.allowrefund = scripts\engine\utility::ter_op(_id_19163E14365D9264.staticdata.graceperiod > 0, 1, 0);
        _id_19163E14365D9264.usestarttime = gettime();
        _id_19163E14365D9264.usepercent = 1.0;
        self notify("super_use_started");
        thread _id_15FE9C03174D698D();
        _id_EA2A406D00E424F2();

        if(isDefined(self.matchdatalifeindex))
          scripts\mp\analyticslog::logevent_fieldupgradeactivated(self, _id_19163E14365D9264.staticdata.id);

        combatrecordsuperuse(_id_19163E14365D9264.staticdata.ref);
        scripts\mp\battlechatter_mp::_id_204AEBA40A2AA027(_id_19163E14365D9264.staticdata.ref);

        if(level.codcasterenabled)
          self setspecialactive(1);

        return 1;
      } else {
        setsuperbasepoints(0.0);
        setsuperextrapoints(0.0);
        refundsuper();
        _id_C0FE8DEE01B2ADAC(0);
        return 0;
      }
    } else {
      if(isDefined(_id_19163E14365D9264.staticdata.useweapon) && istrue(_id_1338411613704F7A))
        thread switchandtakesuperuseweapon();

      if(!istrue(_id_1338411613704F7A)) {
        _id_C0FE8DEE01B2ADAC(0);
        setsuperbasepoints(0.0);
        setsuperextrapoints(0.0);
        setsuperisinuse(1);
        superusefinished(1);
      }
    }

    if(_id_565913010C84FFCA())
      _id_C0FE8DEE01B2ADAC(0);
  }

  return 0;
}

_id_EA2A406D00E424F2() {
  _id_19163E14365D9264 = getcurrentsuper();
  _id_5C8E66E22B288B33 = _id_19163E14365D9264.staticdata._id_5C8E66E22B288B33;

  if(_id_5C8E66E22B288B33 == "ONUSE" || _id_5C8E66E22B288B33 == "TIME")
    thread updateusetimedecay();
  else if(_id_5C8E66E22B288B33 == "AMMO")
    thread _id_C4C44E009D4F4C6B();
  else
    return;
}

activatesuper(altmode, _id_1E71E1F458960B93) {
  _id_19163E14365D9264 = getcurrentsuper();

  if(!isDefined(altmode))
    altmode = 0;

  if(altmode && isDefined(_id_19163E14365D9264.staticdata.activatepenaltyalt))
    reducesuperusepercent(_id_19163E14365D9264.staticdata.activatepenaltyalt, _id_1E71E1F458960B93);
  else if(isDefined(_id_19163E14365D9264.staticdata.activatepenalty))
    reducesuperusepercent(_id_19163E14365D9264.staticdata.activatepenalty, _id_1E71E1F458960B93);

  return 1;
}

_id_15FE9C03174D698D() {
  self endon("disconnect");
  self endon("game_ended");
  self endon("super_use_finished");
  _id_19163E14365D9264 = getcurrentsuper();

  if(!isDefined(_id_19163E14365D9264.staticdata.usetime)) {
    return;
  }
  for(;;) {
    waitframe();
    success = 0;

    if(isbot(self)) {
      return;
    }
    success = _id_49983AFE0A8EB2B1();

    if(!success) {
      continue;
    }
    if(!issuperinuse()) {
      continue;
    }
    if(_id_C3479770FFEC05E2()) {
      continue;
    }
    _id_ED059DA2DFFA7B37 = _id_ADA5045140EE0FDF();

    if(!istrue(_id_ED059DA2DFFA7B37)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage"))
        self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("MP/SUPERS_UNAVAILABLE");
    }
  }
}

_id_49983AFE0A8EB2B1() {
  childthread _id_C4C39359EE1FDECB();
  childthread _id_E440752FBBED0DD5();
  childthread _id_885E7D0266B391EE();
  self waittill("superRepeatUse", msg);
  self notifyonplayercommandremove("tacButtonPress", "+smoke");
  self notifyonplayercommandremove("tacButtonPress", "+actionslot 1");
  self notifyonplayercommandremove("fragButtonPress", "+frag");
  self notifyonplayercommandremove("fragButtonPress", "+equip_toggle_throw");
  self notifyonplayercommandremove("repeatUseActivate", "+special");
  return msg == "success";
}

_id_C4C39359EE1FDECB() {
  self endon("superRepeatUse");
  self notifyonplayercommand("repeatUseActivate", "+special");
  self waittill("repeatUseActivate");
  self notify("superRepeatUse", "success");
}

_id_E440752FBBED0DD5() {
  self endon("superRepeatUse");
  self notifyonplayercommand("tacButtonPress", "+smoke");
  self notifyonplayercommand("fragButtonPress", "+frag");
  _id_BD1267E9DEA3DBA9 = ["tacButtonPress", "fragButtonPress"];
  thread _id_8D6D95114B2C9B0D(_id_BD1267E9DEA3DBA9, ["superRepeatUse"], 0.75);
  self waittill("controllerSuperPress", msg);
  self notify("superRepeatUse", msg);
}

_id_885E7D0266B391EE() {
  self endon("superRepeatUse");
  self notifyonplayercommand("tacButtonPress", "+actionslot 1");
  self notifyonplayercommand("fragButtonPress", "+equip_toggle_throw");
  _id_BD1267E9DEA3DBA9 = ["tacButtonPress", "fragButtonPress"];
  thread _id_8D6D95114B2C9B0D(_id_BD1267E9DEA3DBA9, ["superRepeatUse"], 0.75);
  self waittill("controllerSuperPress", msg);
  self notify("superRepeatUse", msg);
}

_id_8D6D95114B2C9B0D(_id_CF95E74FFD3666C0, _id_AD02F85B88A0B345, time) {
  level endon("game_ended");
  ent = spawnStruct();
  ent.threads = 0;

  foreach(_id_374D7614ECBD032A in _id_AD02F85B88A0B345)
  self endon(_id_374D7614ECBD032A);

  foreach(_id_989505A1920845A5 in _id_CF95E74FFD3666C0) {
    childthread scripts\engine\utility::waittill_string_no_endon_death(_id_989505A1920845A5, ent);
    ent.threads++;
  }

  while(ent.threads) {
    if(ent.threads == 1) {
      if(isDefined(time)) {
        ent childthread scripts\engine\utility::_id_2C91B6C857AA73CC(time);
        ent waittill("returned", msg);

        if(msg == "timeout")
          self notify("controllerSuperPress", "timeout");
        else
          self notify("controllerSuperPress", "success");

        ent.threads--;
      }

      continue;
    }

    ent waittill("returned", message);
    ent.threads--;
  }

  ent notify("die");
}

_id_ADA5045140EE0FDF() {
  if(!scripts\mp\utility\player::isreallyalive(self))
    return 0;

  if(!_id_3B64EB40368C1450::_id_E0751B03DFB9EB43("supers"))
    return 0;

  if(scripts\mp\utility\player::isusingremote())
    return 0;

  if(istrue(self.oob))
    return 0;

  if(self isonladder())
    return 0;

  if(self ismantling())
    return 0;

  if(!self isonground()) {
    if(self isparachuting() || self isinfreefall())
      return 0;
  }

  _id_19163E14365D9264 = getcurrentsuper();
  _id_ED059DA2DFFA7B37 = 0;

  if(isDefined(_id_19163E14365D9264.staticdata._id_E0AF69536A727F03))
    _id_ED059DA2DFFA7B37 = [[_id_19163E14365D9264.staticdata._id_E0AF69536A727F03]]();

  return _id_ED059DA2DFFA7B37;
}

_id_C4C44E009D4F4C6B() {
  self endon("disconnect");
  self endon("game_ended");
  self endon("super_use_finished");
  self endon("unset_super");
  _id_19163E14365D9264 = getcurrentsuper();
  _id_9ECEE1C8289B1282 = isDefined(_id_19163E14365D9264.staticdata.useweapon);
  useweaponclipammo = _id_19163E14365D9264.staticdata.useweaponclipammo;
  _id_0CCA155763701359 = _id_19163E14365D9264.staticdata._id_156B27CC0DA0F727;

  if((!_id_9ECEE1C8289B1282 || useweaponclipammo < 1) && _id_0CCA155763701359 <= 1) {
    return;
  }
  _id_068DB9F1CADCBCA4 = "weapon_fired";

  if(!_id_9ECEE1C8289B1282)
    _id_068DB9F1CADCBCA4 = "offhand_fired";

  _id_354F8655B711B4B1 = scripts\engine\utility::ter_op(_id_9ECEE1C8289B1282, _id_19163E14365D9264.staticdata.useweapon, _id_19163E14365D9264.staticdata.weapon);

  if(istrue(_id_19163E14365D9264.staticdata._id_FF2E3A3658646A3F))
    allowsuperweaponstow();

  _id_0569D925E5A25DF1 = _id_395A9CB3EBE25D55(_id_19163E14365D9264);
  _id_A1566100E7DF492E = _id_45C01CF6EBB2BA62();
  reducesuperusepercent(0.001 + _id_0569D925E5A25DF1 * _id_A1566100E7DF492E);
  updatesuperuiprogress();
  updatesuperuistate();
  _id_E20AB7A8971EE3F2();

  for(;;) {
    self waittill(_id_068DB9F1CADCBCA4, _id_637DE03F2C6B6C33);
    _id_A4496878854AE85B(_id_637DE03F2C6B6C33, _id_354F8655B711B4B1, _id_0569D925E5A25DF1);
  }
}

_id_A4496878854AE85B(_id_637DE03F2C6B6C33, _id_641083E829D5514C, _id_CF99553787BB9230) {
  _id_19163E14365D9264 = getcurrentsuper();

  if(!isDefined(_id_641083E829D5514C)) {
    if(!isDefined(_id_19163E14365D9264) || !isDefined(_id_19163E14365D9264.staticdata)) {
      return;
    }
    _id_641083E829D5514C = scripts\engine\utility::ter_op(isDefined(_id_19163E14365D9264.staticdata.useweapon), _id_19163E14365D9264.staticdata.useweapon, _id_19163E14365D9264.staticdata.weapon);
  }

  issameweapon = 0;

  if(isweapon(_id_637DE03F2C6B6C33))
    _id_637DE03F2C6B6C33 = _id_637DE03F2C6B6C33.basename;

  if(isweapon(_id_641083E829D5514C))
    _id_641083E829D5514C = _id_641083E829D5514C.basename;

  if(_id_637DE03F2C6B6C33 == _id_641083E829D5514C) {
    _id_22E13024DC2774E9();
    reducesuperusepercent(_id_CF99553787BB9230);
    updatesuperuiprogress();
    updatesuperuistate();
    _id_E20AB7A8971EE3F2();
  }
}

_id_45C01CF6EBB2BA62() {
  ammo = _id_3889D69492A93008();
  maxammo = getcurrentsuper().staticdata.useweaponstockammo + getcurrentsuper().staticdata.useweaponclipammo;
  _id_F98FD9B997C1DB22 = maxammo - ammo;
  return _id_F98FD9B997C1DB22;
}

_id_9AA5FDB675559E34() {
  _id_19163E14365D9264 = getcurrentsuper();

  if(!isDefined(self.super._id_2EBCBD70919376A7))
    _id_19163E14365D9264._id_2EBCBD70919376A7 = spawnStruct();

  _id_19163E14365D9264._id_2EBCBD70919376A7.clipammo = _id_19163E14365D9264.staticdata.useweaponclipammo;
  _id_19163E14365D9264._id_2EBCBD70919376A7.stockammo = _id_19163E14365D9264.staticdata.useweaponstockammo;
}

_id_60E9AB8C0AD6A01C(ammo, type) {
  _id_19163E14365D9264 = getcurrentsuper();

  if(!isDefined(_id_19163E14365D9264)) {
    return;
  }
  _id_B3A62EAAF1A88C6A = _id_19163E14365D9264._id_2EBCBD70919376A7;

  if(!isDefined(_id_B3A62EAAF1A88C6A)) {
    return;
  }
  useweapon = _id_19163E14365D9264.staticdata.useweapon;

  if(!isDefined(useweapon)) {
    return;
  }
  if(!isDefined(type))
    type = "all";

  _id_A7BE10E54A3A4B99 = weaponclipsize(useweapon);
  _id_02C0DC6323DDFA44 = 0;

  if(type == "clip" || type == "all") {
    if(ammo > _id_A7BE10E54A3A4B99) {
      _id_02C0DC6323DDFA44 = ammo - _id_A7BE10E54A3A4B99;
      ammo = _id_A7BE10E54A3A4B99;
    }

    _id_B3A62EAAF1A88C6A.clipammo = ammo;
  }

  if(type == "stock")
    _id_B3A62EAAF1A88C6A.stockammo = ammo;
  else if(type == "clip")
    _id_B3A62EAAF1A88C6A.stockammo = _id_B3A62EAAF1A88C6A.stockammo + _id_02C0DC6323DDFA44;
  else if(type == "all")
    _id_B3A62EAAF1A88C6A.stockammo = _id_02C0DC6323DDFA44;
  else {}
}

_id_52E340D32E36DF3E() {
  return isDefined(self.super) && isDefined(self.super._id_2EBCBD70919376A7);
}

_id_C2432256B64355CE() {
  _id_19163E14365D9264 = getcurrentsuper();

  if(!isDefined(_id_19163E14365D9264))
    return 0;

  _id_B3A62EAAF1A88C6A = _id_19163E14365D9264._id_2EBCBD70919376A7;

  if(!isDefined(_id_B3A62EAAF1A88C6A))
    return 0;

  return _id_B3A62EAAF1A88C6A.clipammo;
}

_id_1F4B9F3AD4696DB6() {
  _id_19163E14365D9264 = getcurrentsuper();

  if(!isDefined(_id_19163E14365D9264))
    return 0;

  _id_B3A62EAAF1A88C6A = _id_19163E14365D9264._id_2EBCBD70919376A7;

  if(!isDefined(_id_B3A62EAAF1A88C6A))
    return 0;

  return _id_B3A62EAAF1A88C6A.stockammo;
}

_id_3889D69492A93008() {
  _id_19163E14365D9264 = getcurrentsuper();

  if(!isDefined(_id_19163E14365D9264))
    return 0;

  _id_B3A62EAAF1A88C6A = _id_19163E14365D9264._id_2EBCBD70919376A7;

  if(!isDefined(_id_B3A62EAAF1A88C6A))
    return 0;

  return _id_B3A62EAAF1A88C6A.stockammo + _id_B3A62EAAF1A88C6A.clipammo;
}

_id_36246FA2B22036AB() {
  _id_19163E14365D9264 = getcurrentsuper();

  if(!isDefined(_id_19163E14365D9264)) {
    return;
  }
  _id_19163E14365D9264._id_2EBCBD70919376A7 = undefined;
}

_id_22E13024DC2774E9() {
  _id_19163E14365D9264 = getcurrentsuper();
  useweapon = _id_19163E14365D9264.staticdata.useweapon;

  if(!isDefined(useweapon)) {
    return;
  }
  clipammo = self getweaponammoclip(useweapon);
  stockammo = self getweaponammostock(useweapon);
  _id_60E9AB8C0AD6A01C(clipammo + stockammo, "all");
}

updateusetimedecay() {
  self endon("disconnect");
  self endon("game_ended");
  self endon("super_use_finished");
  self endon("unset_super");
  _id_19163E14365D9264 = getcurrentsuper();

  if(!isDefined(_id_19163E14365D9264.staticdata.usetime)) {
    waitframe();
    superusefinished();
    return;
  }

  if(_id_19163E14365D9264.staticdata.usetime < 0) {
    return;
  }
  for(;;) {
    waitframe();

    if(isDefined(_id_19163E14365D9264.staticdata.usedelay)) {
      _id_BC1CE52AF9E40E95 = gettime() - _id_19163E14365D9264.usestarttime;

      if(_id_BC1CE52AF9E40E95 < _id_19163E14365D9264.staticdata.usedelay)
        continue;
    }

    _id_316D57EB627E7273 = level.framedurationseconds / _id_19163E14365D9264.staticdata.usetime;
    reducesuperusepercent(_id_316D57EB627E7273);
    updatesuperuiprogress();
    updatesuperuistate();
    _id_E20AB7A8971EE3F2();
  }
}

reducesuperusepercent(_id_631A8A84E35497BB, _id_1E71E1F458960B93, _id_80BD4DD71B59356B) {
  _id_19163E14365D9264 = getcurrentsuper();
  _id_19163E14365D9264.usepercent = max(_id_19163E14365D9264.usepercent - _id_631A8A84E35497BB, 0.0);

  if(istrue(_id_1E71E1F458960B93))
    _id_19163E14365D9264.allowrefund = 0;

  if(!isDefined(_id_80BD4DD71B59356B) || _id_80BD4DD71B59356B == 0)
    superusedurationupdated();
}

_id_0A2A1403D5924109(_id_2BF3C98575BA0BE1) {
  _id_19163E14365D9264 = getcurrentsuper();
  _id_B4588F310900DBA5 = _id_19163E14365D9264.usepercent + _id_2BF3C98575BA0BE1;
  _id_19163E14365D9264.usepercent = clamp(_id_B4588F310900DBA5, 0.0, 1.0);
  return _id_B4588F310900DBA5;
}

_id_7C67C8E12DB38300(_id_CC748B6D457627FE) {
  _id_19163E14365D9264 = getcurrentsuper();
  _id_211A8547BB6AB09A = _id_19163E14365D9264.staticdata.usetime;

  if(!isDefined(_id_CC748B6D457627FE))
    return 0;

  if(_id_CC748B6D457627FE <= 0.0)
    return 0;

  if(_id_CC748B6D457627FE > _id_211A8547BB6AB09A)
    _id_CC748B6D457627FE = _id_211A8547BB6AB09A;

  _id_2BF3C98575BA0BE1 = 0;

  if(_id_211A8547BB6AB09A > 0)
    _id_2BF3C98575BA0BE1 = _id_CC748B6D457627FE / _id_211A8547BB6AB09A;

  _id_0A2A1403D5924109(_id_2BF3C98575BA0BE1);
}

resetsuperusepercent() {
  _id_19163E14365D9264 = getcurrentsuper();
  _id_19163E14365D9264.usepercent = 1.0;
  superusedurationupdated();
}

superusedurationupdated() {
  _id_19163E14365D9264 = getcurrentsuper();

  if(_id_19163E14365D9264.usepercent <= 0.0)
    superusefinished();
}

superusefinished(_id_3179AFAA208DEFA2, _id_FCEF8D217A441961, _id_E68637FB8C1C346B, _id_E743A22765D93795, attacker, _id_704294F906FAD67E) {
  _id_19163E14365D9264 = getcurrentsuper();
  self notify("super_use_finished_lb");
  clientnum = self getentitynumber();
  _id_548072087C9FD504::_id_F63556DC2AA67FDC(4, clientnum, undefined);

  if(isDefined(_id_19163E14365D9264)) {
    _id_F5AF0B5D26948D94 = 0;

    if(!istrue(_id_3179AFAA208DEFA2) && !istrue(_id_E743A22765D93795))
      _id_F5AF0B5D26948D94 = shouldrefundsuper();

    setsuperisinuse(0);
    _id_330825804EBBD918(0);
    _id_19163E14365D9264.canstow = 0;
    _id_E2C5BB15593B4812 = undefined;

    if(isDefined(_id_19163E14365D9264.staticdata.endusefunc)) {
      if(!isDefined(_id_FCEF8D217A441961))
        _id_FCEF8D217A441961 = 0;

      _id_E2C5BB15593B4812 = self[[_id_19163E14365D9264.staticdata.endusefunc]](_id_FCEF8D217A441961, attacker);
    }

    if(_id_F5AF0B5D26948D94 || istrue(_id_3179AFAA208DEFA2) || istrue(_id_E2C5BB15593B4812)) {
      setsuperexpended(0);
      refundsuper();
    } else if(istrue(_id_E68637FB8C1C346B)) {
      setsuperexpended(0);
      _id_8F0A7C929337D710 = getsuperpointsneeded() * _id_19163E14365D9264.usepercent;
      _id_19163E14365D9264.wasrefunded = 1;
      setsuperbasepoints(_id_8F0A7C929337D710);
    } else if(istrue(self._id_678855513F5076CA) && scripts\mp\perks\perkfunctions::_id_66F0CBD5FF8458FE()) {
      setsuperexpended(0);
      setsuperbasepoints(self._id_A68B289A82138067);
      _id_08C7B1312CF5986B(0.0);
      _id_19163E14365D9264.lastfinishtime = gettime();
      _id_19163E14365D9264.wasrefunded = 0;
    } else if(!istrue(_id_704294F906FAD67E)) {
      thread _id_E648B6FC93BBC0E0();
      _id_19163E14365D9264.lastfinishtime = gettime();
      _id_19163E14365D9264.wasrefunded = 0;
    }

    thread switchandtakesuperuseweapon(1, 1);

    if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {
      if(!level.allowsupers && !isDefined(self._id_678855513F5076CA)) {
        if(!istrue(_id_3179AFAA208DEFA2)) {
          self setclientomnvar("ui_perk_package_state", 0);
          thread _id_93B5448EA8F6277B(0);
          _id_0B7A9CE0A2282B79::_id_351FE4AC57CA37E5(self, "super");
          self._id_1066FBD86C88A6DF = 0;

          if(_id_F95BCCA44E8CBA53(_id_19163E14365D9264.staticdata.ref))
            clearsuper();
        }
      } else if(isDefined(_id_19163E14365D9264.staticdata.brsingleuse) || _id_F95BCCA44E8CBA53(_id_19163E14365D9264.staticdata.ref)) {
        clearsuper();
        thread _id_93B5448EA8F6277B(0);
        thread _id_BDCBE42D37001209(0);
      }
    }

    if(isDefined(_id_19163E14365D9264.usestarttime) && isDefined(_id_19163E14365D9264.madeavailabletime)) {
      _id_208A9BD22D08B9DB = _id_19163E14365D9264.usestarttime - _id_19163E14365D9264.madeavailabletime;
      scripts\mp\analyticslog::logevent_superended(_id_19163E14365D9264.staticdata.ref, _id_208A9BD22D08B9DB, 0, _id_19163E14365D9264.numkills);
    }

    scripts\mp\utility\print::printgameaction("super use ended - " + _id_19163E14365D9264.staticdata.ref, self);
  }

  if(level.codcasterenabled)
    self setspecialactive(0);

  level._id_44C84134585AB85B = 1;
  self notify("super_use_finished");
}

_id_E648B6FC93BBC0E0() {
  level endon("game_ended");
  self endon("disconnect");
  setsuperexpended(1);
  waitframe();
  setsuperexpended(0);
}

refundsuper() {
  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {
    if(isDefined(self.equipment["super"]))
      _id_7E52B56769FA7774::_id_1615EAEC0C470F4F(self.equipment["super"], self.super.staticdata.ref);
  } else {
    _id_19163E14365D9264 = getcurrentsuper();

    if(isDefined(_id_19163E14365D9264)) {
      self.super.wasrefunded = 1;

      if(_id_19163E14365D9264.isinuse)
        superusefinished(0);

      givesuperpoints(getsuperpointsneeded(), undefined, undefined, undefined, undefined, 1);
      self setweaponammoclip(_id_19163E14365D9264.staticdata.weapon, 1);
    }
  }
}

handledeath(attacker) {
  self endon("disconnect");

  if(!issuperinuse()) {
    return;
  }
  _id_19163E14365D9264 = getcurrentsuper();
  _id_3179AFAA208DEFA2 = _id_19163E14365D9264.staticdata.refundondeath;
  _id_80B52426E4D315E0 = _id_19163E14365D9264.staticdata._id_80B52426E4D315E0;

  if(!istrue(_id_80B52426E4D315E0))
    superusefinished(_id_3179AFAA208DEFA2, 1, undefined, undefined, attacker);
}

monitoruseweaponfiring(_id_354F8655B711B4B1) {
  self endon("death_or_disconnect");
  self endon("super_use_finished");
  self endon("remove_super");

  for(;;) {
    self waittill("weapon_fired", objweapon);

    if(issameweapon(objweapon, _id_354F8655B711B4B1, 1)) {}
  }
}

trygiveuseweapon(useweapon, clipammo, stockammo) {
  self endon("death_or_disconnect");
  scripts\cp_mp\utility\inventory_utility::_giveweapon(useweapon);

  if(!isDefined(clipammo))
    clipammo = _id_C2432256B64355CE();

  if(!isDefined(stockammo))
    stockammo = _id_1F4B9F3AD4696DB6();

  if(clipammo + stockammo == 0)
    return 0;

  self setweaponammoclip(useweapon, clipammo);
  self setweaponammostock(useweapon, stockammo);
  _id_3B64EB40368C1450::set("superWeapon", "usability", 0);
  _id_41BF9BF4918115AC = scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(useweapon, isbot(self));
  _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("superWeapon");

  if(_id_41BF9BF4918115AC) {
    thread _id_573F49BB5D5A86EA(useweapon);
    _id_22E13024DC2774E9();
    return 1;
  }

  scripts\cp_mp\utility\inventory_utility::abortmonitoredweaponswitch(useweapon);
  return 0;
}

manageuseweapon(useweapon) {
  self endon("death_or_disconnect");
  self endon("super_use_finished");
  _id_19163E14365D9264 = getcurrentsuper();
  _id_19163E14365D9264.useweaponswapped = undefined;
  _id_9DE0EA5672C044FC = 0;

  for(;;) {
    weapon = self getcurrentweapon();

    if(!istrue(_id_19163E14365D9264.canstow) && !issameweapon(useweapon, weapon, 1)) {
      if(weapon.basename == "iw7_uplinkball_mp" || weapon.basename == "iw7_tdefball_mp")
        _id_9DE0EA5672C044FC = 1;

      break;
    }

    waitframe();
  }

  if(issuperinuse()) {
    _id_19163E14365D9264.useweaponswapped = 1;
    superusefinished(undefined, undefined, _id_9DE0EA5672C044FC);
  }
}

_id_FF3B77706565DACF(useweapon, _id_DD515FCF025B2E79) {
  if(!issameweapon(useweapon, _id_DD515FCF025B2E79, 1) && _id_DD515FCF025B2E79.basename != "iw9_knifestab_mp" && _id_DD515FCF025B2E79.basename != "iw9_lm_dblmg_execution_mp" && _id_DD515FCF025B2E79.basename != "iw9_gunless" && _id_DD515FCF025B2E79.basename != "none")
    return 1;
  else
    return 0;
}

_id_573F49BB5D5A86EA(useweapon) {
  self endon("death_or_disconnect");
  self endon("super_use_finished");
  self waittill("weapon_change", useweapon);

  for(;;) {
    self waittill("weapon_change", _id_DD515FCF025B2E79);
    weapon = self getcurrentweapon();

    if(_id_FF3B77706565DACF(useweapon, _id_DD515FCF025B2E79)) {
      switchandtakesuperuseweapon(1);
      return;
    }
  }
}

switchandtakesuperuseweapon(_id_A7FF1C3453C52053, _id_BD73A31917F54451) {
  self endon("death");
  _id_19163E14365D9264 = getcurrentsuper();
  useweapon = _id_19163E14365D9264.staticdata.useweapon;

  if(!isDefined(useweapon)) {
    return;
  }
  if(istrue(_id_A7FF1C3453C52053) && issameweapon(self getcurrentweapon(), useweapon))
    _id_22E13024DC2774E9();

  if(scripts\cp_mp\utility\inventory_utility::isswitchingtoweaponwithmonitoring(useweapon))
    scripts\cp_mp\utility\inventory_utility::abortmonitoredweaponswitch(useweapon);

  if(istrue(_id_BD73A31917F54451))
    self notify("super_switched");

  scripts\cp_mp\utility\inventory_utility::getridofweapon(useweapon);

  if(!istrue(_id_BD73A31917F54451))
    _id_330825804EBBD918(0);
}

storesuperpoints() {
  _id_19163E14365D9264 = getcurrentsuper();

  if(!isDefined(_id_19163E14365D9264)) {
    return;
  }
  if(issupercharging() || issuperready()) {
    self.pers["superBasePoints"] = _id_19163E14365D9264.basepoints;
    self.pers["superExtraPoints"] = _id_19163E14365D9264.extrapoints;
  } else if(issuperinuse() && shouldrefundsuper()) {
    pointsneeded = getsuperpointsneeded();
    self.pers["superPoints"] = _id_19163E14365D9264.usepercent * pointsneeded;
    self.pers["superExtraPoints"] = 0;
  } else {
    self.pers["superBasePoints"] = 0;
    self.pers["superExtraPoints"] = 0;
  }
}

getsuperuseuiprogress() {
  _id_19163E14365D9264 = getcurrentsuper();
  return _id_19163E14365D9264.usepercent;
}

getcurrentsuperbasepoints() {
  return getcurrentsuper().basepoints;
}

getcurrentsuperextrapoints() {
  return getcurrentsuper().basepoints;
}

getcurrentsuperpoints() {
  _id_19163E14365D9264 = getcurrentsuper();
  return _id_19163E14365D9264.basepoints + _id_19163E14365D9264.extrapoints;
}

getsuperpointsneeded() {
  _id_19163E14365D9264 = getcurrentsuper();
  pointsneeded = 0;

  if(isDefined(_id_19163E14365D9264))
    pointsneeded = _id_19163E14365D9264.staticdata.pointsneeded;

  if(isDefined(self.perkpackagedata.overridepointsneeded))
    pointsneeded = self.perkpackagedata.overridepointsneeded;

  return pointsneeded;
}

issuperready() {
  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508())
    return self._id_1066FBD86C88A6DF;
  else {
    _id_19163E14365D9264 = getcurrentsuper();

    if(!isDefined(_id_19163E14365D9264) || _id_19163E14365D9264.isinuse)
      return 0;

    return getcurrentsuperpoints() >= getsuperpointsneeded();
  }
}

_id_6C06220F8B5B7079() {
  _id_19163E14365D9264 = getcurrentsuper();

  if(!isDefined(_id_19163E14365D9264) || _id_19163E14365D9264.isinuse)
    return 0;

  if(!isDefined(self._id_A68B289A82138067) || !scripts\mp\utility\perk::_hasperk("specialty_overcharge_field_upgrade"))
    return 0;

  return self._id_A68B289A82138067 >= getsuperpointsneeded();
}

_id_C3479770FFEC05E2() {
  return isDefined(getcurrentsuper()) && getcurrentsuper().isactive;
}

issuperinuse() {
  return isDefined(getcurrentsuper()) && getcurrentsuper().isinuse;
}

_id_565913010C84FFCA() {
  return istrue(self._id_65BD32C9DF8D4292);
}

_id_C0FE8DEE01B2ADAC(_id_623C13007339EC2F) {
  self._id_65BD32C9DF8D4292 = _id_623C13007339EC2F;
}

setsuperisinuse(isinuse) {
  _id_19163E14365D9264 = getcurrentsuper();
  _id_19163E14365D9264.isinuse = isinuse;
  updatesuperuistate();
}

_id_330825804EBBD918(isactive) {
  _id_19163E14365D9264 = getcurrentsuper();
  _id_19163E14365D9264.isactive = isactive;

  if(!isactive && issuperinuse())
    self setclientomnvar("ui_super_can_use", 1);
  else
    self setclientomnvar("ui_super_can_use", 0);
}

issupercharging() {
  return !issuperready() && !issuperinuse();
}

issuperexpended() {
  return istrue(self.pers["superExpended"]);
}

_id_F95BCCA44E8CBA53(_id_EBEC497FF8B18A45) {
  if(!isDefined(_id_EBEC497FF8B18A45))
    return 0;

  if(!isDefined(level._id_3E969A1CC0AD79CC))
    return 0;

  if(!scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508())
    return 0;

  return scripts\engine\utility::array_contains(level._id_3E969A1CC0AD79CC, _id_EBEC497FF8B18A45);
}

setsuperexpended(_id_A6B84F600DC33630) {
  self.pers["superExpended"] = _id_A6B84F600DC33630;
  updatesuperuistate();
}

getcurrentsuper() {
  return self.super;
}

getcurrentsuperref() {
  _id_19163E14365D9264 = getcurrentsuper();

  if(!isDefined(_id_19163E14365D9264))
    return undefined;

  return _id_19163E14365D9264.staticdata.ref;
}

shouldrefundsuper() {
  _id_19163E14365D9264 = getcurrentsuper();
  graceperiod = _id_19163E14365D9264.staticdata.graceperiod;

  if(!isDefined(_id_19163E14365D9264.usestarttime))
    return 0;

  _id_BC1CE52AF9E40E95 = gettime() - _id_19163E14365D9264.usestarttime;

  if(_id_BC1CE52AF9E40E95 >= graceperiod)
    return 0;

  if(_id_19163E14365D9264.numkills > 0)
    return 0;

  return _id_19163E14365D9264.allowrefund;
}

getsuperrefforsuperuseweapon(weapon) {
  if(!isstring(weapon))
    weapon = weapon.basename;

  if(!isDefined(level.superglobals) || !isDefined(level.superglobals.superweapons) || !isDefined(level.superglobals.superweapons[weapon]))
    return undefined;

  return level.superglobals.superweapons[weapon].ref;
}

getsuperrefforsuperoffhand(weapon) {
  if(!isstring(weapon))
    weapon = weapon.basename;

  if(!isDefined(level.superglobals.supersbyoffhand[weapon]))
    return undefined;

  return level.superglobals.supersbyoffhand[weapon].ref;
}

getsuperrefforsuperextraweapon(weapon) {
  if(!isstring(weapon))
    weapon = weapon.basename;

  if(!isDefined(level.superglobals.supersbyextraweapon[weapon]))
    return undefined;

  return level.superglobals.supersbyextraweapon[weapon].ref;
}

getsuperrefforsuperweapon(weapon) {
  if(!isDefined(level.superglobals))
    return undefined;

  if(!isstring(weapon))
    weapon = weapon.basename;

  _id_1F2530C9FC4163FB = getsuperrefforsuperuseweapon(weapon);

  if(isDefined(_id_1F2530C9FC4163FB))
    return _id_1F2530C9FC4163FB;

  _id_6733DE10D9782C78 = getsuperrefforsuperoffhand(weapon);

  if(isDefined(_id_6733DE10D9782C78))
    return _id_6733DE10D9782C78;

  _id_6733DE10D9782C78 = getsuperrefforsuperextraweapon(weapon);

  if(isDefined(_id_6733DE10D9782C78))
    return _id_6733DE10D9782C78;

  switch (weapon) {
    case "tac_insert_trigger":
      return "super_tac_insert";
    case "deploy_loadout_drop_mp":
      return "super_loadout_drop";
    case "super_laser_charge_mp":
      return "super_laser_charge";
  }

  return undefined;
}

shouldtracksuperweaponstats(objweapon) {
  ref = getsuperrefforsuperweapon(objweapon);

  if(isDefined(ref)) {
    data = level.superglobals.staticsuperdata[ref];
    return data.useweapontrackstats;
  }

  return undefined;
}

getsuperid(_id_EBEC497FF8B18A45) {
  if(!isDefined(_id_EBEC497FF8B18A45) || !isDefined(level.superglobals) || !isDefined(level.superglobals.staticsuperdata) || !isDefined(level.superglobals.staticsuperdata[_id_EBEC497FF8B18A45]) || _id_EBEC497FF8B18A45 == "none")
    return 0;

  return level.superglobals.staticsuperdata[_id_EBEC497FF8B18A45].id;
}

getmovespeedforsuperweapon(objweapon) {
  ref = getsuperrefforsuperweapon(objweapon);

  if(!isDefined(ref))
    return undefined;

  return level.superglobals.staticsuperdata[ref].movespeed;
}

getrootsuperref(_id_EBEC497FF8B18A45) {
  return getsubstr(_id_EBEC497FF8B18A45, 6);
}

_id_EB25267EE439CABE(_id_EBEC497FF8B18A45) {
  if(isDefined(level.superglobals.staticsuperdata[_id_EBEC497FF8B18A45]))
    return level.superglobals.staticsuperdata[_id_EBEC497FF8B18A45].weapon;

  return undefined;
}

_id_83A68723ACC3296D(weaponname) {
  _id_EBEC497FF8B18A45 = getsuperrefforsuperoffhand(weaponname);

  if(isDefined(_id_EBEC497FF8B18A45)) {
    _id_FBBB3212817D1D40 = level.superglobals.staticsuperdata[_id_EBEC497FF8B18A45];

    if(isDefined(_id_FBBB3212817D1D40))
      return _id_FBBB3212817D1D40._id_D442547D75DFFD09;
  }

  return undefined;
}

_id_BF9C7E9DD30180E3(_id_EBEC497FF8B18A45) {
  _id_FBBB3212817D1D40 = level.superglobals.staticsuperdata[_id_EBEC497FF8B18A45];

  if(isDefined(_id_FBBB3212817D1D40))
    return _id_FBBB3212817D1D40._id_D442547D75DFFD09;

  return undefined;
}

_id_5CC7D8C432D5D6C1(_id_EBEC497FF8B18A45) {
  _id_FBBB3212817D1D40 = level.superglobals.staticsuperdata[_id_EBEC497FF8B18A45];

  if(isDefined(_id_FBBB3212817D1D40))
    return _id_FBBB3212817D1D40._id_94DEAC09D462D41E;

  return undefined;
}

_id_C519AE03535AFE0F(_id_EBEC497FF8B18A45) {
  _id_FBBB3212817D1D40 = level.superglobals.staticsuperdata[_id_EBEC497FF8B18A45];

  if(isDefined(_id_FBBB3212817D1D40))
    return _id_FBBB3212817D1D40._id_41F94BCA374ED58A;

  return undefined;
}

allowsuperweaponstow() {
  _id_19163E14365D9264 = getcurrentsuper();

  if(!isDefined(_id_19163E14365D9264) || !_id_19163E14365D9264.isinuse) {
    return;
  }
  _id_19163E14365D9264.canstow = 1;
}

unstowsuperweapon() {
  _id_19163E14365D9264 = getcurrentsuper();

  if(!isDefined(_id_19163E14365D9264) || !_id_19163E14365D9264.canstow) {
    return;
  }
  if(!_id_19163E14365D9264.isinuse || !isDefined(_id_19163E14365D9264.staticdata.useweapon)) {
    _id_19163E14365D9264.canstow = 0;
    return;
  }

  scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(_id_19163E14365D9264.staticdata.useweapon);
  _id_19163E14365D9264.canstow = 0;
}

getsuperpointsforevent(eventref) {
  if(!_func_D03495FE6418377B(eventref))
    eventref = _func_1823FF50BB28148D(eventref);

  points = level._id_07DE15B4C7F0A425[eventref];

  if(!isDefined(points))
    return 0;

  return points;
}

watchforgameend() {
  level waittill("game_ended");

  if(scripts\mp\utility\game::waslastround()) {
    foreach(player in level.players)
    player writesppmstats();
  }
}

getsppmdata() {
  if(getdvarint("dvar_A3220D5D00C60FC0", 0) == 0) {
    return;
  }
  if(isai(self)) {
    return;
  }
  if(!isDefined(self.sppmdata)) {
    self.sppmdata = self.pers["sppmData"];

    if(!isDefined(self.sppmdata)) {
      self.sppmdata = spawnStruct();
      self.sppmdata.totalpoints = 0;
      self.sppmdata.totalappliedpoints = 0;
      self.sppmdata.eventtotals = [];
      self.pers["sppmData"] = self.sppmdata;
    }
  }

  return self.sppmdata;
}

updatesppm(_id_EB5674A0EF8654D5, _id_F3B601E04DE761D9, eventref) {
  if(getdvarint("dvar_A3220D5D00C60FC0", 0) == 0) {
    return;
  }
  if(isai(self)) {
    return;
  }
  data = getsppmdata();
  data.totalpoints = data.totalpoints + _id_EB5674A0EF8654D5;

  if(istrue(_id_F3B601E04DE761D9))
    data.totalappliedpoints = data.totalappliedpoints + _id_EB5674A0EF8654D5;

  if(!isDefined(eventref))
    eventref = "undefined";

  if(!isDefined(data.eventtotals[eventref]))
    data.eventtotals[eventref] = _id_EB5674A0EF8654D5;
  else
    data.eventtotals[eventref] = data.eventtotals[eventref] + _id_EB5674A0EF8654D5;
}

writesppmstats() {
  if(getdvarint("dvar_A3220D5D00C60FC0", 0) == 0) {
    return;
  }
  if(isai(self)) {
    return;
  }
  data = getsppmdata();
  totaltime = scripts\mp\persistence::statgetchildbuffered("round", "timePlayed", 1) / 60.0;
  _id_0C54C0B1A2285761 = 0.0;
  _id_C0448B56FA05D6DE = 0.0;

  if(totaltime > 0.0) {
    _id_0C54C0B1A2285761 = data.totalpoints / totaltime;
    _id_C0448B56FA05D6DE = data.totalappliedpoints / totaltime;
  }

  _id_D69631AC0FDCF541 = "";
  _id_BE43446B63CC7949 = -1;

  foreach(event, _id_45392372249B4D3B in data.eventtotals) {
    if(_id_45392372249B4D3B > _id_BE43446B63CC7949) {
      _id_BE43446B63CC7949 = _id_45392372249B4D3B;
      _id_D69631AC0FDCF541 = event;
    }
  }

  if(_func_D03495FE6418377B(_id_D69631AC0FDCF541))
    _id_D69631AC0FDCF541 = _func_0F28FD66285FA2C9(_id_D69631AC0FDCF541);

  dlog_recordevent("mpscript_sppm", ["sppm", _id_0C54C0B1A2285761, "sppm_applied", _id_C0448B56FA05D6DE, "gamemode", scripts\mp\utility\game::getgametype(), "kills", self.kills, "time_played", totaltime, "best_event", _id_D69631AC0FDCF541, "script_version", getscriptdataversion()]);
}

modifysuperequipmentdamage(attacker, objweapon, type, damage, idflags) {
  _id_702BFC08FABD86CB = damage;

  if(isDefined(self.owner) && isDefined(attacker) && attacker == self.owner)
    _id_702BFC08FABD86CB = int(ceil(damage * 0.5));

  return _id_702BFC08FABD86CB;
}

updateactivesupers(einflictor, attacker, victim, idamage, smeansofdeath, objweapon, shitloc, vdir) {
  _id_C3A55EE9F23FB616 = isDefined(einflictor) && isPlayer(einflictor);
  _id_D758F68157FEBC76 = objweapon.basename == "throwingknife_mp" || objweapon.basename == "throwingknife_fire_mp" || objweapon.basename == "throwingknife_electric_mp" || objweapon.basename == "shuriken_mp" || objweapon.basename == "throwstar_mp";
  _id_4F5E5BF85BDB8C7A = _id_D758F68157FEBC76 && isDefined(einflictor) && isDefined(einflictor.classname) && einflictor.classname == "grenade";
  _id_99D1ABC1148A35AD = isDefined(attacker) && isPlayer(attacker) && attacker != victim;

  if(_id_99D1ABC1148A35AD) {
    _id_7639389406E14C2E = attacker getcurrentsuper();

    if(_id_C3A55EE9F23FB616 || _id_4F5E5BF85BDB8C7A) {
      if(isDefined(_id_7639389406E14C2E) && attacker issuperinuse() && isPlayer(victim) && scripts\cp_mp\utility\player_utility::playersareenemies(attacker, victim)) {
        if(_id_7639389406E14C2E.staticdata.ref == "super_deadsilence")
          attacker thread scripts\mp\supers\super_deadsilence::superdeadsilence_onkill();

        if(_id_7639389406E14C2E.staticdata.ref == "super_battlerage")
          attacker thread _id_19FD5B5D73D44C18::_id_FE088CDEA420C6D6();
      }
    }

    if(_id_C3A55EE9F23FB616) {
      if(einflictor scripts\mp\utility\perk::_hasperk("specialty_bulletdamage"))
        attacker thread scripts\mp\supers\super_stoppingpower::stoppingpower_onkill(objweapon);

      if(einflictor scripts\mp\utility\perk::_hasperk("specialty_bulletsuppress") && scripts\mp\utility\perk::_hasperk("specialty_bulletpenetration"))
        attacker thread _id_4BEF961309209288::_id_8F9A9C04E9E4B5AF(objweapon);
    }
  }
}

watchsuperdelay() {
  level endon("super_delay_end");
  level endon("round_end");
  level endon("game_ended");

  if(scripts\mp\utility\game::isanymlgmatch())
    level.superdelay = 0;
  else
    level.superdelay = getdvarfloat("scr_superdelay", 0);

  if(!scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508())
    scripts\mp\flags::gameflagwait("prematch_done");

  if(level.superdelay == 0) {
    level.superdelaystarttime = gettime();
    level.superdelayendtime = level.superdelaystarttime;
    level notify("super_delay_end");
  }

  level.superdelaystarttime = gettime();
  level.superdelayendtime = level.superdelaystarttime + level.superdelay * 1000;
  level notify("super_delay_start");

  while(gettime() < level.superdelayendtime)
    waitframe();

  level notify("super_delay_end");
}

watchplayersuperdelayweapon() {
  level endon("round_end");
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("clearedAllows");
  self notify("watchPlayerSuperDelayWeapon");

  if(superdelaypassed()) {
    return;
  }
  _id_3B64EB40368C1450::set("super_delay", "supers", 0);
  scripts\engine\utility::waittill_any_ents(level, "super_delay_end", self, "watchPlayerSuperDelayWeapon");
  _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("super_delay");
}

superdelaypassed() {
  return isDefined(level.superdelayendtime) && gettime() >= level.superdelayendtime;
}

cancelsuperdelay() {
  level.superdelay = 0;
  level.superdelaystarttime = gettime();
  level.superdelayendtime = level.superdelaystarttime;
  level notify("super_delay_end");
}

givesuperweapon(_id_19163E14365D9264) {
  if(!self hasweapon(_id_19163E14365D9264.staticdata.weapon)) {
    ammo = scripts\engine\utility::ter_op(issuperready(), 1, 0);
    scripts\cp_mp\utility\inventory_utility::_giveweapon(_id_19163E14365D9264.staticdata.weapon);
    self setweaponammoclip(_id_19163E14365D9264.staticdata.weapon, ammo);
    self assignweaponoffhandspecial(_id_19163E14365D9264.staticdata.weapon);
  }
}

issuperdisabled() {
  return !_id_3B64EB40368C1450::_id_E0751B03DFB9EB43("supers");
}

watchobjuse(_id_268CA64E50C8CE7F, _id_01507E598E016EB8) {
  self endon("death_or_disconnect");
  self endon("obj_drain_end");
  self endon("ball_dropped");

  if(scripts\mp\utility\game::getgametype() == "sd" || scripts\mp\utility\game::getgametype() == "sr" || scripts\mp\utility\game::getgametype() == "dd") {
    if(istrue(_id_01507E598E016EB8))
      self waittill("super_obj_drain");
  } else if(!isDefined(self.carryobject))
    self waittill("obj_picked_up");
  else
    wait 0.05;

  while(issuperinuse()) {
    reducesuperusepercent(_id_268CA64E50C8CE7F);
    wait 0.05;
  }
}

combatrecordsuperuse(super) {
  if(!scripts\mp\utility\stats::canrecordcombatrecordstats()) {
    return;
  }
  _id_7ABB90C7E07FF11B = self getplayerdata(level._id_5D69837CF4DB0407, "playerStats", "superStats", super, "uses");
  self setplayerdata(level._id_5D69837CF4DB0407, "playerStats", "superStats", super, "uses", _id_7ABB90C7E07FF11B + 1);
}

combatrecordsuperkill(super) {
  if(!scripts\mp\utility\stats::canrecordcombatrecordstats()) {
    return;
  }
  _id_7ABB90C7E07FF11B = self getplayerdata(level._id_5D69837CF4DB0407, "playerStats", "superStats", super, "kills");
  self setplayerdata(level._id_5D69837CF4DB0407, "playerStats", "superStats", super, "kills", _id_7ABB90C7E07FF11B + 1);
}

combatrecordsupermisc(super, _id_2F977E27FA739602) {
  if(!scripts\mp\utility\stats::canrecordcombatrecordstats()) {
    return;
  }
  if(!isDefined(_id_2F977E27FA739602))
    _id_2F977E27FA739602 = 1;

  _id_7ABB90C7E07FF11B = getcombatrecordsupermisc(super);
  self setplayerdata(level._id_5D69837CF4DB0407, "playerStats", "superStats", super, "misc1", _id_7ABB90C7E07FF11B + _id_2F977E27FA739602);
}

getcombatrecordsupermisc(super) {
  return self getplayerdata(level._id_5D69837CF4DB0407, "playerStats", "superStats", super, "misc1");
}

superdisabledinarbitraryup(_id_EBEC497FF8B18A45) {
  if(_id_EBEC497FF8B18A45 == "super_microturret" || _id_EBEC497FF8B18A45 == "super_supertrophy")
    return 1;

  return 0;
}

superdisabledinarbitraryupmessage() {
  scripts\mp\hud_message::showerrormessage("MP/SUPERS_UNAVAILABLE_ARB_UP");
}

choppergunnerbeginuse() {
  return scripts\mp\killstreaks\killstreaks::trytriggerkillstreakfromsuper("chopper_gunner");
}

cruisepredatorbeginuse() {
  return scripts\mp\killstreaks\killstreaks::trytriggerkillstreakfromsuper("cruise_predator");
}

scramblebeginuse() {
  scrambleent = spawn("script_model", self.origin + (0, 0, 400));
  self.scrambleent = scrambleent;
  self.scrambleent setModel("super_scramble_mp");
  self.scrambleent linkTo(self);
  self.scrambleent.owner = self;
  self.scrambleent.team = self.team;
  self.scrambleent setotherent(self);
  self.scrambleent setscriptablepartstate("scramble_sfx", "on", 0);
  thread scripts\cp_mp\killstreaks\helper_drone::helperdrone_watchscramblereffectdist(self);
  return 1;
}

scrambleusefinished(_id_FCEF8D217A441961) {
  self.scrambleent unlink();
  self.scrambleent delete();
  scripts\cp_mp\killstreaks\helper_drone::helperdrone_endscramblereffect();
}

trophyonset() {
  return scripts\mp\equipment\trophy_system::trophy_onsuperset();
}

tacinsertonset() {
  scripts\mp\equipment\tac_insert::tacinsert_set();
}

tacinsertonunset() {
  scripts\mp\equipment\tac_insert::tacinsert_unset();
}

brcircleextract() {}

taccoverbeginuse() {
  return scripts\mp\equipment\tactical_cover::tac_cover_on_fired_super();
}

taccoverunset() {
  return scripts\mp\equipment\tactical_cover::tac_cover_on_take_super();
}

_id_9C38F7EA2223B47C() {
  return _id_407C3ADF846B725B::_id_2E07802AB9938047();
}

_id_03BC4F06F06E9C62() {
  return 1;
}

_id_D1BD30BE0C5EC282() {
  return _id_51F5154861435B1E::_id_332540CA356C18B8();
}

_id_2EF8268013BDBE57() {
  return _id_51F5154861435B1E::_id_E0AD06F46E6D9149();
}

_id_2B9E988CDB17F507(objweapon) {
  return _id_51F5154861435B1E::_id_1AF63ADB97F131A1(objweapon);
}

_id_DFC3421815005E62() {
  return _id_51F5154861435B1E::_id_60367230245C7390();
}

_id_CF92670CCE45E726() {
  return _id_1CF2ED809496BF4E::_id_752B8EC64BC01517();
}

_id_25B1B1C8CAE25C68(objweapon) {
  return _id_1CF2ED809496BF4E::_id_786A7189AD105A77(objweapon);
}

_id_FAD76FFCE1BC5317() {
  return _id_34E2C429F1463C06::_id_2CF7E1E0B6513C6F();
}

_id_AF1D2E4473F5057E() {
  return _id_34E2C429F1463C06::_id_79893D5ED21AE366();
}

recondronebeginuse() {
  return _id_6D68CFDF0836123C::recondrone_beginsuper();
}

_id_3529248AA2D81ABC() {
  return _id_6D68CFDF0836123C::_id_439E22CA27F68CE3();
}

recondroneenduse(_id_FCEF8D217A441961, attacker) {
  return _id_6D68CFDF0836123C::recondrone_endsuper(_id_FCEF8D217A441961);
}

recondroneunset() {
  _id_6D68CFDF0836123C::recondrone_unsetsuper();
}

deadsilencebeginuse() {
  return scripts\mp\supers\super_deadsilence::superdeadsilence_beginsuper();
}

deadsilenceenduse(_id_FCEF8D217A441961, attacker) {
  return scripts\mp\supers\super_deadsilence::superdeadsilence_endsuper(_id_FCEF8D217A441961);
}

supportboxunset() {
  scripts\mp\equipment\support_box::supportbox_unset();
}

stoppingpowerbeginuse() {
  return scripts\mp\supers\super_stoppingpower::stoppingpower_beginuse();
}

superweapondropbeginuse() {
  return scripts\mp\equipment\weapon_drop::weapondrop_beginsuper();
}

_id_EF705D06883B52A7() {
  _id_4BEF961309209288::_id_B2D2056EE8B00689();
}

_id_66C2B6FB2734CBAE() {
  return _id_4BEF961309209288::_id_55AAE48E013652FA();
}

_id_2DE710D6B3C9388E() {
  return _id_5E2DCB7FB9811781::_id_F62E25CB503D7BAB();
}

_id_CA449B017D946D26(_id_FCEF8D217A441961, attacker) {
  return _id_5E2DCB7FB9811781::_id_2F0D9315AB20C4BF();
}

_id_D93F331B74C647F2() {
  return _id_5E2DCB7FB9811781::_id_E83E2D8DC74FFDBB();
}

_id_0E050BB329310407() {
  return _id_5E2DCB7FB9811781::_id_D2A07D3ACDD4B448();
}

_id_81A2DF228546136E() {
  return _id_19FD5B5D73D44C18::_id_905B7BADA6FD91CB();
}

_id_D1B35AA1689BEB06(_id_FCEF8D217A441961, attacker) {
  return _id_19FD5B5D73D44C18::_id_739A5F064C7DEBDF();
}

_id_14761663823DBCB7() {
  return _id_30CD25DB3C981D4F::_id_685E618D30DA1588();
}

_id_2E14B99891ECBBF4() {
  return _id_30CD25DB3C981D4F::_id_269055D8846E4665();
}

_id_9380DB5262BED3E7() {
  return _id_7EC79670452EC186::_id_E10D519BBF856E68();
}

_id_53025970EB68A86B() {
  return _id_556B8AEAA691317F::_id_321C7891711E583F();
}

_id_FDFAE98BCFBF8C7F(_id_FCEF8D217A441961, attacker) {
  return _id_556B8AEAA691317F::_id_F5037BA4A5399B63(_id_FCEF8D217A441961);
}

_id_DEC15D25CE41A183() {
  return _id_556B8AEAA691317F::_id_0A377D33613E0C83();
}

_id_8D6D142BCEB819F2() {
  return _id_19818A4D668D8841::_id_40F1163063C26637();
}

_id_E3C0D84AA4294EE9() {
  success = 0;
  success = _id_97EECCE0124A7B50();

  if(success)
    success = _id_1B4114093CD44368::_id_2E4CD4D627C30C24();

  return success;
}

_id_CF347A049095421B() {
  return _id_104E3370B024F998::_id_D3F8E1C800B2E8C0();
}

_id_19B0130D94D96B0B() {
  return _id_104E3370B024F998::_id_4364C764FCF6194D();
}

_id_34956DA8DD3AFD1F(_id_FCEF8D217A441961, attacker) {
  return _id_104E3370B024F998::_id_636D60AA04F7E10D();
}

_id_FC34A7D0E83B6D77() {
  return _id_328CEEBB19C9CF51::_id_37DDCDE87B74CC48();
}

_id_A7043870418BF96B(_id_FCEF8D217A441961, attacker) {
  return _id_328CEEBB19C9CF51::_id_4595A2E368E64B18();
}

_id_F98D4EC41407BC75() {
  return _id_63634D9FA080435A::_id_D45FD98510D7B7E9();
}

_id_975965422D6BCB49(_id_FCEF8D217A441961, attacker) {
  return _id_63634D9FA080435A::_id_E0A9DAA14C0B948B();
}

_id_E9993EE767C0ACF5() {
  return _id_0A698CF430108FB7::_id_CFB677B5F7D5E644();
}

_id_EC715B4038AE47C9(_id_FCEF8D217A441961, attacker) {
  return 1;
}

_id_E67D9C8005D3F178() {
  return _id_268C558DDB2267AA::_id_C54F7DA664700B4B();
}

_id_13214DC30F36BF08(_id_FCEF8D217A441961, attacker) {}

_id_8D08654F0023D631() {
  return _id_24933BC598A88C61::_id_C0327B881B392647();
}

_id_3A1B0EE4F020AB35() {
  return _id_24933BC598A88C61::_id_E721C06D0E8502BF();
}

_id_2B9DFA62D7E245F5(_id_FCEF8D217A441961, attacker) {
  return _id_24933BC598A88C61::_id_456170EF7257430B(_id_FCEF8D217A441961);
}

superselectonset() {
  firstupgrade = scripts\mp\perks\perkpackage::perkpackage_getfirstfieldupgrade();
  self.super.firstupgrade = firstupgrade;
  secondupgrade = scripts\mp\perks\perkpackage::perkpackage_getsecondfieldupgrade();
  self.super.secondupgrade = secondupgrade;
}

_id_C9491DF86B072612(firstupgrade, secondupgrade) {
  if(!isDefined(firstupgrade))
    firstupgrade = scripts\mp\perks\perkpackage::perkpackage_getfirstfieldupgrade();

  if(!isDefined(secondupgrade))
    secondupgrade = scripts\mp\perks\perkpackage::perkpackage_getsecondfieldupgrade();

  staticdata = level.superglobals.staticsuperdata[firstupgrade];
  _id_D5C938E8C28EC207 = 0;

  if(isDefined(staticdata))
    _id_D5C938E8C28EC207 = staticdata.pointsneeded;

  staticdata = level.superglobals.staticsuperdata[secondupgrade];
  _id_55FCA3A9D50B3BB3 = 0;

  if(isDefined(staticdata))
    _id_55FCA3A9D50B3BB3 = staticdata.pointsneeded;

  _id_F50865A8840FA2B7 = max(_id_D5C938E8C28EC207, _id_55FCA3A9D50B3BB3);
  self.perkpackagedata.overridepointsneeded = _id_F50865A8840FA2B7;
}

_id_E78F07EFBCDB9E97() {
  self.perkpackagedata.overridepointsneeded = undefined;
}

superselectonunset() {
  _id_DDEB08081F6FABEA();
}

_id_FAD6D78D6B3B3359(objweapon) {
  if(isDefined(self._id_35B042C5224A1646)) {
    _id_908084E5CDD0AE1A = level.superglobals.staticsuperdata[self._id_35B042C5224A1646];

    if(isDefined(_id_908084E5CDD0AE1A._id_1BB8C2DE6198881A)) {
      if(istrue([[_id_908084E5CDD0AE1A._id_1BB8C2DE6198881A]](objweapon)))
        self notify("perkPackageMenu_close");
    }
  }
}

superselectbeginuse() {
  return scripts\mp\perks\perkpackage::perkpackage_openselect();
}

_id_BAF9EEEF4CF2BAC5() {
  firstupgrade = scripts\mp\perks\perkpackage::perkpackage_getfirstfieldupgrade();
  secondupgrade = scripts\mp\perks\perkpackage::perkpackage_getsecondfieldupgrade();

  if(!isDefined(self._id_35B042C5224A1646) || isDefined(self._id_35B042C5224A1646) && self._id_35B042C5224A1646 == "super_emp_pulse") {
    if(firstupgrade == "super_emp_pulse" || secondupgrade == "super_emp_pulse") {
      _id_7203E7AA96FF0BA9(30);
      _id_5E2DCB7FB9811781::_id_75BAA17A54260F6F(1);
    }
  }
}

testsuperbeginuse() {
  thread testsuperrefundwatcher();
  return 1;
}

superfultonbeginuse() {
  return 1;
}

supersupplydropbeginuse() {
  return 1;
}

_id_7EEAD274EF83E1B9() {
  return _id_676F8221E501BED1::_id_172A790B85BBC40B();
}

_id_0AFD34C64E8C8D5D() {
  return _id_556B8AEAA691317F::_id_9DB6A100A4046D0C();
}

_id_90A74A57A43C9808() {
  return _id_556B8AEAA691317F::_id_3F29F7CEB8C0EC6D();
}

testsuperrefundwatcher() {
  self endon("super_use_finished");

  for(;;) {
    if(self buttonPressed("BUTTON_X"))
      superusefinished(0, 0, 1);
    else if(self buttonPressed("BUTTON_Y"))
      superusefinished(1);

    waitframe();
  }
}

showsuperremindersplash() {
  self endon("disconnect");

  if(!istrue(self.superreminderset)) {
    self notify("showSuperReminderSplash");
    self endon("showSuperReminderSplash");
    self.superreminderset = 1;
    self setclientomnvar("ui_super_reminder", 1);
    wait 0.5;
    thread clearsuperremindersplash();
  } else {
    thread clearsuperremindersplash();
    self endon("showSuperReminderSplash");
    waitframe();
    thread showsuperremindersplash();
    return;
  }
}

clearsuperremindersplash() {
  self notify("showSuperReminderSplash");
  self.superreminderset = undefined;
  self setclientomnvar("ui_super_reminder", 0);
}

clearsuperreminderondeath(player) {
  if(!isPlayer(player)) {
    return;
  }
  thread clearsuperreminderondeathinternal(player);
}

clearsuperreminderondeathinternal(player) {
  player endon("disconnect");
  player waittill("death");
  player clearsuperremindersplash();
}

initsuperdvars() {
  setdvarifuninitialized("scr_super_decay_rate", 6.0);
  level.superglobals._id_88BF1CA5D31120C4 = getdvarint("dvar_71B04BFC490E137A", 0);
}

watchsuperlottery() {
  level endon("game_ended");
  _id_69F8C933A9416FD4 = getdvarint("dvar_89AB277FB91D0852", 60);
  _id_CEB102618AF8A2A0 = getdvarint("dvar_EEA9235538D727FE", 45);
  _id_CE8D18618AD0584A = getdvarint("dvar_EE86355538B107DC", 90);
  _id_C2C32EBB75125711 = _id_CE8D18618AD0584A - _id_CEB102618AF8A2A0;
  waitframe();

  if(!istrue(scripts\mp\flags::gameflag("prematch_done")))
    level waittill("prematch_over");

  wait(_id_69F8C933A9416FD4);
  _id_650C8ACDFFCC5AF7 = undefined;
  _id_6799761943648F6A = undefined;
  _id_6B769601E87E9C1E = [];
  _id_2F915C7E43A8C53C = [];

  foreach(_id_F90358454413407F in level.teamnamelist) {
    _id_6B769601E87E9C1E[_id_F90358454413407F] = undefined;
    _id_2F915C7E43A8C53C[_id_F90358454413407F] = [];
  }

  for(;;) {
    _id_650C8ACDFFCC5AF7 = _id_6799761943648F6A;
    _id_6799761943648F6A = getdvarint("dvar_350B9A835C1F30B8", 0) > 0;

    if(!isDefined(_id_650C8ACDFFCC5AF7) || _id_650C8ACDFFCC5AF7 != _id_6799761943648F6A) {
      if(_id_6799761943648F6A)
        level notify("superLotteryEnabled");
      else
        level notify("superLotteryDisabled");
    }

    foreach(_id_F90358454413407F in level.teamnamelist) {
      if(!isDefined(_id_6B769601E87E9C1E[_id_F90358454413407F])) {
        _id_6B769601E87E9C1E[_id_F90358454413407F] = gettime() + (_id_CEB102618AF8A2A0 + randomint(_id_C2C32EBB75125711)) * 1000;
        continue;
      }

      if(_id_6B769601E87E9C1E[_id_F90358454413407F] <= gettime()) {
        players = scripts\mp\utility\teams::getteamdata(_id_F90358454413407F, "players");

        if(players.size > 0) {
          players = scripts\engine\utility::array_randomize(players);
          _id_760EBC212D9D24E1 = [];
          bestplayer = undefined;

          foreach(player in players) {
            if(!scripts\engine\utility::array_contains(_id_2F915C7E43A8C53C[_id_F90358454413407F], player)) {
              if(isDefined(player getcurrentsuper())) {
                bestplayer = player;
                break;
              }
            } else if(isDefined(player getcurrentsuper()))
              _id_760EBC212D9D24E1[_id_760EBC212D9D24E1.size] = player;
          }

          if(!isDefined(bestplayer)) {
            if(isDefined(_id_760EBC212D9D24E1[0]))
              bestplayer = _id_760EBC212D9D24E1[0];
            else
              bestplayer = players[0];
          }

          if(_id_6799761943648F6A)
            childthread awardsuperlottery(bestplayer);

          _id_2F915C7E43A8C53C[_id_2F915C7E43A8C53C.size] = bestplayer;
        }

        _id_6B769601E87E9C1E[_id_F90358454413407F] = undefined;
      }
    }

    waitframe();
  }
}

awardsuperlottery(player) {
  player endon("disconnect");
  player endon("joined_team");
  level endon("superLotteryDisabled");
  player notify("awardSuperLottery");
  player endon("awardSuperLottery");

  for(;;) {
    _id_19163E14365D9264 = player getcurrentsuper();

    if(!isDefined(_id_19163E14365D9264)) {
      return;
    }
    if(!player issuperinuse()) {
      break;
    }

    waitframe();
  }

  player givesuperpoints(getsuperpointsneeded(), undefined, 1);
}

getscriptdataversion() {
  if(getdvarint("dvar_6AF7E4425B1F5D10", 0) != 0)
    return 254;

  if(getdvarint("scr_playtest", 0) != 0)
    return 7;

  return 254;
}

recordsuperearnedanalytics(_id_19163E14365D9264) {
  if(getdvarint("dvar_13856880331B5596", 0) == 0) {
    return;
  }
  timeplayed = scripts\mp\persistence::statgetchildbuffered("round", "timePlayed", 1) / 60.0;
  dlog_recordevent("mpscript_super_earning", ["super_ref", _id_19163E14365D9264.staticdata.ref, "earn_time", timeplayed, "gamemode", scripts\mp\utility\game::getgametype(), "script_version", getscriptdataversion(), "earned_count", self.pers["supersEarned"]]);
}

_id_395A9CB3EBE25D55(_id_19163E14365D9264) {
  _id_0F3EE0300341F6D5 = isDefined(_id_19163E14365D9264.staticdata.useweapon);
  _id_641083E829D5514C = scripts\engine\utility::ter_op(_id_0F3EE0300341F6D5, _id_19163E14365D9264.staticdata.useweapon, _id_19163E14365D9264.staticdata.weapon);
  _id_A7BE10E54A3A4B99 = weaponmaxammo(_id_641083E829D5514C);
  _id_F49F1F75577FA9B1 = 0;

  if(_id_0F3EE0300341F6D5) {
    _id_F49F1F75577FA9B1 = _id_F49F1F75577FA9B1 + _id_19163E14365D9264.staticdata.useweaponclipammo;
    _id_F49F1F75577FA9B1 = _id_F49F1F75577FA9B1 + min(_id_A7BE10E54A3A4B99, _id_19163E14365D9264.staticdata.useweaponstockammo);
  } else
    _id_F49F1F75577FA9B1 = _id_F49F1F75577FA9B1 + min(_id_A7BE10E54A3A4B99, _id_19163E14365D9264.staticdata._id_156B27CC0DA0F727);

  return 1 / _id_F49F1F75577FA9B1;
}

_id_235470B268F029CA(_id_4C663252DABD1483) {
  isoob = scripts\mp\outofbounds::ispointinoutofbounds(self.origin, self.owner.team);

  if(isoob) {
    if(isDefined(_id_4C663252DABD1483))
      self thread[[_id_4C663252DABD1483]]();

    if(isDefined(self.owner))
      self.owner refundsuper();
  }
}

_id_DDEB08081F6FABEA() {
  _id_348B7738828CE685 = 0;

  if(isDefined(self._id_35B042C5224A1646)) {
    _id_6E77F955D2C33644 = level.superglobals.staticsuperdata[self._id_35B042C5224A1646]._id_F6604EEBABCAC6C2;

    if(!isDefined(_id_6E77F955D2C33644))
      _id_348B7738828CE685 = 1;
    else {
      id = level.superglobals.staticsuperdata[self._id_35B042C5224A1646].id;
      _id_86747F1F24DF567B = [[level.superglobals.staticsuperdata[self._id_35B042C5224A1646]._id_F6604EEBABCAC6C2]]();

      if(istrue(_id_86747F1F24DF567B))
        _id_7203E7AA96FF0BA9(id, 0, 1);
      else
        _id_348B7738828CE685 = 1;
    }
  } else
    _id_348B7738828CE685 = 1;

  if(_id_348B7738828CE685)
    _id_7203E7AA96FF0BA9(0);
}

_id_7203E7AA96FF0BA9(superid, _id_86C4BB77BC9871CD, _id_00E79995FA243CA9) {
  if(superid == 0) {
    self setclientomnvar("ui_field_upgrade_use", superid);

    if(!istrue(_id_86C4BB77BC9871CD))
      self._id_57D85036EA10552D = undefined;

    return;
  }

  _id_700E5BDE49FCE648 = 0;

  if(!isDefined(self.super)) {
    return;
  }
  if(istrue(self.perkpackagedata.istwomode) && !istrue(_id_00E79995FA243CA9)) {
    if(!isDefined(self.perkpackagedata._id_E5DA01E1954B6734))
      _id_700E5BDE49FCE648 = 1;
    else if(isDefined(self._id_57D85036EA10552D)) {
      _id_902970E912ECFBD5 = level.superglobals.supersbyid[self._id_57D85036EA10552D];
      _id_6CFEB740AA80163A = level.superglobals.supersbyid[superid];
      _id_FE1CA90A8E7694A0 = level.superglobals.staticsuperdata[_id_902970E912ECFBD5]._id_D835CD7ABD661B88;
      _id_857BC7A94ECF5791 = level.superglobals.staticsuperdata[_id_6CFEB740AA80163A]._id_D835CD7ABD661B88;

      if(_id_857BC7A94ECF5791 == -1)
        _id_700E5BDE49FCE648 = 0;
      else if(_id_857BC7A94ECF5791 <= _id_FE1CA90A8E7694A0)
        _id_700E5BDE49FCE648 = 1;
      else {
        _id_700E5BDE49FCE648 = 1;
        superid = self._id_57D85036EA10552D;
      }
    } else
      _id_700E5BDE49FCE648 = 1;
  } else
    _id_700E5BDE49FCE648 = 1;

  if(_id_700E5BDE49FCE648 || istrue(_id_00E79995FA243CA9)) {
    self setclientomnvar("ui_field_upgrade_use", superid);
    self._id_57D85036EA10552D = superid;
  }
}

_id_A465412785D4C550(objweapon) {
  weaponname = undefined;

  if(!isDefined(objweapon))
    return 0;

  switch (objweapon.basename) {
    case "deadsilence_device_mp":
    case "deploy_loadout_drop_mp":
    case "emp_pulse_device_mp":
      return 1;
  }

  return 0;
}

_id_C1C41A5273F29351(objweapon, _id_6A94CF09AA6E486E) {
  self endon("death");
  self endon("disconnect");

  if(!isweapon(objweapon)) {
    if(isstring(objweapon))
      objweapon = makeweapon(objweapon);
  }

  if(!_id_3B64EB40368C1450::_id_E0751B03DFB9EB43("supers"))
    return 0;

  if(!isweapon(objweapon)) {
    self notify("giveAndFireSuperWeaponFailed", objweapon);
    return 0;
  }

  if(objweapon.classname == "grenade")
    self giveandfireoffhand(objweapon);
  else
    return scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(objweapon, _id_6A94CF09AA6E486E);

  if(!self hasweapon(objweapon)) {
    self notify("giveAndFireSuperWeaponFailed", objweapon);
    return 0;
  }

  result = spawnStruct();
  result childthread _id_ED75F819472FFE84(self, objweapon);
  result childthread _id_BEDC88D54E2C0015(self, objweapon);
  result waittill("race_start");
  waittillframeend;
  result notify("race_end");

  if(istrue(result.success)) {
    self notify("giveAndFireOffhandReliableSucceeded", objweapon);
    return 1;
  } else if(istrue(result.failure)) {
    self notify("giveAndFireOffhandReliableFailed", objweapon);
    return 0;
  }
}

_id_ED75F819472FFE84(player, objweapon) {
  self endon("race_end");
  player waittillmatch("offhand_fired", objweapon);
  self.success = 1;
  self notify("race_start");
}

_id_BEDC88D54E2C0015(player, objweapon) {
  self endon("race_end");

  while(player hasweapon(objweapon) && _id_3B64EB40368C1450::_id_E0751B03DFB9EB43("supers"))
    waitframe();

  self.failure = 1;
  self notify("race_start");
}

_id_C7372AB32E9D5636(_id_19163E14365D9264) {
  if(!isDefined(_id_19163E14365D9264))
    _id_19163E14365D9264 = getcurrentsuper();

  if(!isDefined(_id_19163E14365D9264))
    return 0;

  _id_5C8E66E22B288B33 = _id_19163E14365D9264.staticdata._id_5C8E66E22B288B33;
  return _id_5C8E66E22B288B33 == "TIME";
}

_id_CC6A20F09D95D319(_id_19163E14365D9264) {
  if(!isDefined(_id_19163E14365D9264))
    _id_19163E14365D9264 = getcurrentsuper();

  if(!isDefined(_id_19163E14365D9264))
    return 0;

  _id_5C8E66E22B288B33 = _id_19163E14365D9264.staticdata._id_5C8E66E22B288B33;
  return _id_5C8E66E22B288B33 == "AMMO";
}

_id_97EECCE0124A7B50() {
  _id_330825804EBBD918(1);
  _id_19163E14365D9264 = getcurrentsuper();
  clipammo = _id_19163E14365D9264.staticdata.useweaponclipammo;
  stockammo = _id_19163E14365D9264.staticdata.useweaponstockammo;

  if(isDefined(_id_19163E14365D9264._id_2EBCBD70919376A7)) {
    clipammo = _id_19163E14365D9264._id_2EBCBD70919376A7.clipammo;
    stockammo = _id_19163E14365D9264._id_2EBCBD70919376A7.stockammo;
  }

  result = trygiveuseweapon(_id_19163E14365D9264.staticdata.useweapon, clipammo, stockammo);

  if(istrue(result))
    _id_330825804EBBD918(1);
  else
    _id_330825804EBBD918(0);

  return result;
}

_id_3B0BB7416DC0F9F1(ref) {
  return isDefined(level.superglobals.staticsuperdata[ref]);
}

_id_AC471719698C7DDF() {
  _id_19163E14365D9264 = getcurrentsuper();

  if(isDefined(_id_19163E14365D9264))
    return _id_19163E14365D9264.staticdata.ref;

  return undefined;
}

_id_907944A173ED27E1(_id_EBEC497FF8B18A45) {
  switch (_id_EBEC497FF8B18A45) {
    case "super_teleport_deploy":
    case "super_laser_charge":
    case "super_electric_discharge":
    case "super_high_jump":
      return 1;
    default:
      return 0;
  }

  return 0;
}