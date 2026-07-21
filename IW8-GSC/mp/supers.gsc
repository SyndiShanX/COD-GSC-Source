/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\supers.gsc
***********************************************/

init() {
  var_0 = spawnStruct();
  level.superglobals = var_0;
  var_0.staticsuperdata = [];
  var_0.superweapons = [];
  var_0.superearnratemultiplier = 1.0;
  var_0.supersbyid = [];
  var_0.supersbyoffhand = [];
  var_0._id_13987 = [];
  var_0.pointeventdata = [];
  loadsupertable();
  loadpointstable();
  registersupers();
  initsuperdvars();
  scripts\mp\utility\spawn_event_aggregator::registeronplayerspawncallback(::clearsuperreminderondeath);
  thread watchforgameend();

  if(getdvarint("_encstr_BAE418EE8E73EF233D8310A01B4F9BE1AA72636D25BA5D0815CB", 0) > 0)
    thread watchsuperlottery();

  if(level.allowsupers)
    level thread handlesuperearnovertime();

  scripts\mp\equipment\tactical_cover::tac_cover_init();
  scripts\mp\equipment\support_box::supportbox_init();
  scripts\mp\equipment\ammo_box::ammobox_init();
  scripts\mp\supers\super_stoppingpower::_id_138E7();
  _luidecision::_id_11ED7();
  scripts\mp\utility\spawn_event_aggregator::registeronplayerspawncallback(::_id_13978);
  _debug_rooftop_heli_start::subscribetoquestlocale();
  level.setsuperweapondisabled = ::setsuperweapondisabled;
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_BEB406F03B72BB3B", "_encstr_83FC17704FBCA91189EB971502504B13042FF0488B44A525A2", ::_id_144FA);
}

loadsupertable() {
  var_0 = scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB";
  var_1 = 1;

  for(;;) {
    var_2 = tablelookupbyrow("_encstr_AA9812B607CB9BAB83952747C24C63CA71D83767", var_1, 0);

    if(!isDefined(var_2) || var_2 == "_encstr_B40101") {
      break;
    }

    var_3 = readsupertablecell(var_1, 3, 1);

    if(istrue(var_3) && !var_0) {
      var_1++;
      continue;
    }

    var_4 = spawnStruct();
    level.superglobals.staticsuperdata[var_2] = var_4;
    var_4.id = var_1;
    var_4.ref = var_2;
    var_4.weapon = readsupertablecell(var_1, 1);
    var_5 = undefined;

    if(scripts\mp\utility\game::isanymlgmatch())
      var_5 = readsupertablecell(var_1, 28, 1);

    if(!isDefined(var_5))
      var_5 = readsupertablecell(var_1, 2, 1);

    var_4.pointsneeded = var_5;
    var_6 = undefined;

    if(scripts\mp\utility\game::isanymlgmatch())
      var_6 = readsupertablecell(var_1, 26, 1);

    if(!isDefined(var_6))
      var_6 = readsupertablecell(var_1, 4, 1);

    var_4.usetime = var_6;
    var_4.maxactivations = readsupertablecell(var_1, 5, 1);
    var_4._id_12ACD = readsupertablecell(var_1, 6, 1);
    var_4.useweapon = readsupertablecell(var_1, 11);
    var_4.useweaponclipammo = readsupertablecell(var_1, 12, 1);
    var_4.useweaponstockammo = readsupertablecell(var_1, 13, 1);
    var_4.useweapontrackstats = readsupertablecell(var_1, 31, 1) > 0;
    var_4.movespeed = readsupertablecell(var_1, 14, 1);
    var_7 = undefined;

    if(scripts\mp\utility\game::isanymlgmatch())
      var_7 = readsupertablecell(var_1, 27, 1);

    if(!isDefined(var_7))
      var_7 = readsupertablecell(var_1, 15, 1);

    var_4.graceperiod = var_7;
    var_4.maxactivationsalt = readsupertablecell(var_1, 16, 1);
    var_4.usedelay = readsupertablecell(var_1, 18, 1);
    var_4.ending_mortars = readsupertablecell(var_1, 19, 1);
    var_4.archetype = readsupertablecell(var_1, 17);
    var_4.isweapon = readsupertablecell(var_1, 20, 1);
    var_4.canuseinlaststand = readsupertablecell(var_1, 32, 1) > 0;
    var_4.packextrascore0 = [];

    if(isDefined(var_4.useweapon))
      var_4.useweapon = asmdevgetallstates(var_4.useweapon);

    level.superglobals.supersbyid[var_1] = var_2;

    if(!isDefined(var_4.weapon))
      level.superglobals.staticsuperdata[var_2] = undefined;
    else
      level.superglobals.supersbyoffhand[var_4.weapon] = var_4;

    if(!isDefined(var_4.pointsneeded))
      level.superglobals.staticsuperdata[var_2] = undefined;

    if(isDefined(var_4.maxactivations)) {
      if(var_4.maxactivations > 0)
        var_4.activatepenalty = 1.0 / var_4.maxactivations;
      else
        var_4.activatepenalty = 1.0;
    }

    if(isDefined(var_4.maxactivationsalt)) {
      if(var_4.maxactivationsalt > 0)
        var_4.activatepenaltyalt = 1.0 / var_4.maxactivationsalt;
    }

    if(isDefined(var_4.useweapon))
      level.superglobals.superweapons[var_4.useweapon.basename] = var_4;

    if(var_4.weapon == "_encstr_B16F0A71F1501E62D5B1B3A2")
      var_4.weapon = "_encstr_88B611B95D0EAC27EB9159CC16AE8D47FA6BC1";

    if(isDefined(var_4.graceperiod))
      var_4.graceperiod = var_4.graceperiod * 1000.0;
    else
      var_4.graceperiod = 0.0;

    var_1++;
  }

  var_8 = tablelookup("_encstr_83EB1687D1B81B5DA0B18A92295895A3670D0B3FC5364316", 0, scripts\mp\utility\game::getgametype(), 1);

  if(isDefined(var_8) && var_8 != "_encstr_B40101")
    level.superglobals.superearnratemultiplier = float(var_8);
}

readsupertablecell(var_0, var_1, var_2) {
  var_3 = tablelookupbyrow("_encstr_AA9812B607CB9BAB83952747C24C63CA71D83767", var_0, var_1);

  if(var_3 == "_encstr_B40101")
    return undefined;

  if(istrue(var_2)) {
    if(issubstr(var_3, "_encstr_BD4C024E"))
      var_3 = float(var_3);
    else
      var_3 = int(var_3);
  }

  return var_3;
}

loadpointstable() {
  var_0 = 2;
  var_1 = scripts\mp\utility\game::getgametype();

  for(;;) {
    var_2 = tablelookupbyrow("_encstr_925E18E2B06FF2FF2BAD6A60B0D04BFB3F68AA8AF843FDEF230C", 0, var_0);

    if(!isDefined(var_2) || var_2 == "_encstr_B40101") {
      var_0 = undefined;
      break;
    }

    if(var_2 == var_1) {
      break;
    }

    var_0++;
  }

  var_3 = 0;

  for(;;) {
    var_3++;
    var_4 = tablelookupbyrow("_encstr_925E18E2B06FF2FF2BAD6A60B0D04BFB3F68AA8AF843FDEF230C", var_3, 0);

    if(!isDefined(var_4) || var_4 == "_encstr_B40101") {
      break;
    }

    var_5 = undefined;

    if(isDefined(var_0)) {
      var_5 = tablelookupbyrow("_encstr_925E18E2B06FF2FF2BAD6A60B0D04BFB3F68AA8AF843FDEF230C", var_3, var_0);

      if(isDefined(var_5) && var_5 == "_encstr_B40101")
        var_5 = undefined;
    }

    if(!isDefined(var_5))
      var_5 = tablelookupbyrow("_encstr_925E18E2B06FF2FF2BAD6A60B0D04BFB3F68AA8AF843FDEF230C", var_3, 1);

    var_5 = float(var_5);

    if(var_5 <= 0) {
      continue;
    }
    level.superglobals.pointeventdata[var_4] = var_5;
  }
}

registersupers() {
  registersuper("_encstr_A1BB0BDC571CCA93F51D56DC1D", undefined, undefined, ::testsuperbeginuse, undefined);
  registersuper("_encstr_92520EE65707594E7D894E1646C62BE5", undefined, undefined, ::bradleybeginuse, undefined);
  registersuper("_encstr_AF11153EFD4B217541AAE0D0B3A2039B9F9745384EA70B", undefined, undefined, ::choppergunnerbeginuse, undefined);
  registersuper("_encstr_99C1162245E1527AE608D3F7605B25B9B95E2F9F27414AA2", undefined, undefined, ::cruisepredatorbeginuse, undefined);
  registersuper("_encstr_9B161AE285A1123AA6D093F77058F31A4790619E630DCB646B70FFFF", undefined, undefined, ::precisionairstrikebeginuse, undefined);
  registersuper("_encstr_AF7012F63D4BBBD239A90DEAE0F9868163DB1A83", undefined, undefined, ::tomastrikebeginuse, undefined);
  registersuper("_encstr_8A8B1187B763D5F82F6A51E959EB8898FB032B", undefined, undefined, ::pacsentrybeginuse, undefined);
  registersuper("_encstr_968411DCBAC12B4E7D13E4BE563C8E27851BD1", undefined, undefined, ::brcircleextract, undefined);
  registersuper("_encstr_8BC20A138BE03FA3C0DB6AE3", undefined, undefined, ::uavbeginuse, undefined);
  registersuper("_encstr_923A10D7F32F4262F18BA62E06F8B7AB0D55", undefined, ::taccoverunset, ::taccoverbeginuse, undefined);
  registersuper("_encstr_955F12039B0FAFA2B9AD353BBF18A113B6704AEA", undefined, ::recondroneunset, ::recondronebeginuse, ::recondroneenduse);
  registersuper("_encstr_995B109BAB0756E47DCA5B837D914EEDB995", undefined, undefined, ::empdronebeginuse, undefined);
  registersuper("_encstr_9101121BEF3B3B8271C87DD0BB50736B81DB9801", undefined, ::supportboxunset, ::stoppingpowerbeginuse, undefined);
  registersuper("_encstr_AACB15DC5738CA27FA1B589B1DCD47C29B32D7A19516B1", ::laststandhealonset, ::laststandhealunset, ::laststandhealbeginuse, undefined);
  registersuper("_encstr_8BEF1623CB2049DB71FB2F73172C2B8F08F1C1E045B96C91", ::remotedetonateonset, undefined, ::remotedetonatebeginuse, undefined);
  registersuper("_encstr_9B2F0D5B9D2BB782A7B02BF27821B8", ::trophyonset, undefined, undefined, undefined);
  registersuper("_encstr_855F0FCDD5C1CA4ED7CD364EB0B5C43656", undefined, undefined, ::scramblebeginuse, ::scrambleusefinished);
  registersuper("_encstr_A66C12DE3B63AB1307C36048AB4308C15A655E6D", undefined, undefined, ::deadsilencebeginuse, ::deadsilenceenduse);
  registersuper("_encstr_B81811B9AE8356C9F51D856CD7B437CDAC27D1", ::tacinsertonset, ::tacinsertonunset, undefined, undefined);
  registersuper("_encstr_96F610C7E33F527201D9B5BD3029AC9B1841", undefined, undefined, undefined, undefined);
  registersuper("_encstr_83341156B3EB23ABBF5F40A07FCA4669B35D4F", undefined, undefined, undefined, undefined);
  registersuper("_encstr_B12F1220EBA20B8BB7A7656F984F30B70F0348C0", undefined, undefined, ::superweapondropbeginuse, undefined);
  registersuper("_encstr_9AEB0D0B93F8274B28E3C25A091E6B", ::_id_13988, ::_id_13989, ::superselectbeginuse, undefined);
  registersuper("_encstr_91440DDF879B1B636071FBB97127EB", undefined, undefined, ::_id_1397F, undefined);
  registersuper("_encstr_A935120E5D9AA97D0177A390E88D93C7CC08C0F7", undefined, undefined, ::_id_1398B, undefined);
  registersuper("_encstr_83FE13501FB86925492B1D93C4A251D12FF3C038F3", undefined, undefined, ::_id_1398D, undefined);
  registersuper("_encstr_A93F109BAB832BE47D1BBDDB47AF469CB707", undefined, undefined, ::_id_1398B, undefined);

  if(scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB") {
    registersuper("_encstr_8E2314CDAE0E5627D791B2D87B9BF5DCD12C3AB4DE73", ::jugg_removefromactivejugglist, ::jugg_setherodropscriptable, undefined, undefined);
    registersuper("_encstr_84970F967582523A388D0230E79940D71E", undefined, undefined, ::_id_11ED6, undefined);
    registersuper("_encstr_8FD211AA40DBBD786627D98090200FF562A230", undefined, undefined, ::_id_13983, undefined);
    registersuper("_encstr_81581092E5317F3D199AAEE08FF50E9E0922", undefined, ::_id_13981, ::_id_13980, ::vehicle_createspawnselectionlittlebirdmarker);
    registersuper("_encstr_9B2613831B8F2F22392FB5AA0B80219FBF915A6AC3", undefined, undefined, ::_encstr_B1F6140703FE93AD8099B77F3130EA2ADCB3EB97D7AD, ::_encstr_A78D126E954EAB5B76588C76954756B98C5DCD59);
    registersuper("_encstr_8A96114EA71A90B3E7DBD4682877032221E6C3", undefined, undefined, ::_encstr_8C961537AB38569C9BC65ADCCEAC9C98CA3B4BDCEAE62B, undefined);
  }

  _id_12B3C("_encstr_995B109BAB0756E47DCA5B837D914EEDB995", "_encstr_81931411E5B039F5EB6F052B97F3C90B617F7BAE0D18");
  _id_12B3C("_encstr_995B109BAB0756E47DCA5B837D914EEDB995", "_encstr_AB64181DDD735E712232B8F8297D2F307768118731CF233FCDAB");
  _id_12B3C("_encstr_995B109BAB0756E47DCA5B837D914EEDB995", "_encstr_A90D1FCAAD38AF1927B7B92B7DB9DEE67D0E63C22FB239D7465A93561B3AEBD60E");
  _id_12B3C("_encstr_B12F1220EBA20B8BB7A7656F984F30B70F0348C0", "_encstr_A6AB15078F8AEBD883CFBB7F6A7BA560BA5595F3CF3293");
}

registersuper(var_0, var_1, var_2, var_3, var_4) {
  var_5 = level.superglobals.staticsuperdata[var_0];

  if(!isDefined(var_5)) {
    return;
  }
  var_5.setfunc = var_1;
  var_5.unsetfunc = var_2;
  var_5.beginusefunc = var_3;
  var_5.endusefunc = var_4;
  var_5.isregistered = 1;
}

_id_12B3C(var_0, var_1) {
  if(!isstring(var_1))
    var_1 = var_1.basename;

  var_2 = level.superglobals.staticsuperdata[var_0];
  var_2.packextrascore0[var_2.packextrascore0.size] = var_1;
  level.superglobals._id_13987[var_1] = var_2;
}

_id_13978() {
  _id_14021();
  updatesuperuistate();
}

givesuper(var_0, var_1, var_2) {
  if(getdvarint("_encstr_BAAC161BAE0A81C6D34B5B7D6F590288BCC5831354542873") != 0) {
    return;
  }
  clearsuper(var_1);

  if(var_0 == "_encstr_B40101") {
    return;
  }
  var_3 = level.superglobals.staticsuperdata[var_0];

  if(!isDefined(var_3)) {
    return;
  }
  var_4 = spawnStruct();
  self.super = var_4;
  var_4.staticdata = var_3;
  var_4.allowrefund = 1;
  var_4.numkills = 0;
  var_4.wasrefunded = 0;
  var_4.canstow = 0;
  var_4.basepoints = 0;
  var_4.extrapoints = 0;
  var_4.usestarttime = undefined;
  var_4.usepercent = 0.0;
  var_4._id_12187 = undefined;
  _id_131C7(0);
  _id_13985(var_0);
  self setclientomnvar("_encstr_863D0DEBA7F1BEA0604F53CEB25D70", var_0);
  var_5 = self.pers["_encstr_B24910EF882B4D0BB587E21F6787F21EF310"];

  if(!isDefined(var_5))
    var_5 = 0;

  self.pers["_encstr_B24910EF882B4D0BB587E21F6787F21EF310"] = undefined;
  setsuperbasepoints(var_5);
  var_6 = self.pers["_encstr_9AB511B957E095C98AC38EE40B14F6D2B93A9B"];

  if(!isDefined(var_6))
    var_6 = 0;

  self.pers["_encstr_9AB511B957E095C98AC38EE40B14F6D2B93A9B"] = undefined;
  setsuperextrapoints(var_6);

  if(!isDefined(self.pers["_encstr_93410E5BC0893FABF56B202D08B9BF07"]))
    _id_131C6(0);

  if(istrue(var_2)) {
    givesuperpoints(getsuperpointsneeded());
    var_4.madeavailabletime = gettime();
    scripts\mp\analyticslog::logevent_superearned(var_4.madeavailabletime);
  }

  if(!issuperweapondisabled()) {
    scripts\cp_mp\utility\inventory_utility::_giveweapon(var_3.weapon);
    var_7 = scripts\engine\utility::ter_op(issuperready(), 1, 0);
    self setweaponammoclip(var_3.weapon, var_7);
    self assignweaponoffhandspecial(var_3.weapon);
  }

  thread watchforsuperusebegin();
  thread handlespectating();

  if(scripts\mp\utility\game::getgametype() != "_encstr_B607038AAB" || level.allowsupers) {
    thread watchforrespawn();
    thread storesupercooldownforroundchange();
    thread handleteamchange();
  }
}

handlesuperearnovertime() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(scripts\mp\utility\game::getgametype() != "_encstr_B607038AAB")
    scripts\mp\flags::gameflagwait("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");

  var_0 = gettime();
  waitframe();

  for(;;) {
    var_1 = level.players.size;
    var_2 = (gettime() - var_0) / 50;

    if(var_2 < 11) {
      wait((11 - var_2) * 0.05);
      var_2 = 11;
    }

    var_0 = gettime();

    for(var_3 = 0; var_3 < var_1; var_3 = var_3 + 15) {
      for(var_4 = 0; var_4 < 15; var_4++) {
        var_5 = var_3 + var_4;
        var_6 = level.players[var_5];

        if(!isDefined(var_6)) {
          continue;
        }
        if(istrue(var_6.pausesuperpointsovertime)) {
          continue;
        }
        if(!scripts\mp\utility\player::isreallyalive(var_6)) {
          continue;
        }
        if(isDefined(var_6 getcurrentsuper()) && !var_6 getcurrentsuper().isinuse)
          var_6 givesuperpoints(0, "_encstr_84EF055338A18F", 0, var_2);
      }

      waitframe();
    }

    waitframe();
  }
}

clearsuper(var_0) {
  var_1 = getcurrentsuper();

  if(isDefined(var_1) && isDefined(var_1.staticdata))
    _id_13986(var_1.staticdata.ref);

  if(istrue(var_0) && isDefined(var_1))
    storesuperpoints();

  self clearoffhandspecial();

  if(isDefined(var_1))
    scripts\cp_mp\utility\inventory_utility::_takeweapon(var_1.staticdata.weapon);

  if(level.codcasterenabled && !isagent(self))
    self setspecialactive(0);

  self notify("_encstr_B8810D482F7F452E5D211F9D2F89AA");
  self.super = undefined;
  thread _calloutmarkerping_handleluinotify_added::_id_1313D("_encstr_881A0F57B4AFB9BA8356C97DB98E58E8CA", 0);
  self setclientomnvar("_encstr_863D0DEBA7F1BEA0604F53CEB25D70", "_encstr_8BBA05185F8B99");
}

_id_13985(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  if(var_0 == "_encstr_8BBA05185F8B99" || var_0 == "_encstr_B40101") {
    return;
  }
  var_1 = level.superglobals.staticsuperdata[var_0];

  if(!isDefined(var_1)) {
    return;
  }
  var_2 = var_1.setfunc;

  if(!isDefined(var_2)) {
    return;
  }
  self thread[[var_2]]();
}

_id_13986(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  if(var_0 == "_encstr_8BBA05185F8B99" || var_0 == "_encstr_B40101") {
    return;
  }
  var_1 = level.superglobals.staticsuperdata[var_0];

  if(!isDefined(var_1)) {
    return;
  }
  var_2 = var_1.unsetfunc;

  if(!isDefined(var_2)) {
    return;
  }
  self thread[[var_2]]();
}

setsuperbasepoints(var_0, var_1) {
  var_2 = getcurrentsuper();
  var_2.basepoints = clamp(var_0, 0, getsuperpointsneeded());

  if(istrue(var_1)) {
    return;
  }
  superpointschanged();
}

setsuperextrapoints(var_0, var_1) {
  var_2 = getcurrentsuper();
  var_2.extrapoints = clamp(var_0, 0, getsuperpointsneeded());

  if(istrue(var_1)) {
    return;
  }
  superpointschanged();
}

superpointschanged() {
  var_0 = getcurrentsuper();

  if(getcurrentsuperpoints() >= getsuperpointsneeded())
    superearned();
  else
    self setweaponammoclip(var_0.staticdata.weapon, 0);

  _id_14021();
  updatesuperuistate();
}

givesuperpoints(var_0, var_1, var_2, var_3) {
  if(istrue(game["_encstr_AA010E901794F93B2A1E8B16B4F345E0"]) || !level.allowsupers) {
    return;
  }
  if(isDefined(var_1))
    var_0 = getsuperpointsforevent(var_1);

  if(isDefined(var_3))
    var_0 = var_0 * var_3;

  if(scripts\mp\utility\perk::_hasperk("_encstr_845E1F43325528832AF3A1A32702DFE0FCCFEB5E5FB1C0C95257ABB9EFAB17E085"))
    var_0 = var_0 * getdvarfloat("_encstr_BA351F50EBB0FC571C190B03E16E1FF73043F4CC0760C26F3E31721A8E461FABF8");

  if(getdvarint("_encstr_8BCE1760CA62BF89AF63A72E44A757A34A32E00162FC65432F", 0) && !istrue(var_2)) {
    return;
  }
  if(isDefined(var_1) && var_1 == "_encstr_84EF055338A18F")
    var_4 = var_0 * level.superfastchargerate;
  else
    var_4 = var_0 * level.superpointsmod;

  if(var_4 <= 0) {
    return;
  }
  var_5 = getcurrentsuper();

  if(!isDefined(var_5) || issuperready() || var_5.isinuse || issuperexpended()) {
    updatesppm(var_0, 0, var_1);
    return;
  }

  var_6 = min(var_4 + var_5.basepoints, getsuperpointsneeded());
  setsuperbasepoints(var_6);
  scripts\mp\analyticslog::logevent_reportsuperscore(var_4, gettime());
  updatesppm(var_0, 1, var_1);
}

_id_14021() {
  var_0 = getcurrentsuper();

  if(!isDefined(var_0)) {
    return;
  }
  if(scripts\mp\utility\player::isinkillcam() || !isalive(self)) {
    var_0._id_11FCD = undefined;
    return;
  }

  var_1 = 0.0;

  if(var_0.isinuse)
    var_1 = getsuperuseuiprogress();
  else if(!issuperexpended()) {
    var_2 = getsuperpointsneeded();
    var_1 = clamp(getcurrentsuperbasepoints() / var_2, 0.0, 1.0);
  }

  if(!isDefined(var_0._id_11FCD) || var_1 != var_0._id_11FCD)
    self setclientomnvar("_encstr_8C0B120DAB81A257BF21B369AB96071F402B8373", var_1);

  self setplayersupermeterprogress(var_1);
  var_0._id_11FCD = var_1;
}

updatesuperuistate() {
  var_0 = getcurrentsuper();

  if(!isDefined(var_0)) {
    return;
  }
  if(scripts\mp\utility\player::isinkillcam() || !isalive(self)) {
    var_0.state = undefined;
    return;
  }

  var_1 = var_0.state;
  var_2 = 1;

  if(issuperexpended())
    var_2 = 4;
  else if(issuperready())
    var_2 = 2;
  else if(issuperinuse())
    var_2 = 3;

  if(!isDefined(var_1) || var_2 != var_1)
    thread _calloutmarkerping_handleluinotify_added::_id_1313D("_encstr_881A0F57B4AFB9BA8356C97DB98E58E8CA", var_2);

  var_0.state = var_2;
}

watchforrespawn() {
  var_0 = getcurrentsuper();
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_B8810D482F7F452E5D211F9D2F89AA");

  for(;;) {
    self waittill("_encstr_A76F0F9B1C16BB37B246FAC1C616E59527");
    givesuperweapon(var_0);
  }
}

storesupercooldownforroundchange() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_B8810D482F7F452E5D211F9D2F89AA");
  scripts\mp\flags::levelflagwait("_encstr_ACCF0A3B0BD6B2EBDB3BAC27");

  if(istrue(game["_encstr_B4A90E9ACB88E33BC3B7FF2B87F5A25C"])) {
    return;
  }
  storesuperpoints();
}

handlespectating() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_B8810D482F7F452E5D211F9D2F89AA");
  self waittill("_encstr_A2D01235B7B4B95919F5371C2B361D5847B7E49B");
  thread clearsuper(1);
}

handleteamchange() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_B8810D482F7F452E5D211F9D2F89AA");
  var_0 = self.team;
  self waittill("_encstr_81170C244F9CBDE72C01BB99A298");

  if(self.team != var_0) {
    self.currentfirstupgrade = undefined;
    thread clearsuper(0);
  }
}

handlepointdecay() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_B8810D482F7F452E5D211F9D2F89AA");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = getcurrentsuper();
  var_1 = getdvarfloat("_encstr_9B5E1516768B17CBD55BB818FF1CC1A74218981E4E433B", 6.0) * level.framedurationseconds;

  for(;;) {
    if(!issupercharging()) {
      waitframe();
      continue;
    }

    var_2 = max(var_0.extrapoints - var_1, 0);
    setsuperextrapoints(var_2);
    waitframe();
  }
}

superearned() {
  var_0 = getcurrentsuper();
  self setweaponammoclip(var_0.staticdata.weapon, 1);
  var_1 = !var_0.wasrefunded;
  self notify("_encstr_A3F20C0B33A3EDC8812283835C70", var_1);

  if(var_1) {
    self.pers["_encstr_8CA50D83B05BC18A16EDD8153E88E8"]++;
    self notify("_encstr_B4E80D3373E2CDCA5E5913A6C5E0B1");
    recordsuperearnedanalytics(var_0);
  }

  var_0.madeavailabletime = gettime();
  var_0.numkills = 0;
  scripts\mp\analyticslog::logevent_superearned(var_0.madeavailabletime);
  setsuperextrapoints(0, 1);
  setsuperbasepoints(getsuperpointsneeded(), 1);

  if(isDefined(self.matchdatalifeindex))
    scripts\mp\analyticslog::logevent_fieldupgradeearned(self, var_0.staticdata.id);
}

watchforsuperusebegin() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_B8810D482F7F452E5D211F9D2F89AA");

  for(;;) {
    self waittill("_encstr_AA22154B3A4D309B228BFFA7C74A5F08EE59518022B5C0", var_0);
    var_1 = trysuperusebegin(var_0);

    if(!istrue(var_1)) {
      continue;
    }
    self waittill("_encstr_950113E6EA07CA93EBABB995FACCB4DCD26E0D2B19");
  }
}

trysuperusebegin(var_0) {
  if(!scripts\mp\utility\player::isreallyalive(self))
    return 0;

  if(var_0.basename != getcurrentsuper().staticdata.weapon)
    return 0;

  if(!scripts\common\utility::is_supers_allowed())
    return 0;

  return beginsuperuse();
}

beginsuperuse() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  var_0 = getcurrentsuper();
  self notify("_encstr_97E30E6EAB1CCA93D76EE816E4479591");
  scripts\mp\gamelogic::sethasdonecombat(self, 1);

  if(var_0.staticdata.weapon == "_encstr_92BC0F408BC20108238458CE67F3F6F32A")
    self playlocalsound("_encstr_87061779742FC7CAEB9873A8CE8CF9BA2F82315595A011E7AB");
  else {}

  if(isDefined(var_0) && !var_0.isinuse) {
    var_1 = !istrue(self.inlaststand) || var_0.staticdata.canuseinlaststand;
    var_2 = 1;

    if(isDefined(var_0.staticdata.useweapon)) {
      if(scripts\mp\arbitrary_up::isinarbitraryup() && superdisabledinarbitraryup(var_0.staticdata.ref)) {
        superdisabledinarbitraryupmessage();
        var_2 = 0;
      } else if(!var_1)
        var_2 = 0;
      else
        var_2 = trygiveuseweapon(var_0.staticdata.useweapon, var_0.staticdata.useweaponclipammo, var_0.staticdata.useweaponstockammo);
    }

    if(var_2 && var_1 && (!isDefined(var_0.staticdata.beginusefunc) || istrue(self[[var_0.staticdata.beginusefunc]]()))) {
      var_3 = [];
      var_3[0] = "_encstr_BE3D16D745322B1E5F4B7BA1F1635B908CBB6963FC51106E";
      var_3[1] = "_encstr_82F00FC36FD91A5DC6E28B69E8313CD5EA";
      setsuperbasepoints(0);
      setsuperextrapoints(0);
      _id_131C7(1);
      var_0.allowrefund = scripts\engine\utility::ter_op(var_0.staticdata.graceperiod > 0, 1, 0);
      var_0.usestarttime = gettime();
      var_0.usepercent = 1.0;
      self notify("_encstr_9A1612DCD50756E4EBBAB92BBEB91D0B933A5646");
      thread updateusetimedecay();

      if(isDefined(self.matchdatalifeindex))
        scripts\mp\analyticslog::logevent_fieldupgradeactivated(self, var_0.staticdata.id);

      combatrecordsuperuse(var_0.staticdata.ref);

      if(level.codcasterenabled)
        self setspecialactive(1);

      scripts\mp\utility\print::printgameaction("_encstr_BA0A15522308EDA36F93BFFF21EE0B21A0AB4F1FF18AF0" + var_0.staticdata.ref, self);
      return 1;
    } else {
      if(isDefined(var_0.staticdata.useweapon) && var_2)
        thread switchandtakesuperuseweapon();

      if(istrue(self.inlaststand))
        thread _id_144FA(var_0.staticdata.weapon);
      else
        self setweaponammoclip(var_0.staticdata.weapon, 1);
    }
  }

  return 0;
}

activatesuper(var_0, var_1) {
  var_2 = getcurrentsuper();

  if(!isDefined(var_0))
    var_0 = 0;

  if(var_0 && isDefined(var_2.staticdata.activatepenaltyalt))
    reducesuperusepercent(var_2.staticdata.activatepenaltyalt, var_1);
  else if(isDefined(var_2.staticdata.activatepenalty))
    reducesuperusepercent(var_2.staticdata.activatepenalty, var_1);

  return 1;
}

updateusetimedecay() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_950113E6EA07CA93EBABB995FACCB4DCD26E0D2B19");
  var_0 = getcurrentsuper();

  if(!isDefined(var_0.staticdata.usetime)) {
    waitframe();

    if(issuperinuse())
      superusefinished();

    return;
  }

  if(var_0.staticdata.usetime < 0) {
    return;
  }
  for(;;) {
    waitframe();

    if(isDefined(var_0.staticdata.usedelay)) {
      var_1 = gettime() - var_0.usestarttime;

      if(var_1 < var_0.staticdata.usedelay)
        continue;
    }

    var_2 = level.framedurationseconds / var_0.staticdata.usetime;
    reducesuperusepercent(var_2);
    _id_14021();
    updatesuperuistate();
  }
}

reducesuperusepercent(var_0, var_1, var_2) {
  var_3 = getcurrentsuper();
  var_3.usepercent = max(var_3.usepercent - var_0, 0.0);

  if(istrue(var_1))
    var_3.allowrefund = 0;

  if(!isDefined(var_2) || var_2 == 0)
    superusedurationupdated();
}

resetsuperusepercent() {
  var_0 = getcurrentsuper();
  var_0.usepercent = 1.0;
  superusedurationupdated();
}

superusedurationupdated() {
  var_0 = getcurrentsuper();

  if(isbot(self)) {
    if(isDefined(var_0.staticdata.useweapon) && var_0.staticdata.isweapon == 1) {
      var_1 = self getammocount(var_0.staticdata.useweapon);

      if(isDefined(var_1) && var_1 > 0) {
        superusefinished();
        return;
      }
    }
  }

  if(var_0.usepercent <= 0.0)
    superusefinished();
}

superusefinished(var_0, var_1, var_2, var_3) {
  var_4 = getcurrentsuper();
  self notify("_encstr_BE3D16D745322B1E5F4B7BA1F1635B908CBB6963FC51106E");
  var_5 = 0;

  if(!isDefined(var_3) || var_3 == 0)
    var_5 = shouldrefundsuper();

  _id_131C7(0);
  var_4.canstow = 0;
  var_6 = undefined;

  if(isDefined(var_4.staticdata.endusefunc)) {
    if(!isDefined(var_1))
      var_1 = 0;

    var_6 = self[[var_4.staticdata.endusefunc]](var_1);
  }

  if(var_5 || istrue(var_0) || istrue(var_6)) {
    _id_131C6(0);
    var_4.wasrefunded = 1;
    setsuperbasepoints(getsuperpointsneeded());
  } else if(istrue(var_2)) {
    _id_131C6(0);
    var_7 = getsuperpointsneeded() * var_4.usepercent;
    var_4.wasrefunded = 1;
    setsuperbasepoints(var_7);
  } else {
    _id_131C6(1);
    var_4.lastfinishtime = gettime();
    var_4.wasrefunded = 0;
  }

  thread switchandtakesuperuseweapon();
  var_8 = var_4.usestarttime - var_4.madeavailabletime;
  scripts\mp\analyticslog::logevent_superended(var_4.staticdata.ref, var_8, 0, var_4.numkills);

  if(level.codcasterenabled)
    self setspecialactive(0);

  scripts\mp\utility\print::printgameaction("_encstr_925213E65707594E80D56E5602567391CA3240D280" + var_4.staticdata.ref, self);

  if(scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB") {
    if(!level.allowsupers) {
      if(!istrue(var_0)) {
        self setclientomnvar("_encstr_857F16D54BD70E56C9ADEB38B08DDA58D9B2D7CD8E16E8CA", 0);
        self setclientomnvar("_encstr_8C0B120DAB81A257BF21B369AB96071F402B8373", 0);
      }
    } else if(var_4.staticdata.ending_mortars) {
      clearsuper();
      self setclientomnvar("_encstr_857F16D54BD70E56C9ADEB38B08DDA58D9B2D7CD8E16E8CA", 0);
      self setclientomnvar("_encstr_8C0B120DAB81A257BF21B369AB96071F402B8373", 0);
      thread _calloutmarkerping_handleluinotify_added::_id_1313D("_encstr_881A0F57B4AFB9BA8356C97DB98E58E8CA", 0);
    }
  }

  self notify("_encstr_950113E6EA07CA93EBABB995FACCB4DCD26E0D2B19");
  scripts\cp\vehicles\vehicle_compass_cp::_id_12097(var_4, var_5);
}

refundsuper() {
  var_0 = getcurrentsuper();

  if(isDefined(var_0)) {
    if(var_0.isinuse)
      superusefinished(1);
    else
      givesuperpoints(getsuperpointsneeded());
  }
}

handledeath() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(!issuperinuse()) {
    return;
  }
  var_0 = getcurrentsuper();
  var_1 = var_0.staticdata._id_12ACD;
  superusefinished(var_1, 1);
}

monitoruseweaponfiring(var_0) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_950113E6EA07CA93EBABB995FACCB4DCD26E0D2B19");
  self endon("_encstr_B8810D482F7F452E5D211F9D2F89AA");

  for(;;) {
    self waittill("_encstr_BE140DBB2B2CE0B773F5CC5AC9CA19", var_1);

    if(isnullweapon(var_1, var_0, 1))
      activatesuper(var_1.isalternate, 1);
  }
}

trygiveuseweapon(var_0, var_1, var_2) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  scripts\cp_mp\utility\inventory_utility::_giveweapon(var_0);
  self setweaponammoclip(var_0, var_1);
  self setweaponammostock(var_0, var_2);
  var_3 = scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(var_0, isbot(self));

  if(var_3) {
    thread manageuseweapon(var_0);
    thread monitoruseweaponfiring(var_0);
    return 1;
  }

  scripts\cp_mp\utility\inventory_utility::abortmonitoredweaponswitch(var_0);
  return 0;
}

manageuseweapon(var_0) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_950113E6EA07CA93EBABB995FACCB4DCD26E0D2B19");
  var_1 = getcurrentsuper();
  var_1.useweaponswapped = undefined;
  var_2 = 0;

  for(;;) {
    var_3 = self getcurrentweapon();

    if(!var_1.canstow && !isnullweapon(var_0, var_3, 1)) {
      if(var_3.basename == "_encstr_92D5124BEF5B69354B4250B8DAEBE728256FFBF1" || var_3.basename == "_encstr_A17810A09B234F7B6B65343E7993A0871D53")
        var_2 = 1;

      break;
    }

    waitframe();
  }

  if(issuperinuse()) {
    var_1.useweaponswapped = 1;
    superusefinished(undefined, undefined, var_2);
  }
}

switchandtakesuperuseweapon() {
  self endon("_encstr_AD75063D571AE108");
  var_0 = getcurrentsuper();
  var_1 = var_0.staticdata.useweapon;

  if(!isDefined(var_1)) {
    return;
  }
  if(scripts\cp_mp\utility\inventory_utility::isswitchingtoweaponwithmonitoring(var_1)) {
    scripts\cp_mp\utility\inventory_utility::abortmonitoredweaponswitch(var_1);
    return;
  }

  self notify("_encstr_82F00FC36FD91A5DC6E28B69E8313CD5EA");
  scripts\cp_mp\utility\inventory_utility::getridofweapon(var_1);
}

storesuperpoints() {
  var_0 = getcurrentsuper();

  if(!isDefined(var_0)) {
    return;
  }
  if(issupercharging() || issuperready()) {
    self.pers["_encstr_B24910EF882B4D0BB587E21F6787F21EF310"] = var_0.basepoints;
    self.pers["_encstr_9AB511B957E095C98AC38EE40B14F6D2B93A9B"] = var_0.extrapoints;
  } else if(issuperinuse() && shouldrefundsuper()) {
    var_1 = getsuperpointsneeded();
    self.pers["_encstr_82060C106BF23D13579FD3C5293F"] = var_0.usepercent * var_1;
    self.pers["_encstr_9AB511B957E095C98AC38EE40B14F6D2B93A9B"] = 0;
  } else {
    self.pers["_encstr_B24910EF882B4D0BB587E21F6787F21EF310"] = 0;
    self.pers["_encstr_9AB511B957E095C98AC38EE40B14F6D2B93A9B"] = 0;
  }
}

getsuperuseuiprogress() {
  var_0 = getcurrentsuper();
  return var_0.usepercent;
}

getcurrentsuperbasepoints() {
  return getcurrentsuper().basepoints;
}

getcurrentsuperextrapoints() {
  return getcurrentsuper().basepoints;
}

getcurrentsuperpoints() {
  var_0 = getcurrentsuper();
  return var_0.basepoints + var_0.extrapoints;
}

getsuperpointsneeded() {
  var_0 = getcurrentsuper();
  var_1 = var_0.staticdata.pointsneeded;

  if(isDefined(var_0._id_12187))
    var_1 = var_0._id_12187;

  return var_1;
}

issuperready() {
  var_0 = getcurrentsuper();

  if(!isDefined(var_0) || var_0.isinuse)
    return 0;

  return getcurrentsuperpoints() >= getsuperpointsneeded();
}

issuperinuse() {
  return isDefined(getcurrentsuper()) && getcurrentsuper().isinuse;
}

_id_131C7(var_0) {
  var_1 = getcurrentsuper();
  var_1.isinuse = var_0;
  updatesuperuistate();
}

issupercharging() {
  return !issuperready() && !issuperinuse();
}

issuperexpended() {
  if(getdvarint("_encstr_9A5A1562318D994BC3B0A87E6041034BBDE5294F71A095", 1) == 0)
    return 0;

  return istrue(self.pers["_encstr_93410E5BC0893FABF56B202D08B9BF07"]);
}

_id_131C6(var_0) {
  self.pers["_encstr_93410E5BC0893FABF56B202D08B9BF07"] = var_0;
  updatesuperuistate();
}

getcurrentsuper() {
  return self.super;
}

getcurrentsuperref() {
  var_0 = getcurrentsuper();

  if(!isDefined(var_0))
    return undefined;

  return var_0.staticdata.ref;
}

shouldrefundsuper() {
  var_0 = getcurrentsuper();
  var_1 = var_0.staticdata.graceperiod;
  var_2 = undefined;

  if(isDefined(var_0) && isDefined(var_0.usestarttime))
    var_2 = gettime() - var_0.usestarttime;

  if(!isDefined(var_2) || var_2 >= var_1)
    return 0;

  if(var_0.numkills > 0)
    return 0;

  return var_0.allowrefund;
}

getsuperrefforsuperuseweapon(var_0) {
  if(!isstring(var_0))
    var_0 = var_0.basename;

  if(!isDefined(level.superglobals) || !isDefined(level.superglobals.superweapons) || !isDefined(level.superglobals.superweapons[var_0]))
    return undefined;

  return level.superglobals.superweapons[var_0].ref;
}

getsuperrefforsuperoffhand(var_0) {
  if(!isstring(var_0))
    var_0 = var_0.basename;

  if(!isDefined(level.superglobals.supersbyoffhand[var_0]))
    return undefined;

  return level.superglobals.supersbyoffhand[var_0].ref;
}

roundkillexecute(var_0) {
  if(!isstring(var_0))
    var_0 = var_0.basename;

  if(!isDefined(level.superglobals._id_13987[var_0]))
    return undefined;

  return level.superglobals._id_13987[var_0].ref;
}

getsuperrefforsuperweapon(var_0) {
  if(!isDefined(level.superglobals))
    return undefined;

  if(!isstring(var_0))
    var_0 = var_0.basename;

  var_1 = getsuperrefforsuperuseweapon(var_0);

  if(isDefined(var_1))
    return var_1;

  var_2 = getsuperrefforsuperoffhand(var_0);

  if(isDefined(var_2))
    return var_2;

  var_2 = roundkillexecute(var_0);

  if(isDefined(var_2))
    return var_2;

  return undefined;
}

shouldtracksuperweaponstats(var_0) {
  var_1 = getsuperrefforsuperweapon(var_0);

  if(isDefined(var_1)) {
    var_2 = level.superglobals.staticsuperdata[var_1];
    return var_2.useweapontrackstats;
  }

  return undefined;
}

getsuperid(var_0) {
  if(!isDefined(var_0) || !isDefined(level.superglobals) || !isDefined(level.superglobals.staticsuperdata) || !isDefined(level.superglobals.staticsuperdata[var_0]) || var_0 == "_encstr_8BBA05185F8B99")
    return 0;

  return level.superglobals.staticsuperdata[var_0].id;
}

getmovespeedforsuperweapon(var_0) {
  var_1 = getsuperrefforsuperweapon(var_0);

  if(!isDefined(var_1))
    return undefined;

  return level.superglobals.staticsuperdata[var_1].movespeed;
}

getrootsuperref(var_0) {
  return getsubstr(var_0, 6);
}

allowsuperweaponstow() {
  var_0 = getcurrentsuper();

  if(!isDefined(var_0) || !var_0.isinuse) {
    return;
  }
  var_0.canstow = 1;
}

unstowsuperweapon() {
  var_0 = getcurrentsuper();

  if(!isDefined(var_0) || !var_0.canstow) {
    return;
  }
  if(!var_0.isinuse || !isDefined(var_0.staticdata.useweapon)) {
    var_0.canstow = 0;
    return;
  }

  scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(var_0.staticdata.useweapon);
  var_0.canstow = 0;
}

getsuperpointsforevent(var_0) {
  var_1 = level.superglobals.pointeventdata[var_0];

  if(!isDefined(var_1))
    return 0;

  return var_1;
}

watchforgameend() {
  level waittill("_encstr_9B1D0BC7932875276230426AA1");

  if(scripts\mp\utility\game::waslastround()) {
    foreach(var_1 in level.players)
    var_1 writesppmstats();
  }
}

getsppmdata() {
  if(getdvarint("_encstr_85CD0EF720731F73A9770D8955B33BE9", 0) == 0) {
    return;
  }
  if(isai(self)) {
    return;
  }
  if(!isDefined(self.sppmdata)) {
    self.sppmdata = self.pers["_encstr_913B0988EF2B45FC12B326"];

    if(!isDefined(self.sppmdata)) {
      self.sppmdata = spawnStruct();
      self.sppmdata.totalpoints = 0;
      self.sppmdata.totalappliedpoints = 0;
      self.sppmdata.eventtotals = [];
      self.pers["_encstr_913B0988EF2B45FC12B326"] = self.sppmdata;
    }
  }

  return self.sppmdata;
}

updatesppm(var_0, var_1, var_2) {
  if(getdvarint("_encstr_85CD0EF720731F73A9770D8955B33BE9", 0) == 0) {
    return;
  }
  if(isai(self)) {
    return;
  }
  var_3 = getsppmdata();
  var_3.totalpoints = var_3.totalpoints + var_0;

  if(istrue(var_1))
    var_3.totalappliedpoints = var_3.totalappliedpoints + var_0;

  if(!isDefined(var_2))
    var_2 = "_encstr_8C500ABA9B23CACC2D37AC8C";

  if(!isDefined(var_3.eventtotals[var_2]))
    var_3.eventtotals[var_2] = var_0;
  else
    var_3.eventtotals[var_2] = var_3.eventtotals[var_2] + var_0;
}

writesppmstats() {
  if(getdvarint("_encstr_85CD0EF720731F73A9770D8955B33BE9", 0) == 0) {
    return;
  }
  if(isai(self)) {
    return;
  }
  var_0 = getsppmdata();
  var_1 = scripts\mp\persistence::statgetchildbuffered("_encstr_8C4606C9DBD5CD46", "_encstr_881A0B47B4B6B2286316E59532", 1) / 60.0;
  var_2 = 0.0;
  var_3 = 0.0;

  if(var_1 > 0.0) {
    var_2 = var_0.totalpoints / var_1;
    var_3 = var_0.totalappliedpoints / var_1;
  }

  var_4 = "_encstr_B40101";
  var_5 = -1;

  foreach(var_8, var_7 in var_0.eventtotals) {
    if(var_7 > var_5) {
      var_5 = var_7;
      var_4 = var_8;
    }
  }

  getentitylessscriptablearray("_encstr_81740E3783EBEBAB43AF83711659C3BD", ["_encstr_8619059BC138B5", var_2, "_encstr_AB130DB90E075B7DB0E0E036A55632", var_3, "_encstr_AAAC09D09972B9C83F2B7F", scripts\mp\utility\game::getgametype(), "_encstr_8E8D0697EB01F243", self.kills, "_encstr_A5140CAB0363EA9FCBA8573FC861", var_1, "_encstr_8AF70BCE65CF8BB7577330506B", var_4, "_encstr_92E30F521AF3E850D51F6BCF02DA1AAF38", getscriptdataversion()]);
}

modifysuperequipmentdamage(var_0, var_1, var_2, var_3, var_4) {
  var_5 = var_3;

  if(isDefined(self.owner) && isDefined(var_0) && var_0 == self.owner)
    var_5 = int(ceil(var_3 * 0.5));

  return var_5;
}

updateactivesupers(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = isDefined(var_0) && isPlayer(var_0);
  var_9 = var_5.basename == "_encstr_8AF511A30D4EDEDDB4CDB35BE6A5CC2BFA5B83" || var_5.basename == "_encstr_960F162D78EBD03757808747D2441CF1E1F7D3A550F9BB83" || var_5.basename == "_encstr_BE851AF4BC20B024C3484117800164B0774058673AC34BF9AFF96170" || var_5.basename == "_encstr_8AF817C568CBE8E754F22078CA6C8DE1270C4E33F41B560BFA";
  var_10 = var_9 && isDefined(var_0) && isDefined(var_0.classname) && var_0.classname == "_encstr_8C8D08671D451291C849";
  var_11 = isDefined(var_1) && isPlayer(var_1) && var_1 != var_2;

  if(var_11) {
    var_12 = var_1 getcurrentsuper();

    if(var_8 || var_10) {
      if(isDefined(var_12) && var_12.staticdata.ref == "_encstr_A66C12DE3B63AB1307C36048AB4308C15A655E6D" && var_1 issuperinuse())
        var_1 thread scripts\mp\supers\super_deadsilence::superdeadsilence_onkill();
    }

    if(var_8 && var_0 scripts\mp\utility\perk::_hasperk("_encstr_A3AB171B171072EB2259E370D10E3BB170B739673A23B32913"))
      var_1 thread scripts\mp\supers\super_stoppingpower::_id_138EC(var_5);
  }
}

watchsuperdelay() {
  level endon("_encstr_8E9F10CD5D1C5693FA192B8D58F2F5B2DCC8");
  level endon("_encstr_AAF00AA3C077B857EFB7F045");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(scripts\mp\utility\game::isanymlgmatch())
    level.superdelay = 0;
  else
    level.superdelay = getdvarfloat("_encstr_87FC0F38923A17C367C80DFE944F6833A0", 0);

  if(scripts\mp\utility\game::getgametype() != "_encstr_B607038AAB")
    scripts\mp\flags::gameflagwait("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");

  if(level.superdelay == 0) {
    level.superdelaystarttime = gettime();
    level.superdelayendtime = level.superdelaystarttime;
    level notify("_encstr_8E9F10CD5D1C5693FA192B8D58F2F5B2DCC8");
  }

  level.superdelaystarttime = gettime();
  level.superdelayendtime = level.superdelaystarttime + level.superdelay * 1000;
  level notify("_encstr_88801237ABC1959CFA4656C658E5F56E478539D1");

  while(gettime() < level.superdelayendtime)
    waitframe();

  level notify("_encstr_8E9F10CD5D1C5693FA192B8D58F2F5B2DCC8");
}

watchplayersuperdelayweapon() {
  level endon("_encstr_AAF00AA3C077B857EFB7F045");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_A1920EDB8119373263808852E85FABA7");
  self notify("_encstr_A3911CE797742A3849A9D9A2639349935008E569E5B03B537B3A7E892DAD");

  if(superdelaypassed()) {
    return;
  }
  scripts\common\utility::allow_supers(0, "_encstr_8DEC0C3EFD4B217541DA88C8A2E0");
  scripts\engine\utility::waittill_any_ents(level, "_encstr_8E9F10CD5D1C5693FA192B8D58F2F5B2DCC8", self, "_encstr_A3911CE797742A3849A9D9A2639349935008E569E5B03B537B3A7E892DAD");
  scripts\common\utility::allow_supers(1, "_encstr_8DEC0C3EFD4B217541DA88C8A2E0");
}

superdelaypassed() {
  return isDefined(level.superdelayendtime) && gettime() >= level.superdelayendtime;
}

cancelsuperdelay() {
  level.superdelay = 0;
  level.superdelaystarttime = gettime();
  level.superdelayendtime = level.superdelaystarttime;
  level notify("_encstr_8E9F10CD5D1C5693FA192B8D58F2F5B2DCC8");
}

setsuperweapondisabled(var_0) {
  self.issuperdisabled = var_0;

  if(!var_0)
    endsuperdisableweapon();
  else {
    self notify("_encstr_AC6714F04BD3A3AA9F69945B4F6BD387404AD08F4333");
    thread watchsuperdisableplayer();
  }
}

issuperweapondisabled() {
  return istrue(self.issuperdisabled);
}

watchsuperdisableplayer() {
  self endon("_encstr_B8810D482F7F452E5D211F9D2F89AA");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_AAF00AA3C077B857EFB7F045");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self notify("_encstr_A62812B9BAE0CA937D8CB46EC231D856AFCA7323");
  self endon("_encstr_A62812B9BAE0CA937D8CB46EC231D856AFCA7323");
  var_0 = getcurrentsuper();

  if(isDefined(var_0)) {
    var_1 = var_0.staticdata.weapon;
    scripts\cp_mp\utility\inventory_utility::_takeweapon(var_1);
    givesuperdisableweapon();
  }

  thread cleanupsuperdisableweapon();

  if(!istrue(scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B")))
    level waittill("_encstr_88801237ABC1959CFA4656C658E5F56E478539D1");

  for(;;) {
    self waittill("_encstr_AA22154B3A4D309B228BFFA7C74A5F08EE59518022B5C0", var_2);

    if(var_2.basename != "_encstr_8AA60F93A370283EF983D3F9AFA3902028") {
      continue;
    }
    self setweaponammoclip(var_2, 99);

    if(issuperready()) {
      var_3 = (level.superdelayendtime - gettime()) / 1000;
      var_3 = int(max(0, ceil(var_3)));

      if(var_3 > 0)
        scripts\mp\hud_message::showerrormessage("_encstr_B26E1CD58FFAD3295FFB232FE7E5A07999355CEDC5C984E030054F13FF27", var_3);
      else
        scripts\mp\hud_message::showerrormessage("_encstr_8CA5166099B0074387ED41570F09B941615FDC95B6A06909");
    }
  }
}

cleanupsuperdisableweapon() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_AAF00AA3C077B857EFB7F045");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_A62812B9BAE0CA937D8CB46EC231D856AFCA7323");
  self notify("_encstr_86D11DA0A9AB7A51499BA877D3B1A3813960F10A7F0150D0FFE067B9C06367");
  self endon("_encstr_86D11DA0A9AB7A51499BA877D3B1A3813960F10A7F0150D0FFE067B9C06367");

  for(;;) {
    self waittill("_encstr_B8810D482F7F452E5D211F9D2F89AA");
    scripts\cp_mp\utility\inventory_utility::_takeweapon("_encstr_8AA60F93A370283EF983D3F9AFA3902028");
  }
}

endsuperdisableweapon() {
  var_0 = getcurrentsuper();

  if(isDefined(var_0)) {
    var_1 = var_0.staticdata.weapon;
    var_2 = scripts\engine\utility::ter_op(issuperready(), 1, 0);
    scripts\cp_mp\utility\inventory_utility::_giveweapon(var_1);
    self setweaponammoclip(var_1, var_2);
    self assignweaponoffhandspecial(var_1);
    scripts\cp_mp\utility\inventory_utility::_takeweapon("_encstr_8AA60F93A370283EF983D3F9AFA3902028");
  }

  self notify("_encstr_A62812B9BAE0CA937D8CB46EC231D856AFCA7323");
}

givesuperdisableweapon() {
  scripts\cp_mp\utility\inventory_utility::_giveweapon("_encstr_8AA60F93A370283EF983D3F9AFA3902028");
  self setweaponammoclip("_encstr_8AA60F93A370283EF983D3F9AFA3902028", 99);
  self assignweaponoffhandspecial("_encstr_8AA60F93A370283EF983D3F9AFA3902028");
}

givesuperweapon(var_0) {
  if(superdelaypassed()) {
    if(!self hasweapon(var_0.staticdata.weapon)) {
      var_1 = scripts\engine\utility::ter_op(issuperready(), 1, 0);
      scripts\cp_mp\utility\inventory_utility::_giveweapon(var_0.staticdata.weapon);
      self setweaponammoclip(var_0.staticdata.weapon, var_1);
      self assignweaponoffhandspecial(var_0.staticdata.weapon);
    }
  } else
    givesuperdisableweapon();
}

watchobjuse(var_0, var_1) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_86490E57EA1C794DB36240A8A9C77018");
  self endon("_encstr_922C0D1DB9CDB0605BE350BBAB37A5");

  if(scripts\mp\utility\game::getgametype() == "_encstr_B807035284" || scripts\mp\utility\game::getgametype() == "_encstr_9B0703CD93" || scripts\mp\utility\game::getgametype() == "_encstr_B60703EACA") {
    if(istrue(var_1))
      self waittill("_encstr_92661027570F970339F8A6D2D8D17D51608D");
  } else if(!isDefined(self.carryobject))
    self waittill("_encstr_BD920E0FA530B1ABDB19CAD2013877B2");
  else
    wait 0.05;

  while(issuperinuse()) {
    reducesuperusepercent(var_0);
    wait 0.05;
  }
}

combatrecordsuperuse(var_0) {
  if(!scripts\mp\utility\stats::canrecordcombatrecordstats()) {
    return;
  }
  if(var_0 == "_encstr_8FD211AA40DBBD786627D98090200FF562A230") {
    return;
  }
  var_1 = self getplayerdata("_encstr_8C07031599", "_encstr_A7A20CC1D8585EAC4E9AE80B1D9B", "_encstr_AAA10B9645F399DDEA0340F06B", var_0, "_encstr_A5E405AB8F12FE");
  self setplayerdata("_encstr_8C07031599", "_encstr_A7A20CC1D8585EAC4E9AE80B1D9B", "_encstr_AAA10B9645F399DDEA0340F06B", var_0, "_encstr_A5E405AB8F12FE", var_1 + 1);
}

combatrecordsuperkill(var_0) {
  if(!scripts\mp\utility\stats::canrecordcombatrecordstats()) {
    return;
  }
  var_1 = self getplayerdata("_encstr_8C07031599", "_encstr_A7A20CC1D8585EAC4E9AE80B1D9B", "_encstr_AAA10B9645F399DDEA0340F06B", var_0, "_encstr_8E8D0697EB01F243");
  self setplayerdata("_encstr_8C07031599", "_encstr_A7A20CC1D8585EAC4E9AE80B1D9B", "_encstr_AAA10B9645F399DDEA0340F06B", var_0, "_encstr_8E8D0697EB01F243", var_1 + 1);
}

hide_plunderboxes(var_0, var_1) {
  if(!scripts\mp\utility\stats::canrecordcombatrecordstats()) {
    return;
  }
  if(!isDefined(var_1))
    var_1 = 1;

  var_2 = relic_fastbleedout_returnfunc(var_0);
  self setplayerdata("_encstr_8C07031599", "_encstr_A7A20CC1D8585EAC4E9AE80B1D9B", "_encstr_AAA10B9645F399DDEA0340F06B", var_0, "_encstr_A362065BE9A260EF", var_2 + var_1);
}

relic_fastbleedout_returnfunc(var_0) {
  return self getplayerdata("_encstr_8C07031599", "_encstr_A7A20CC1D8585EAC4E9AE80B1D9B", "_encstr_AAA10B9645F399DDEA0340F06B", var_0, "_encstr_A362065BE9A260EF");
}

superdisabledinarbitraryup(var_0) {
  if(var_0 == "_encstr_9365121B9BA1525AD8EB9383BA10CC7BAB50F511" || var_0 == "_encstr_8A38123750F36523B7B64B0295D57B3AB8E0D367")
    return 1;

  return 0;
}

superdisabledinarbitraryupmessage() {
  scripts\mp\hud_message::showerrormessage("_encstr_8F621DD1B975676F8B95FE76B7A7348B8330792140F6E125DFF9E6C65F4F3F");
}

bradleybeginuse() {
  return scripts\cp_mp\vehicles\light_tank::light_tank_tryuse();
}

choppergunnerbeginuse() {
  return scripts\mp\killstreaks\killstreaks::trytriggerkillstreakfromsuper("_encstr_A3330F40DA85816BFF02D8CCFD2B50632A");
}

cruisepredatorbeginuse() {
  return scripts\mp\killstreaks\killstreaks::trytriggerkillstreakfromsuper("_encstr_B270105ECB28E94BC5CFABAB937D524C5053");
}

scramblebeginuse() {
  var_0 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self.origin + (0, 0, 400));
  self.scrambleent = var_0;
  self.scrambleent setModel("_encstr_8B7D1206236B05353F9FC32B688ADB5805FF09DB");
  self.scrambleent linkTo(self);
  self.scrambleent.owner = self;
  self.scrambleent.team = self.team;
  self.scrambleent setotherent(self);
  self.scrambleent setscriptablepartstate("_encstr_8DEB0D3EEB43A14B0E5A8851832739", "_encstr_AB0703DBB9", 0);
  thread scripts\cp_mp\killstreaks\helper_drone::spawn_ai_single(self);
  return 1;
}

scrambleusefinished(var_0) {
  self.scrambleent unlink();
  self.scrambleent delete();
  scripts\cp_mp\killstreaks\helper_drone::helperdrone_endscramblereffect();
}

trophyonset() {
  return scripts\mp\equipment\trophy_system::trophy_onsuperset();
}

jugg_removefromactivejugglist() {
  return _debug_rooftop_heli_start::jugg_getminigunweapon();
}

jugg_setherodropscriptable() {
  return _debug_rooftop_heli_start::jugg_go_to_node_callback();
}

tacinsertonset() {
  scripts\mp\equipment\tac_insert::tacinsert_set();
}

tacinsertonunset() {
  scripts\mp\equipment\tac_insert::tacinsert_unset();
}

remotedetonateonset() {}

remotedetonatebeginuse() {}

precisionairstrikebeginuse() {
  return scripts\mp\killstreaks\killstreaks::trytriggerkillstreakfromsuper("_encstr_BDF5147B33CD0FDC1043F7CE17B8E4036E6BD3927895");
}

tomastrikebeginuse() {
  return scripts\mp\killstreaks\killstreaks::trytriggerkillstreakfromsuper("_encstr_A2E60C6BC099B7E1A0A93A398F48");
}

pacsentrybeginuse() {
  return scripts\mp\killstreaks\killstreaks::trytriggerkillstreakfromsuper("_encstr_B1B30B51D176511E377A1BC313");
}

brcircleextract() {}

uavbeginuse() {
  return scripts\mp\killstreaks\killstreaks::trytriggerkillstreakfromsuper("_encstr_851904B59B34");
}

taccoverbeginuse() {
  return scripts\mp\equipment\tactical_cover::tac_cover_on_fired_super();
}

taccoverunset() {
  return scripts\mp\equipment\tactical_cover::tac_cover_on_take_super();
}

recondronebeginuse() {
  return scripts\cp_mp\killstreaks\helper_drone::recondrone_beginsuper();
}

recondroneenduse(var_0) {
  return scripts\cp_mp\killstreaks\helper_drone::recondrone_endsuper(var_0);
}

recondroneunset() {
  scripts\cp_mp\killstreaks\helper_drone::recondrone_unsetsuper();
}

empdronebeginuse() {
  return scripts\cp_mp\killstreaks\emp_drone_targeted::empdrone_beginsuper();
}

deadsilencebeginuse() {
  return scripts\mp\supers\super_deadsilence::superdeadsilence_beginsuper();
}

deadsilenceenduse(var_0) {
  return scripts\mp\supers\super_deadsilence::superdeadsilence_endsuper(var_0);
}

supportboxunset() {
  scripts\mp\equipment\support_box::supportbox_unset();
}

laststandhealonset() {
  return scripts\mp\supers\laststand_heal::laststandheal_onset();
}

laststandhealunset() {
  return scripts\mp\supers\laststand_heal::laststandheal_unset();
}

laststandhealbeginuse() {
  return scripts\mp\supers\laststand_heal::laststandheal_beginuse();
}

stoppingpowerbeginuse() {
  return scripts\mp\supers\super_stoppingpower::stoppingpower_beginuse();
}

_id_11ED6() {
  return _luidecision::_id_11ED6();
}

superweapondropbeginuse() {
  return scripts\mp\equipment\weapon_drop::weapondrop_beginsuper();
}

_id_13988() {
  var_0 = scripts\mp\perks\perkpackage::perkpackage_getfirstfieldupgrade();
  _id_13985(var_0);
  self.super.firstupgrade = var_0;
  var_1 = scripts\mp\perks\perkpackage::perkpackage_getsecondfieldupgrade();
  _id_13985(var_1);
  self.super.secondupgrade = var_1;
  var_2 = level.superglobals.staticsuperdata[var_0];
  var_3 = 0;

  if(isDefined(var_2))
    var_3 = var_2.pointsneeded;

  var_2 = level.superglobals.staticsuperdata[var_1];
  var_4 = 0;

  if(isDefined(var_2))
    var_4 = var_2.pointsneeded;

  var_5 = max(var_3, var_4);
  self.super._id_12187 = var_5;
}

_id_13989() {
  var_0 = self.super.firstupgrade;
  _id_13986(var_0);
  var_1 = self.super.secondupgrade;
  _id_13986(var_1);
}

superselectbeginuse() {
  return scripts\mp\perks\perkpackage::perkpackage_openselect();
}

testsuperbeginuse() {
  thread testsuperrefundwatcher();
  return 1;
}

_id_1397F() {
  return 1;
}

_id_1398B() {
  return 1;
}

_id_1398D() {
  return 1;
}

_id_13984() {
  return 1;
}

_id_13981() {
  _donewithcorpse::vehicle_cp_create();
}

_id_13980() {
  return 1;
}

vehicle_createspawnselectionlittlebirdmarker(var_0) {
  _donewithcorpse::vehicle_compass_playerspawnedcallback();
}

_encstr_8C961537AB38569C9BC65ADCCEAC9C98CA3B4BDCEAE62B() {
  return _encstr_A31921E61B9CA583E86E5E5B1CCBAC5CAED2835B2B73D1CB9BB1B4CDB39539173B9B36::_encstr_A6EE12C74C4468A4872BEED1325B686811CD4F53();
}

_id_13983() {
  return 1;
}

_encstr_B1F6140703FE93AD8099B77F3130EA2ADCB3EB97D7AD() {
  var_0 = getcurrentsuper();
  var_1 = var_0.staticdata.usetime;
  thread _findnewlocaleplacement::_encstr_A7F5132F7C49B50BB9EF079AC33FA67740806783F3(var_1);
  return 1;
}

_encstr_A78D126E954EAB5B76588C76954756B98C5DCD59(var_0) {
  _findnewlocaleplacement::_encstr_83141263F8B8BBB8FB8FBB1BA3C83F91603F5233();
}

testsuperrefundwatcher() {
  self endon("_encstr_950113E6EA07CA93EBABB995FACCB4DCD26E0D2B19");

  for(;;) {
    if(self buttonPressed("_encstr_ACD6096A8DAF73CD85E989"))
      superusefinished(0, 0, 1);
    else if(self buttonPressed("_encstr_91D609E97F4BE94F26CF53"))
      superusefinished(1);

    waitframe();
  }
}

showsuperremindersplash() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(!istrue(self.superreminderset)) {
    self notify("_encstr_A76418DC86DEEE35AB832B27252BADD2CD8CB2E4D4E01B166EA1");
    self endon("_encstr_A76418DC86DEEE35AB832B27252BADD2CD8CB2E4D4E01B166EA1");
    self.superreminderset = 1;
    self setclientomnvar("_encstr_9AB812BA96BECDD5E02B4EBE9359D6D2B9322BE4", 1);
    wait 0.5;
    thread clearsuperremindersplash();
  } else {
    thread clearsuperremindersplash();
    self endon("_encstr_A76418DC86DEEE35AB832B27252BADD2CD8CB2E4D4E01B166EA1");
    waitframe();
    thread showsuperremindersplash();
    return;
  }
}

clearsuperremindersplash() {
  self notify("_encstr_A76418DC86DEEE35AB832B27252BADD2CD8CB2E4D4E01B166EA1");
  self.superreminderset = undefined;
  self setclientomnvar("_encstr_9AB812BA96BECDD5E02B4EBE9359D6D2B9322BE4", 0);
}

clearsuperreminderondeath(var_0) {
  if(!isPlayer(var_0)) {
    return;
  }
  thread clearsuperreminderondeathinternal(var_0);
}

clearsuperreminderondeathinternal(var_0) {
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 waittill("_encstr_AD75063D571AE108");
  var_0 clearsuperremindersplash();
}

initsuperdvars() {
  setdvarifuninitialized("_encstr_9B5E1516768B17CBD55BB818FF1CC1A74218981E4E433B", 6.0);
}

watchsuperlottery() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = getdvarint("_encstr_813016D28E93B7BE084A8882406819DB7F8A68316593B02B", 60);
  var_1 = getdvarint("_encstr_9BD21C0BBFE8A94F3D83C2BB2C186BDBF8058949CD806F8364594A7090E0", 45);
  var_2 = getdvarint("_encstr_97D21CA791FAE0BB13506988F9154BDB854B233C6D7B5D5BD353330DE24B", 90);
  var_3 = var_2 - var_1;
  waitframe();

  if(!istrue(scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B")))
    level waittill("_encstr_8FF80EBBE8D1ED92613E8C49105DEABA");

  wait(var_0);
  var_4 = undefined;
  var_5 = undefined;
  var_6 = [];
  var_7 = [];

  foreach(var_9 in level.teamnamelist) {
    var_6[var_9] = undefined;
    var_7[var_9] = [];
  }

  for(;;) {
    var_4 = var_5;
    var_5 = getdvarint("_encstr_BAE418EE8E73EF233D8310A01B4F9BE1AA72636D25BA5D0815CB", 0) > 0;

    if(!isDefined(var_4) || var_4 != var_5) {
      if(var_5)
        level notify("_encstr_8C5314B95D83CAE489B78E8EB2E4F2A23758131B5923");
      else
        level notify("_encstr_82AF15A33B508F13F908ABB3513EF70F60DF293AB15097");
    }

    foreach(var_9 in level.teamnamelist) {
      if(!isDefined(var_6[var_9])) {
        var_6[var_9] = gettime() + (var_1 + randomint(var_3)) * 1000;
        continue;
      }

      if(var_6[var_9] <= gettime()) {
        var_12 = scripts\mp\utility\teams::getteamdata(var_9, "_encstr_9775086022BE1B413B8B");

        if(var_12.size > 0) {
          var_12 = scripts\engine\utility::array_randomize(var_12);
          var_13 = [];
          var_14 = undefined;

          foreach(var_16 in var_12) {
            if(!scripts\engine\utility::array_contains(var_7[var_9], var_16)) {
              if(isDefined(var_16 getcurrentsuper())) {
                var_14 = var_16;
                break;
              }
            } else if(isDefined(var_16 getcurrentsuper()))
              var_13[var_13.size] = var_16;
          }

          if(!isDefined(var_14)) {
            if(isDefined(var_13[0]))
              var_14 = var_13[0];
            else
              var_14 = var_12[0];
          }

          if(var_5)
            childthread awardsuperlottery(var_14);

          var_7[var_7.size] = var_14;
        }

        var_6[var_9] = undefined;
      }
    }

    waitframe();
  }
}

_id_144FA(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self waittill("_encstr_852B140A41FF7CB923B8C7BB5FAF0691C293D8337B69");
  self setweaponammoclip(var_0, 1);
}

awardsuperlottery(var_0) {
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 endon("_encstr_81170C244F9CBDE72C01BB99A298");
  level endon("_encstr_82AF15A33B508F13F908ABB3513EF70F60DF293AB15097");
  var_0 notify("_encstr_B1D712B07716C9326A5783CAC9C4DBE88E59E45E");
  var_0 endon("_encstr_B1D712B07716C9326A5783CAC9C4DBE88E59E45E");

  for(;;) {
    var_1 = var_0 getcurrentsuper();

    if(!isDefined(var_1)) {
      return;
    }
    if(!var_0 issuperinuse()) {
      break;
    }

    waitframe();
  }

  var_0 givesuperpoints(getsuperpointsneeded(), undefined, 1);
}

getscriptdataversion() {
  if(getdvarint("_encstr_915E1088228AA7139349930D2587DBDF326A", 0) != 0)
    return 254;

  if(getdvarint("_encstr_A90F0DE66C39AF1CC6B0E5A395CDE8", 0) != 0)
    return 7;

  return 254;
}

recordsuperearnedanalytics(var_0) {
  if(getdvarint("_encstr_8F9F14C3E81539274BE7BDA26811373A45713A7AF88B", 0) == 0) {
    return;
  }
  var_1 = scripts\mp\persistence::statgetchildbuffered("_encstr_8C4606C9DBD5CD46", "_encstr_881A0B47B4B6B2286316E59532", 1) / 60.0;
  getentitylessscriptablearray("_encstr_978F17FAA8CFFEEB302F6457465B2B873539E2B2935D34E3A9", ["_encstr_B1C20A9BABE09527AF9359CC", var_0.staticdata.ref, "_encstr_AABF0A7842CA85B6B301D9C5", var_1, "_encstr_AAAC09D09972B9C83F2B7F", scripts\mp\utility\game::getgametype(), "_encstr_92E30F521AF3E850D51F6BCF02DA1AAF38", getscriptdataversion(), "_encstr_9A9C0D4DC9AAE5936D28AA4FAFCA5B", self.pers["_encstr_8CA50D83B05BC18A16EDD8153E88E8"]]);
}