/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\supers.gsc
***********************************************/

function init() {
  var_0 = spawnStruct();
  level.superglobals = var_0;
  var_0.staticsuperdata = [];
  var_0.superweapons = [];
  var_0.superearnratemultiplier = 1;
  var_0.supersbyid = [];
  var_0.supersbyoffhand = [];
  var_0.ref_13987 = [];
  var_0.pointeventdata = [];
  loadsupertable();
  loadpointstable();
  registersupers();
  initsuperdvars();
  scripts\mp\utility\spawn_event_aggregator::registeronplayerspawncallback(&clearsuperreminderondeath);
  thread watchforgameend();

  if(getdvarint("scr_superLotteryEnabled", 0) > 0) {
    thread watchsuperlottery();
  }

  if(level.allowsupers) {
    thread handlesuperearnovertime();
  }

  scripts\mp\equipment\tactical_cover::tac_cover_init();
  scripts\mp\equipment\support_box::supportbox_init();
  scripts\mp\equipment\ammo_box::ammobox_init();
  scripts\mp\supers\super_stoppingpower::ref_138e7();
  _luidecision::ref_11ed7();
  scripts\mp\utility\spawn_event_aggregator::registeronplayerspawncallback(&ref_13978);
  _debug_rooftop_heli_start::subscribetoquestlocale();
  level.setsuperweapondisabled = &setsuperweapondisabled;
  scripts\cp_mp\utility\script_utility::registersharedfunc("super", "watchSuperLastStandEnd", &ref_144fa);
}

function loadsupertable() {
  var_0 = scripts\mp\utility\game::getgametype() == "br";

  for(var_1 = 1;; var_1++) {
    var_2 = tablelookupbyrow("mp/supertable.csv", var_1, 0);

    if(!isDefined(var_2) || var_2 == "") {
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

    if(scripts\mp\utility\game::isanymlgmatch()) {
      var_5 = readsupertablecell(var_1, 28, 1);
    }

    if(!isDefined(var_5)) {
      var_5 = readsupertablecell(var_1, 2, 1);
    }

    var_4.pointsneeded = var_5;
    var_6 = undefined;

    if(scripts\mp\utility\game::isanymlgmatch()) {
      var_6 = readsupertablecell(var_1, 26, 1);
    }

    if(!isDefined(var_6)) {
      var_6 = readsupertablecell(var_1, 4, 1);
    }

    var_4.usetime = var_6;
    var_4.maxactivations = readsupertablecell(var_1, 5, 1);
    var_4.ref_12acd = readsupertablecell(var_1, 6, 1);
    var_4.useweapon = readsupertablecell(var_1, 11);
    var_4.useweaponclipammo = readsupertablecell(var_1, 12, 1);
    var_4.useweaponstockammo = readsupertablecell(var_1, 13, 1);
    var_4.useweapontrackstats = readsupertablecell(var_1, 31, 1) > 0;
    var_4.movespeed = readsupertablecell(var_1, 14, 1);
    var_7 = undefined;

    if(scripts\mp\utility\game::isanymlgmatch()) {
      var_7 = readsupertablecell(var_1, 27, 1);
    }

    if(!isDefined(var_7)) {
      var_7 = readsupertablecell(var_1, 15, 1);
    }

    var_4.graceperiod = var_7;
    var_4.maxactivationsalt = readsupertablecell(var_1, 16, 1);
    var_4.usedelay = readsupertablecell(var_1, 18, 1);
    var_4.ending_mortars = readsupertablecell(var_1, 19, 1);
    var_4.archetype = readsupertablecell(var_1, 17);
    var_4.isweapon = readsupertablecell(var_1, 20, 1);
    var_4.canuseinlaststand = readsupertablecell(var_1, 32, 1) > 0;
    var_4.packextrascore0 = [];

    if(isDefined(var_4.useweapon)) {
      var_4.useweapon = asmdevgetallstates(var_4.useweapon);
    }

    level.superglobals.supersbyid[var_1] = var_2;

    if(!isDefined(var_4.weapon)) {
      level.superglobals.staticsuperdata[var_2] = undefined;
    } else {
      level.superglobals.supersbyoffhand[var_4.weapon] = var_4;
    }

    if(!isDefined(var_4.pointsneeded)) {
      level.superglobals.staticsuperdata[var_2] = undefined;
    }

    if(isDefined(var_4.maxactivations)) {
      if(var_4.maxactivations > 0) {
        var_4.activatepenalty = 1 / var_4.maxactivations;
      } else {
        var_4.activatepenalty = 1;
      }
    }

    if(isDefined(var_4.maxactivationsalt)) {
      if(var_4.maxactivationsalt > 0) {
        var_4.activatepenaltyalt = 1 / var_4.maxactivationsalt;
      }
    }

    if(isDefined(var_4.useweapon)) {
      level.superglobals.superweapons[var_4.useweapon.basename] = var_4;
    }

    if(var_4.weapon == "<default>") {
      var_4.weapon = "super_default_mp";
    }

    if(isDefined(var_4.graceperiod)) {
      var_4.graceperiod *= 1000;
      continue;
    }

    var_4.graceperiod = 0;
  }

  var_8 = tablelookup("mp/superratetable.csv", 0, scripts\mp\utility\game::getgametype(), 1);

  if(isDefined(var_8) && var_8 != "") {
    level.superglobals.superearnratemultiplier = float(var_8);
    return;
  }
}

function readsupertablecell(var_0, var_1, var_2) {
  var_3 = tablelookupbyrow("mp/supertable.csv", var_0, var_1);

  if(var_3 == "") {
    return undefined;
  }

  if(istrue(var_2)) {
    if(issubstr(var_3, ".")) {
      var_3 = float(var_3);
    } else {
      var_3 = int(var_3);
    }
  }

  return var_3;
}

function loadpointstable() {
  var_0 = 2;
  var_1 = scripts\mp\utility\game::getgametype();

  for(;;) {
    var_2 = tablelookupbyrow("mp/superpointstable.csv", 0, var_0);

    if(!isDefined(var_2) || var_2 == "") {
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
    var_4 = tablelookupbyrow("mp/superpointstable.csv", var_3, 0);

    if(!isDefined(var_4) || var_4 == "") {
      break;
    }

    var_5 = undefined;

    if(isDefined(var_0)) {
      var_5 = tablelookupbyrow("mp/superpointstable.csv", var_3, var_0);

      if(isDefined(var_5) && var_5 == "") {
        var_5 = undefined;
      }
    }

    if(!isDefined(var_5)) {
      var_5 = tablelookupbyrow("mp/superpointstable.csv", var_3, 1);
    }

    var_5 = float(var_5);

    if(var_5 <= 0) {
      continue;
    }

    level.superglobals.pointeventdata[var_4] = var_5;
  }
}

function registersupers() {
  registersuper("super_test", undefined, undefined, &testsuperbeginuse, undefined);
  registersuper("super_bradley", undefined, undefined, &bradleybeginuse, undefined);
  registersuper("super_chopper_gunner", undefined, undefined, &choppergunnerbeginuse, undefined);
  registersuper("super_cruise_predator", undefined, undefined, &cruisepredatorbeginuse, undefined);
  registersuper("super_precision_airstrike", undefined, undefined, &precisionairstrikebeginuse, undefined);
  registersuper("super_toma_strike", undefined, undefined, &tomastrikebeginuse, undefined);
  registersuper("super_pac_sentry", undefined, undefined, &pacsentrybeginuse, undefined);
  registersuper("super_br_extract", undefined, undefined, &brcircleextract, undefined);
  registersuper("super_uav", undefined, undefined, &uavbeginuse, undefined);
  registersuper("super_tac_cover", undefined, &taccoverunset, &taccoverbeginuse, undefined);
  registersuper("super_recon_drone", undefined, &recondroneunset, &recondronebeginuse, &recondroneenduse);
  registersuper("super_emp_drone", undefined, undefined, &empdronebeginuse, undefined);
  registersuper("super_support_box", undefined, &supportboxunset, &stoppingpowerbeginuse, undefined);
  registersuper("super_laststand_heal", &laststandhealonset, &laststandhealunset, &laststandhealbeginuse, undefined);
  registersuper("super_remote_detonate", &remotedetonateonset, undefined, &remotedetonatebeginuse, undefined);
  registersuper("super_trophy", &trophyonset, undefined, undefined, undefined);
  registersuper("super_scramble", undefined, undefined, &scramblebeginuse, &scrambleusefinished);
  registersuper("super_deadsilence", undefined, undefined, &deadsilencebeginuse, &deadsilenceenduse);
  registersuper("super_tac_insert", &tacinsertonset, &tacinsertonunset, undefined, undefined);
  registersuper("super_ammo_drop", undefined, undefined, undefined, undefined);
  registersuper("super_armor_drop", undefined, undefined, undefined, undefined);
  registersuper("super_weapon_drop", undefined, undefined, &superweapondropbeginuse, undefined);
  registersuper("super_select", &ref_13988, &ref_13989, &superselectbeginuse, undefined);
  registersuper("super_fulton", undefined, undefined, &ref_1397f, undefined);
  registersuper("super_supply_drop", undefined, undefined, &ref_1398b, undefined);
  registersuper("super_vehicle_drop", undefined, undefined, &ref_1398d, undefined);
  registersuper("super_loot_drop", undefined, undefined, &ref_1398b, undefined);

  if(scripts\mp\utility\game::getgametype() == "br") {
    registersuper("super_decon_station", &jugg_removefromactivejugglist, &jugg_setherodropscriptable, undefined, undefined);
    registersuper("super_nova_box", undefined, undefined, &ref_11ed6, undefined);
    registersuper("super_kiosk_drop", undefined, undefined, &ref_13983, undefined);
    registersuper("super_jammer_br", undefined, &ref_13981, &ref_13980, &vehicle_createspawnselectionlittlebirdmarker);
    registersuper("super_serum_gadget", undefined, undefined, &serumgadgetbeginuse, &serumgadgetenduse);
    registersuper("super_slinger_br", undefined, undefined, &superslingerbeginuse, undefined);
  }

  ref_12b3c("super_emp_drone", "emp_drone_player_mp");
  ref_12b3c("super_emp_drone", "emp_drone_non_player_mp");
  ref_12b3c("super_emp_drone", "emp_drone_non_player_direct_mp");
  ref_12b3c("super_weapon_drop", "deploy_weapondrop_mp");
}

function registersuper(var_0, var_1, var_2, var_3, var_4) {
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

function ref_12b3c(var_0, var_1) {
  if(!isstring(var_1)) {
    var_1 = var_1.basename;
  }

  var_2 = level.superglobals.staticsuperdata[var_0];
  var_2.packextrascore0[var_2.packextrascore0.size] = var_1;
  level.superglobals.ref_13987[var_1] = var_2;
}

function ref_13978() {
  ref_14021();
  updatesuperuistate();
}

function givesuper(var_0, var_1, var_2) {
  if(getdvarint("scr_supers_killswitch") != 0) {
    return;
  }

  clearsuper(var_1);

  if(var_0 == "") {
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
  var_4.usepercent = 0;
  var_4.ref_12187 = undefined;
  ref_131c7(0);
  ref_13985(var_0);
  self setclientomnvar("ui_super_ref", var_0);
  var_5 = self.pers["superBasePoints"];

  if(!isDefined(var_5)) {
    var_5 = 0;
  }

  self.pers["superBasePoints"] = undefined;
  setsuperbasepoints(var_5);
  var_6 = self.pers["superExtraPoints"];

  if(!isDefined(var_6)) {
    var_6 = 0;
  }

  self.pers["superExtraPoints"] = undefined;
  setsuperextrapoints(var_6);

  if(!isDefined(self.pers["superExpended"])) {
    ref_131c6(0);
  }

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

  if(scripts\mp\utility\game::getgametype() != "br" || level.allowsupers) {
    thread watchforrespawn();
    thread storesupercooldownforroundchange();
    thread handleteamchange();
    return;
  }
}

function handlesuperearnovertime() {
  level endon("game_ended");

  if(scripts\mp\utility\game::getgametype() != "br") {
    scripts\mp\flags::gameflagwait("prematch_done");
  }

  var_0 = gettime();
  waitframe();

  for(;;) {
    var_1 = level.players.size;
    var_2 = (gettime() - var_0) / 50;

    if(var_2 < 11) {
      wait(11 - var_2) * 0.05;
      var_2 = 11;
    }

    var_0 = gettime();
    var_3 = 0;

    while(var_3 < var_1) {
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

        if(isDefined(getcurrentsuper(var_6)) && !getcurrentsuper(var_6).isinuse) {
          givesuperpoints(var_6, 0, "time", 0, var_2);
        }
      }

      waitframe();
      var_3 += 15;
    }

    waitframe();
  }
}

function clearsuper(var_0) {
  var_1 = getcurrentsuper();

  if(isDefined(var_1) && isDefined(var_1.staticdata)) {
    ref_13986(var_1.staticdata.ref);
  }

  if(istrue(var_0) && isDefined(var_1)) {
    storesuperpoints();
  }

  self clearoffhandspecial();

  if(isDefined(var_1)) {
    scripts\cp_mp\utility\inventory_utility::_takeweapon(var_1.staticdata.weapon);
  }

  if(level.codcasterenabled && !isagent(self)) {
    self setspecialactive(0);
  }

  self notify("remove_super");
  self.super = undefined;
  thread _calloutmarkerping_handleluinotify_added::ref_1313d("ui_super_state", 0);
  self setclientomnvar("ui_super_ref", "none");
}

function ref_13985(var_0) {
  if(!isDefined(var_0)) {
    return;
  }

  if(var_0 == "none" || var_0 == "") {
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

function ref_13986(var_0) {
  if(!isDefined(var_0)) {
    return;
  }

  if(var_0 == "none" || var_0 == "") {
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

function setsuperbasepoints(var_0, var_1) {
  var_2 = getcurrentsuper();
  var_2.basepoints = clamp(var_0, 0, getsuperpointsneeded());

  if(istrue(var_1)) {
    return;
  }

  superpointschanged();
}

function setsuperextrapoints(var_0, var_1) {
  var_2 = getcurrentsuper();
  var_2.extrapoints = clamp(var_0, 0, getsuperpointsneeded());

  if(istrue(var_1)) {
    return;
  }

  superpointschanged();
}

function superpointschanged() {
  var_0 = getcurrentsuper();

  if(getcurrentsuperpoints() >= getsuperpointsneeded()) {
    superearned();
  } else {
    self setweaponammoclip(var_0.staticdata.weapon, 0);
  }

  ref_14021();
  updatesuperuistate();
}

function givesuperpoints(var_0, var_1, var_2, var_3) {
  if(istrue(game["isLaunchChunk"]) || !level.allowsupers) {
    return;
  }

  if(isDefined(var_1)) {
    var_0 = getsuperpointsforevent(var_1);
  }

  if(isDefined(var_3)) {
    var_0 *= var_3;
  }

  if(scripts\mp\utility\perk::_hasperk("specialty_faster_field_upgrade")) {
    var_0 *= getdvarfloat("perk_faster_field_upgrade_rate");
  }

  if(getdvarint("scr_disableSuperPoints", 0) && !istrue(var_2)) {
    return;
  }

  if(isDefined(var_1) && var_1 == "time") {
    var_4 = var_0 * level.superfastchargerate;
  } else {
    var_4 = var_1 * level.superpointsmod;
  }

  if(var_4 <= 0) {
    return;
  }

  var_5 = getcurrentsuper();

  if(!isDefined(var_5) || issuperready() || var_5.isinuse || issuperexpended()) {
    updatesppm(var_1, 0, var_2);
    return;
  }

  var_6 = min(var_4 + var_5.basepoints, getsuperpointsneeded());
  setsuperbasepoints(var_6);
  scripts\mp\analyticslog::logevent_reportsuperscore(var_4, gettime());
  updatesppm(var_1, 1, var_2);
}

function ref_14021() {
  var_0 = getcurrentsuper();

  if(!isDefined(var_0)) {
    return;
  }

  if(scripts\mp\utility\player::isinkillcam() || !isalive(self)) {
    var_0.ref_11fcd = undefined;
    return;
  }

  var_1 = 0;

  if(var_0.isinuse) {
    var_1 = getsuperuseuiprogress();
  } else if(!issuperexpended()) {
    var_2 = getsuperpointsneeded();
    var_1 = clamp(getcurrentsuperbasepoints() / var_2, 0, 1);
  }

  if(!isDefined(var_0.ref_11fcd) || var_1 != var_0.ref_11fcd) {
    self setclientomnvar("ui_super_progress", var_1);
  }

  self setplayersupermeterprogress(var_1);
  var_0.ref_11fcd = var_1;
}

function updatesuperuistate() {
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

  if(issuperexpended()) {
    var_2 = 4;
  } else if(issuperready()) {
    var_2 = 2;
  } else if(issuperinuse()) {
    var_2 = 3;
  }

  if(!isDefined(var_1) || var_2 != var_1) {
    thread _calloutmarkerping_handleluinotify_added::ref_1313d("ui_super_state", var_2);
  }

  var_0.state = var_2;
}

function watchforrespawn() {
  var_0 = getcurrentsuper();
  self endon("disconnect");
  self endon("remove_super");

  for(;;) {
    self waittill("spawned_player");
    givesuperweapon(var_0);
  }
}

function storesupercooldownforroundchange() {
  self endon("disconnect");
  self endon("remove_super");
  scripts\mp\flags::levelflagwait("game_over");

  if(istrue(game["practiceRound"])) {
    return;
  }

  storesuperpoints();
}

function handlespectating() {
  self endon("disconnect");
  self endon("remove_super");
  self waittill("joined_spectators");
  thread clearsuper(1);
}

function handleteamchange() {
  self endon("disconnect");
  self endon("remove_super");
  var_0 = self.team;
  self waittill("joined_team");

  if(self.team != var_0) {
    self.currentfirstupgrade = undefined;
    thread clearsuper(0);
    return;
  }
}

function handlepointdecay() {
  self endon("disconnect");
  self endon("remove_super");
  level endon("game_ended");
  var_0 = getcurrentsuper();
  var_1 = getdvarfloat("scr_super_decay_rate", 6) * level.framedurationseconds;

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

function superearned() {
  var_0 = getcurrentsuper();
  self setweaponammoclip(var_0.staticdata.weapon, 1);
  var_1 = !var_0.wasrefunded;
  self notify("super_ready", var_1);

  if(var_1) {
    self.pers["supersEarned"]++;
    self notify("super_earned");
    recordsuperearnedanalytics(var_0);
  }

  var_0.madeavailabletime = gettime();
  var_0.numkills = 0;
  scripts\mp\analyticslog::logevent_superearned(var_0.madeavailabletime);
  setsuperextrapoints(0, 1);
  setsuperbasepoints(getsuperpointsneeded(), 1);

  if(isDefined(self.matchdatalifeindex)) {
    scripts\mp\analyticslog::logevent_fieldupgradeearned(self, var_0.staticdata.id);
    return;
  }
}

function watchforsuperusebegin() {
  self endon("disconnect");
  self endon("remove_super");

  for(;;) {
    self waittill("special_weapon_fired", var_0);
    var_1 = trysuperusebegin(var_0);

    if(!istrue(var_1)) {
      continue;
    }

    self waittill("super_use_finished");
  }
}

function trysuperusebegin(var_0) {
  if(!scripts\mp\utility\player::isreallyalive(self)) {
    return 0;
  }

  if(var_0.basename != getcurrentsuper().staticdata.weapon) {
    return 0;
  }

  if(!scripts\common\utility::is_supers_allowed()) {
    return 0;
  }

  return beginsuperuse();
}

function beginsuperuse() {
  self endon("death_or_disconnect");
  var_0 = getcurrentsuper();
  self notify("super_started");
  scripts\mp\gamelogic::sethasdonecombat(self, 1);

  if(var_0.staticdata.weapon == "support_box_mp") {
    self playlocalsound("iw8_support_box_deploy");
  }

  if(isDefined(var_0) && !var_0.isinuse) {
    var_1 = !istrue(self.inlaststand) || var_0.staticdata.canuseinlaststand;
    var_2 = 1;

    if(isDefined(var_0.staticdata.useweapon)) {
      if(scripts\mp\arbitrary_up::isinarbitraryup() && superdisabledinarbitraryup(var_0.staticdata.ref)) {
        superdisabledinarbitraryupmessage();
        var_2 = 0;
      } else if(!var_1) {
        var_2 = 0;
      } else {
        var_2 = trygiveuseweapon(var_0.staticdata.useweapon, var_0.staticdata.useweaponclipammo, var_0.staticdata.useweaponstockammo);
      }
    }

    if(var_2 && var_1 && (!isDefined(var_0.staticdata.beginusefunc) || istrue(self[[var_0.staticdata.beginusefunc]]()))) {
      var_3 = [];
      GscBinSkip0(0x2e, 0, "super_use_finished_lb");
    }

    if(isDefined(var_1.staticdata.useweapon) && var_3) {
      thread switchandtakesuperuseweapon();
    }

    if(istrue(self.inlaststand)) {
      thread ref_144fa(var_1.staticdata.weapon);
    } else {
      self setweaponammoclip(var_1.staticdata.weapon, 1);
    }
  }

  return false;
}

function activatesuper(var_0, var_1) {
  var_2 = getcurrentsuper();

  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  if(var_0 && isDefined(var_2.staticdata.activatepenaltyalt)) {
    reducesuperusepercent(var_2.staticdata.activatepenaltyalt, var_1);
  } else if(isDefined(var_2.staticdata.activatepenalty)) {
    reducesuperusepercent(var_2.staticdata.activatepenalty, var_1);
  }

  return true;
}

function updateusetimedecay() {
  self endon("death_or_disconnect");
  self endon("game_ended");
  self endon("super_use_finished");
  var_0 = getcurrentsuper();

  if(!isDefined(var_0.staticdata.usetime)) {
    waitframe();

    if(issuperinuse()) {
      superusefinished();
    }

    return;
  }

  jumpiffalse(var_0.staticdata.usetime < 0) LOC_0000004e;
  return;
}

function reducesuperusepercent(var_0, var_1, var_2) {
  var_3 = getcurrentsuper();
  var_3.usepercent = max(var_3.usepercent - var_0, 0);

  if(istrue(var_1)) {
    var_3.allowrefund = 0;
  }

  if(!isDefined(var_2) || var_2 == 0) {
    superusedurationupdated();
    return;
  }
}

function resetsuperusepercent() {
  var_0 = getcurrentsuper();
  var_0.usepercent = 1;
  superusedurationupdated();
}

function superusedurationupdated() {
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

  if(var_0.usepercent <= 0) {
    superusefinished();
    return;
  }
}

function superusefinished(var_0, var_1, var_2, var_3) {
  var_4 = getcurrentsuper();
  self notify("super_use_finished_lb");
  var_5 = 0;

  if(!isDefined(var_3) || var_3 == 0) {
    var_5 = shouldrefundsuper();
  }

  ref_131c7(0);
  var_4.canstow = 0;
  var_6 = undefined;

  if(isDefined(var_4.staticdata.endusefunc)) {
    if(!isDefined(var_1)) {
      var_1 = 0;
    }

    var_6 = self[[var_4.staticdata.endusefunc]](var_1);
  }

  if(var_5 || istrue(var_0) || istrue(var_6)) {
    ref_131c6(0);
    var_4.wasrefunded = 1;
    setsuperbasepoints(getsuperpointsneeded());
  } else if(istrue(var_2)) {
    ref_131c6(0);
    var_7 = getsuperpointsneeded() * var_4.usepercent;
    var_4.wasrefunded = 1;
    setsuperbasepoints(var_7);
  } else {
    ref_131c6(1);
    var_4.lastfinishtime = gettime();
    var_4.wasrefunded = 0;
  }

  thread switchandtakesuperuseweapon();
  var_8 = var_4.usestarttime - var_4.madeavailabletime;
  scripts\mp\analyticslog::logevent_superended(var_4.staticdata.ref, var_8, 0, var_4.numkills);

  if(level.codcasterenabled) {
    self setspecialactive(0);
  }

  scripts\mp\utility\print::printgameaction("super use ended - " + var_4.staticdata.ref, self);

  if(scripts\mp\utility\game::getgametype() == "br") {
    if(!level.allowsupers) {
      if(!istrue(var_0)) {
        self setclientomnvar("ui_perk_package_state", 0);
        self setclientomnvar("ui_super_progress", 0);
      }
    } else if(var_4.staticdata.ending_mortars) {
      clearsuper();
      self setclientomnvar("ui_perk_package_state", 0);
      self setclientomnvar("ui_super_progress", 0);
      thread _calloutmarkerping_handleluinotify_added::ref_1313d("ui_super_state", 0);
    }
  }

  self notify("super_use_finished");
  scripts\cp\vehicles\vehicle_compass_cp::ref_12097(var_4, var_5);
}

function refundsuper() {
  var_0 = getcurrentsuper();

  if(isDefined(var_0)) {
    if(var_0.isinuse) {
      superusefinished(1);
      return;
    }

    givesuperpoints(getsuperpointsneeded());
    return;
  }
}

function handledeath() {
  self endon("disconnect");

  if(!issuperinuse()) {
    return;
  }

  var_0 = getcurrentsuper();
  var_1 = var_0.staticdata.ref_12acd;
  superusefinished(var_1, 1);
}

function monitoruseweaponfiring(var_0) {
  self endon("death_or_disconnect");
  self endon("super_use_finished");
  self endon("remove_super");

  for(;;) {
    self waittill("weapon_fired", var_1);

    if(isnullweapon(var_1, var_0, 1)) {
      activatesuper(var_1.isalternate, 1);
    }
  }
}

function trygiveuseweapon(var_0, var_1, var_2) {
  self endon("death_or_disconnect");
  scripts\cp_mp\utility\inventory_utility::_giveweapon(var_0);
  self setweaponammoclip(var_0, var_1);
  self setweaponammostock(var_0, var_2);
  var_3 = scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(var_0, isbot(self));

  if(var_3) {
    thread manageuseweapon(var_0);
    thread monitoruseweaponfiring(var_0);
    return true;
  }

  scripts\cp_mp\utility\inventory_utility::abortmonitoredweaponswitch(var_0);
  return false;
}

function manageuseweapon(var_0) {
  self endon("death_or_disconnect");
  self endon("super_use_finished");
  var_1 = getcurrentsuper();
  var_1.useweaponswapped = undefined;
  var_2 = 0;

  for(;;) {
    var_3 = self getcurrentweapon();

    if(!var_1.canstow && !isnullweapon(var_0, var_3, 1)) {
      if(var_3.basename == "iw7_uplinkball_mp" || var_3.basename == "iw7_tdefball_mp") {
        var_2 = 1;
      }

      break;
    }

    waitframe();
  }

  if(issuperinuse()) {
    var_1.useweaponswapped = 1;
    superusefinished(undefined, undefined, var_2);
    return;
  }
}

function switchandtakesuperuseweapon() {
  self endon("death");
  var_0 = getcurrentsuper();
  var_1 = var_0.staticdata.useweapon;

  if(!isDefined(var_1)) {
    return;
  }

  if(scripts\cp_mp\utility\inventory_utility::isswitchingtoweaponwithmonitoring(var_1)) {
    scripts\cp_mp\utility\inventory_utility::abortmonitoredweaponswitch(var_1);
    return;
  }

  self notify("super_switched");
  scripts\cp_mp\utility\inventory_utility::getridofweapon(var_1);
}

function storesuperpoints() {
  var_0 = getcurrentsuper();

  if(!isDefined(var_0)) {
    return;
  }

  if(issupercharging() || issuperready()) {
    self.pers["superBasePoints"] = var_0.basepoints;
    self.pers["superExtraPoints"] = var_0.extrapoints;
    return;
  }

  if(issuperinuse() && shouldrefundsuper()) {
    var_1 = getsuperpointsneeded();
    self.pers["superPoints"] = var_0.usepercent * var_1;
    self.pers["superExtraPoints"] = 0;
    return;
  }

  self.pers["superBasePoints"] = 0;
  self.pers["superExtraPoints"] = 0;
}

function getsuperuseuiprogress() {
  var_0 = getcurrentsuper();
  return var_0.usepercent;
}

function getcurrentsuperbasepoints() {
  return getcurrentsuper().basepoints;
}

function getcurrentsuperextrapoints() {
  return getcurrentsuper().basepoints;
}

function getcurrentsuperpoints() {
  var_0 = getcurrentsuper();
  return var_0.basepoints + var_0.extrapoints;
}

function getsuperpointsneeded() {
  var_0 = getcurrentsuper();
  var_1 = var_0.staticdata.pointsneeded;

  if(isDefined(var_0.ref_12187)) {
    var_1 = var_0.ref_12187;
  }

  return var_1;
}

function issuperready() {
  var_0 = getcurrentsuper();

  if(!isDefined(var_0) || var_0.isinuse) {
    return false;
  }

  return getcurrentsuperpoints() >= getsuperpointsneeded();
}

function issuperinuse() {
  return isDefined(getcurrentsuper()) && getcurrentsuper().isinuse;
}

function ref_131c7(var_0) {
  var_1 = getcurrentsuper();
  var_1.isinuse = var_0;
  updatesuperuistate();
}

function issupercharging() {
  return !issuperready() && !issuperinuse();
}

function issuperexpended() {
  if(getdvarint("scr_super_expendable", 1) == 0) {
    return false;
  }

  return istrue(self.pers["superExpended"]);
}

function ref_131c6(var_0) {
  self.pers["superExpended"] = var_0;
  updatesuperuistate();
}

function getcurrentsuper() {
  return self.super;
}

function getcurrentsuperref() {
  var_0 = getcurrentsuper();

  if(!isDefined(var_0)) {
    return undefined;
  }

  return var_0.staticdata.ref;
}

function shouldrefundsuper() {
  var_0 = getcurrentsuper();
  var_1 = var_0.staticdata.graceperiod;
  var_2 = undefined;

  if(isDefined(var_0) && isDefined(var_0.usestarttime)) {
    var_2 = gettime() - var_0.usestarttime;
  }

  if(!isDefined(var_2) || var_2 >= var_1) {
    return 0;
  }

  if(var_0.numkills > 0) {
    return 0;
  }

  return var_0.allowrefund;
}

function getsuperrefforsuperuseweapon(var_0) {
  if(!isstring(var_0)) {
    var_0 = var_0.basename;
  }

  if(!isDefined(level.superglobals) || !isDefined(level.superglobals.superweapons) || !isDefined(level.superglobals.superweapons[var_0])) {
    return undefined;
  }

  return level.superglobals.superweapons[var_0].ref;
}

function getsuperrefforsuperoffhand(var_0) {
  if(!isstring(var_0)) {
    var_0 = var_0.basename;
  }

  if(!isDefined(level.superglobals.supersbyoffhand[var_0])) {
    return undefined;
  }

  return level.superglobals.supersbyoffhand[var_0].ref;
}

function roundkillexecute(var_0) {
  if(!isstring(var_0)) {
    var_0 = var_0.basename;
  }

  if(!isDefined(level.superglobals.ref_13987[var_0])) {
    return undefined;
  }

  return level.superglobals.ref_13987[var_0].ref;
}

function getsuperrefforsuperweapon(var_0) {
  if(!isDefined(level.superglobals)) {
    return undefined;
  }

  if(!isstring(var_0)) {
    var_0 = var_0.basename;
  }

  var_1 = getsuperrefforsuperuseweapon(var_0);

  if(isDefined(var_1)) {
    return var_1;
  }

  var_2 = getsuperrefforsuperoffhand(var_0);

  if(isDefined(var_2)) {
    return var_2;
  }

  var_2 = roundkillexecute(var_0);

  if(isDefined(var_2)) {
    return var_2;
  }

  return undefined;
}

function shouldtracksuperweaponstats(var_0) {
  var_1 = getsuperrefforsuperweapon(var_0);

  if(isDefined(var_1)) {
    var_2 = level.superglobals.staticsuperdata[var_1];
    return var_2.useweapontrackstats;
  }

  return undefined;
}

function getsuperid(var_0) {
  if(!isDefined(var_0) || !isDefined(level.superglobals) || !isDefined(level.superglobals.staticsuperdata) || !isDefined(level.superglobals.staticsuperdata[var_0]) || var_0 == "none") {
    return 0;
  }

  return level.superglobals.staticsuperdata[var_0].id;
}

function getmovespeedforsuperweapon(var_0) {
  var_1 = getsuperrefforsuperweapon(var_0);

  if(!isDefined(var_1)) {
    return undefined;
  }

  return level.superglobals.staticsuperdata[var_1].movespeed;
}

function getrootsuperref(var_0) {
  return getsubstr(var_0, 6);
}

function allowsuperweaponstow() {
  var_0 = getcurrentsuper();

  if(!isDefined(var_0) || !var_0.isinuse) {
    return;
  }

  var_0.canstow = 1;
}

function unstowsuperweapon() {
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

function getsuperpointsforevent(var_0) {
  var_1 = level.superglobals.pointeventdata[var_0];

  if(!isDefined(var_1)) {
    return 0;
  }

  return var_1;
}

function watchforgameend() {
  level waittill("game_ended");

  if(scripts\mp\utility\game::waslastround()) {
    foreach(var_1 in level.players) {
      writesppmstats(var_1);
    }

    return;
  }
}

function getsppmdata() {
  if(getdvarint("scr_sppm_data", 0) == 0) {
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

function updatesppm(var_0, var_1, var_2) {
  if(getdvarint("scr_sppm_data", 0) == 0) {
    return;
  }

  if(isai(self)) {
    return;
  }

  var_3 = getsppmdata();
  var_3.totalpoints += var_0;

  if(istrue(var_1)) {
    var_3.totalappliedpoints += var_0;
  }

  if(!isDefined(var_2)) {
    var_2 = "undefined";
  }

  if(!isDefined(var_3.eventtotals[var_2])) {
    var_3.eventtotals[var_2] = var_0;
    return;
  }

  var_3.eventtotals[var_2] += var_0;
}

function writesppmstats() {
  if(getdvarint("scr_sppm_data", 0) == 0) {
    return;
  }

  if(isai(self)) {
    return;
  }

  var_0 = getsppmdata();
  var_1 = scripts\mp\persistence::statgetchildbuffered("round", "timePlayed", 1) / 60;
  var_2 = 0;
  var_3 = 0;

  if(var_1 > 0) {
    var_2 = var_0.totalpoints / var_1;
    var_3 = var_0.totalappliedpoints / var_1;
  }

  var_4 = "";
  var_5 = -1;

  foreach(var_7 in var_0.eventtotals) {
    if(var_7 > var_5) {
      var_5 = var_7;
      var_4 = var_8;
    }
  }

  getentitylessscriptablearray("mpscript_sppm", ["sppm", var_2, "sppm_applied", var_3, "gamemode", scripts\mp\utility\game::getgametype(), "kills", self.kills, "time_played", var_1, "best_event", var_4, "script_version", getscriptdataversion()]);
}

function modifysuperequipmentdamage(var_0, var_1, var_2, var_3, var_4) {
  var_5 = var_3;

  if(isDefined(self.owner) && isDefined(var_0) && var_0 == self.owner) {
    var_5 = int(ceil(var_3 * 0.5));
  }

  return var_5;
}

function updateactivesupers(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = isDefined(var_0) && isPlayer(var_0);
  var_9 = var_5.basename == "throwingknife_mp" || var_5.basename == "throwingknife_fire_mp" || var_5.basename == "throwingknife_electric_mp" || var_5.basename == "throwingknife_drill_mp";
  var_10 = var_9 && isDefined(var_0) && isDefined(var_0.classname) && var_0.classname == "grenade";
  var_11 = isDefined(var_1) && isPlayer(var_1) && var_1 != var_2;

  if(var_11) {
    var_12 = getcurrentsuper(var_1);

    if(var_8 || var_10) {
      if(isDefined(var_12) && var_12.staticdata.ref == "super_deadsilence" && issuperinuse(var_1)) {
        var_1 thread scripts\mp\supers\super_deadsilence::superdeadsilence_onkill();
      }
    }

    if(var_8 && var_0 scripts\mp\utility\perk::_hasperk("specialty_bulletdamage")) {
      var_1 thread scripts\mp\supers\super_stoppingpower::ref_138ec(var_5);
      return;
    }

    return;
  }
}

function watchsuperdelay() {
  level endon("super_delay_end");
  level endon("round_end");
  level endon("game_ended");

  if(scripts\mp\utility\game::isanymlgmatch()) {
    level.superdelay = 0;
  } else {
    level.superdelay = getdvarfloat("scr_superDelay", 0);
  }

  if(scripts\mp\utility\game::getgametype() != "br") {
    scripts\mp\flags::gameflagwait("prematch_done");
  }

  if(level.superdelay == 0) {
    level.superdelaystarttime = gettime();
    level.superdelayendtime = level.superdelaystarttime;
    level notify("super_delay_end");
  }

  level.superdelaystarttime = gettime();
  level.superdelayendtime = level.superdelaystarttime + level.superdelay * 1000;
  level notify("super_delay_start");

  while(gettime() < level.superdelayendtime) {
    waitframe();
  }

  level notify("super_delay_end");
}

function watchplayersuperdelayweapon() {
  level endon("round_end");
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("clearedAllows");
  self notify("watchPlayerSuperDelayWeapon");

  if(superdelaypassed()) {
    return;
  }

  scripts\common\utility::allow_supers(0, "super_delay");
  scripts\engine\utility::waittill_any_ents(level, "super_delay_end", self, "watchPlayerSuperDelayWeapon");
  scripts\common\utility::allow_supers(1, "super_delay");
}

function superdelaypassed() {
  return isDefined(level.superdelayendtime) && gettime() >= level.superdelayendtime;
}

function cancelsuperdelay() {
  level.superdelay = 0;
  level.superdelaystarttime = gettime();
  level.superdelayendtime = level.superdelaystarttime;
  level notify("super_delay_end");
}

function setsuperweapondisabled(var_0) {
  self.issuperdisabled = var_0;

  if(!var_0) {
    endsuperdisableweapon();
    return;
  }

  self notify("super_disable_start");
  thread watchsuperdisableplayer();
}

function issuperweapondisabled() {
  return istrue(self.issuperdisabled);
}

function watchsuperdisableplayer() {
  self endon("remove_super");
  self endon("disconnect");
  level endon("round_end");
  level endon("game_ended");
  self notify("super_disable_end");
  self endon("super_disable_end");
  var_0 = getcurrentsuper();

  if(isDefined(var_0)) {
    var_1 = var_0.staticdata.weapon;
    scripts\cp_mp\utility\inventory_utility::_takeweapon(var_1);
    givesuperdisableweapon();
  }

  thread cleanupsuperdisableweapon();
  jumpiftrue(istrue(scripts\mp\flags::gameflag("prematch_done"))) LOC_00000070;
  level waittill("super_delay_start");

  for(;;) {
    self waittill("special_weapon_fired", var_2);

    if(var_2.basename != "super_delay_mp") {
      continue;
    }

    self setweaponammoclip(var_2, 99);

    if(issuperready()) {
      var_3 = (level.superdelayendtime - gettime()) / 1000;
      var_3 = int(max(0, ceil(var_3)));

      if(var_3 > 0) {
        scripts\mp\hud_message::showerrormessage("MP/SUPERS_UNAVAILABLE_FOR_N", var_3);
      } else {
        scripts\mp\hud_message::showerrormessage("MP/SUPERS_UNAVAILABLE");
      }
    }
  }
}

function cleanupsuperdisableweapon() {
  self endon("disconnect");
  level endon("round_end");
  level endon("game_ended");
  level endon("super_disable_end");
  self notify("watchSuperDelayWeaponCleanup");
  self endon("watchSuperDelayWeaponCleanup");

  for(;;) {
    self waittill("remove_super");
    scripts\cp_mp\utility\inventory_utility::_takeweapon("super_delay_mp");
  }
}

function endsuperdisableweapon() {
  var_0 = getcurrentsuper();

  if(isDefined(var_0)) {
    var_1 = var_0.staticdata.weapon;
    var_2 = scripts\engine\utility::ter_op(issuperready(), 1, 0);
    scripts\cp_mp\utility\inventory_utility::_giveweapon(var_1);
    self setweaponammoclip(var_1, var_2);
    self assignweaponoffhandspecial(var_1);
    scripts\cp_mp\utility\inventory_utility::_takeweapon("super_delay_mp");
  }

  self notify("super_disable_end");
}

function givesuperdisableweapon() {
  scripts\cp_mp\utility\inventory_utility::_giveweapon("super_delay_mp");
  self setweaponammoclip("super_delay_mp", 99);
  self assignweaponoffhandspecial("super_delay_mp");
}

function givesuperweapon(var_0) {
  if(superdelaypassed()) {
    if(!self hasweapon(var_0.staticdata.weapon)) {
      var_1 = scripts\engine\utility::ter_op(issuperready(), 1, 0);
      scripts\cp_mp\utility\inventory_utility::_giveweapon(var_0.staticdata.weapon);
      self setweaponammoclip(var_0.staticdata.weapon, var_1);
      self assignweaponoffhandspecial(var_0.staticdata.weapon);
      return;
    }

    return;
  }

  givesuperdisableweapon();
}

function watchobjuse(var_0, var_1) {
  self endon("death_or_disconnect");
  self endon("obj_drain_end");
  self endon("ball_dropped");

  if(scripts\mp\utility\game::getgametype() == "sd" || scripts\mp\utility\game::getgametype() == "sr" || scripts\mp\utility\game::getgametype() == "dd") {
    if(istrue(var_1)) {
      self waittill("super_obj_drain");
    }
  } else if(!isDefined(self.carryobject)) {
    self waittill("obj_picked_up");
  } else {
    wait 0.05;
  }

  while(issuperinuse()) {
    reducesuperusepercent(var_0);
    wait 0.05;
  }
}

function combatrecordsuperuse(var_0) {
  if(!scripts\mp\utility\stats::canrecordcombatrecordstats()) {
    return;
  }

  if(var_0 == "super_kiosk_drop") {
    return;
  }

  var_1 = self getplayerdata("mp", "playerStats", "superStats", var_0, "uses");
  self setplayerdata("mp", "playerStats", "superStats", var_0, "uses", var_1 + 1);
}

function combatrecordsuperkill(var_0) {
  if(!scripts\mp\utility\stats::canrecordcombatrecordstats()) {
    return;
  }

  var_1 = self getplayerdata("mp", "playerStats", "superStats", var_0, "kills");
  self setplayerdata("mp", "playerStats", "superStats", var_0, "kills", var_1 + 1);
}

function hide_plunderboxes(var_0, var_1) {
  if(!scripts\mp\utility\stats::canrecordcombatrecordstats()) {
    return;
  }

  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  var_2 = relic_fastbleedout_returnfunc(var_0);
  self setplayerdata("mp", "playerStats", "superStats", var_0, "misc1", var_2 + var_1);
}

function relic_fastbleedout_returnfunc(var_0) {
  return self getplayerdata("mp", "playerStats", "superStats", var_0, "misc1");
}

function superdisabledinarbitraryup(var_0) {
  if(var_0 == "super_microturret" || var_0 == "super_supertrophy") {
    return true;
  }

  return false;
}

function superdisabledinarbitraryupmessage() {
  scripts\mp\hud_message::showerrormessage("MP/SUPERS_UNAVAILABLE_ARB_UP");
}

function bradleybeginuse() {
  return scripts\cp_mp\vehicles\light_tank::light_tank_tryuse();
}

function choppergunnerbeginuse() {
  return scripts\mp\killstreaks\killstreaks::trytriggerkillstreakfromsuper("chopper_gunner");
}

function cruisepredatorbeginuse() {
  return scripts\mp\killstreaks\killstreaks::trytriggerkillstreakfromsuper("cruise_predator");
}

function scramblebeginuse() {
  var_0 = spawn("script_model", self.origin + (0, 0, 400));
  self.scrambleent = var_0;
  self.scrambleent setModel("super_scramble_mp");
  self.scrambleent linkTo(self);
  self.scrambleent.owner = self;
  self.scrambleent.team = self.team;
  self.scrambleent setotherent(self);
  self.scrambleent setscriptablepartstate("scramble_sfx", "on", 0);
  thread scripts\cp_mp\killstreaks\helper_drone::spawn_ai_single(self);
  return true;
}

function scrambleusefinished(var_0) {
  self.scrambleent unlink();
  self.scrambleent delete();
  scripts\cp_mp\killstreaks\helper_drone::helperdrone_endscramblereffect();
}

function trophyonset() {
  return scripts\mp\equipment\trophy_system::trophy_onsuperset();
}

function jugg_removefromactivejugglist() {
  return _debug_rooftop_heli_start::jugg_getminigunweapon();
}

function jugg_setherodropscriptable() {
  return _debug_rooftop_heli_start::jugg_go_to_node_callback();
}

function tacinsertonset() {
  scripts\mp\equipment\tac_insert::tacinsert_set();
}

function tacinsertonunset() {
  scripts\mp\equipment\tac_insert::tacinsert_unset();
}

function remotedetonateonset() {}

function remotedetonatebeginuse() {}

function precisionairstrikebeginuse() {
  return scripts\mp\killstreaks\killstreaks::trytriggerkillstreakfromsuper("precision_airstrike");
}

function tomastrikebeginuse() {
  return scripts\mp\killstreaks\killstreaks::trytriggerkillstreakfromsuper("toma_strike");
}

function pacsentrybeginuse() {
  return scripts\mp\killstreaks\killstreaks::trytriggerkillstreakfromsuper("pac_sentry");
}

function brcircleextract() {}

function uavbeginuse() {
  return scripts\mp\killstreaks\killstreaks::trytriggerkillstreakfromsuper("uav");
}

function taccoverbeginuse() {
  return scripts\mp\equipment\tactical_cover::tac_cover_on_fired_super();
}

function taccoverunset() {
  return scripts\mp\equipment\tactical_cover::tac_cover_on_take_super();
}

function recondronebeginuse() {
  return scripts\cp_mp\killstreaks\helper_drone::recondrone_beginsuper();
}

function recondroneenduse(var_0) {
  return scripts\cp_mp\killstreaks\helper_drone::recondrone_endsuper(var_0);
}

function recondroneunset() {
  scripts\cp_mp\killstreaks\helper_drone::recondrone_unsetsuper();
}

function empdronebeginuse() {
  return scripts\cp_mp\killstreaks\emp_drone_targeted::empdrone_beginsuper();
}

function deadsilencebeginuse() {
  return scripts\mp\supers\super_deadsilence::superdeadsilence_beginsuper();
}

function deadsilenceenduse(var_0) {
  return scripts\mp\supers\super_deadsilence::superdeadsilence_endsuper(var_0);
}

function supportboxunset() {
  scripts\mp\equipment\support_box::supportbox_unset();
}

function laststandhealonset() {
  return scripts\mp\supers\laststand_heal::laststandheal_onset();
}

function laststandhealunset() {
  return scripts\mp\supers\laststand_heal::laststandheal_unset();
}

function laststandhealbeginuse() {
  return scripts\mp\supers\laststand_heal::laststandheal_beginuse();
}

function stoppingpowerbeginuse() {
  return scripts\mp\supers\super_stoppingpower::stoppingpower_beginuse();
}

function ref_11ed6() {
  return _luidecision::ref_11ed6();
}

function superweapondropbeginuse() {
  return scripts\mp\equipment\weapon_drop::weapondrop_beginsuper();
}

function ref_13988() {
  var_0 = scripts\mp\perks\perkpackage::perkpackage_getfirstfieldupgrade();
  ref_13985(var_0);
  self.super.firstupgrade = var_0;
  var_1 = scripts\mp\perks\perkpackage::perkpackage_getsecondfieldupgrade();
  ref_13985(var_1);
  self.super.secondupgrade = var_1;
  var_2 = level.superglobals.staticsuperdata[var_0];
  var_3 = 0;

  if(isDefined(var_2)) {
    var_3 = var_2.pointsneeded;
  }

  var_2 = level.superglobals.staticsuperdata[var_1];
  var_4 = 0;

  if(isDefined(var_2)) {
    var_4 = var_2.pointsneeded;
  }

  var_5 = max(var_3, var_4);
  self.super.ref_12187 = var_5;
}

function ref_13989() {
  var_0 = self.super.firstupgrade;
  ref_13986(var_0);
  var_1 = self.super.secondupgrade;
  ref_13986(var_1);
}

function superselectbeginuse() {
  return scripts\mp\perks\perkpackage::perkpackage_openselect();
}

function testsuperbeginuse() {
  thread testsuperrefundwatcher();
  return true;
}

function ref_1397f() {
  return true;
}

function ref_1398b() {
  return true;
}

function ref_1398d() {
  return true;
}

function ref_13984() {
  return true;
}

function ref_13981() {
  _donewithcorpse::vehicle_cp_create();
}

function ref_13980() {
  return true;
}

function vehicle_createspawnselectionlittlebirdmarker(var_0) {
  _donewithcorpse::vehicle_compass_playerspawnedcallback();
}

function superslingerbeginuse() {
  return scripts\mp\equipment\slinger::slinger_allow_use();
}

function ref_13983() {
  return true;
}

function serumgadgetbeginuse() {
  var_0 = getcurrentsuper();
  var_1 = var_0.staticdata.usetime;
  thread _findnewlocaleplacement::start_serum_gadget(var_1);
  return true;
}

function serumgadgetenduse(var_0) {
  _findnewlocaleplacement::stop_serum_gadget();
}

function testsuperrefundwatcher() {
  self endon("super_use_finished");

  for(;;) {
    if(self buttonPressed("BUTTON_X")) {
      superusefinished(0, 0, 1);
    } else if(self buttonPressed("BUTTON_Y")) {
      superusefinished(1);
    }

    waitframe();
  }
}

function showsuperremindersplash() {
  self endon("disconnect");

  if(!istrue(self.superreminderset)) {
    self notify("showSuperReminderSplash");
    self endon("showSuperReminderSplash");
    self.superreminderset = 1;
    self setclientomnvar("ui_super_reminder", 1);
    wait 0.5;
    thread clearsuperremindersplash();
    return;
  }

  thread clearsuperremindersplash();
  self endon("showSuperReminderSplash");
  waitframe();
  thread showsuperremindersplash();
}

function clearsuperremindersplash() {
  self notify("showSuperReminderSplash");
  self.superreminderset = undefined;
  self setclientomnvar("ui_super_reminder", 0);
}

function clearsuperreminderondeath(var_0) {
  if(!isPlayer(var_0)) {
    return;
  }

  thread clearsuperreminderondeathinternal(var_0);
}

function clearsuperreminderondeathinternal(var_0) {
  var_0 endon("disconnect");
  var_0 waittill("death");
  clearsuperremindersplash(var_0);
}

function initsuperdvars() {
  setdvarifuninitialized("scr_super_decay_rate", 6);
}

function watchsuperlottery() {
  level endon("game_ended");
  var_0 = getdvarint("scr_superLotteryDelay", 60);
  var_1 = getdvarint("scr_superLotteryIntervalMin", 45);
  var_2 = getdvarint("scr_superLotteryIntervalMax", 90);
  var_3 = var_2 - var_1;
  waitframe();

  if(!istrue(scripts\mp\flags::gameflag("prematch_done"))) {
    level waittill("prematch_over");
  }

  wait var_0;
  var_4 = undefined;
  var_5 = undefined;
  var_6 = [];
  var_7 = [];

  foreach(var_9 in level.teamnamelist) {
    var_6[var_9] = undefined;
    var_7 = [];
  }

  for(;;) {
    var_4 = var_5;
    var_5 = getdvarint("scr_superLotteryEnabled", 0) > 0;

    if(!isDefined(var_4) || var_4 != var_5) {
      if(var_5) {
        level notify("superLotteryEnabled");
      } else {
        level notify("superLotteryDisabled");
      }
    }

    foreach(var_9 in level.teamnamelist) {
      if(!isDefined(var_6[var_9])) {
        var_6 = gettime() + (var_1 + randomint(var_3)) * 1000;
        continue;
      }

      if(var_6[var_9] <= gettime()) {
        var_12 = scripts\mp\utility\teams::getteamdata(var_9, "players");

        if(var_12.size > 0) {
          var_12 = scripts\engine\utility::array_randomize(var_12);
          var_13 = [];
          var_14 = undefined;

          foreach(var_16 in var_12) {
            if(!scripts\engine\utility::array_contains(var_7[var_9], var_16)) {
              if(isDefined(getcurrentsuper(var_16))) {
                var_14 = var_16;
                break;
              }

              continue;
            }

            if(isDefined(getcurrentsuper(var_16))) {
              var_13 = var_16;
            }
          }

          if(!isDefined(var_14)) {
            if(isDefined(var_13[0])) {
              var_14 = var_13[0];
            } else {
              var_14 = var_12[0];
            }
          }

          if(var_5) {
            GscBinSkip4(0x35, var_14);
          }

          var_7 = var_14;
        }

        var_6[var_9] = undefined;
      }
    }

    waitframe();
  }
}

function ref_144fa(var_0) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self waittill("last_stand_finished");
  self setweaponammoclip(var_0, 1);
}

function awardsuperlottery(var_0) {
  var_0 endon("disconnect");
  var_0 endon("joined_team");
  level endon("superLotteryDisabled");
  var_0 notify("awardSuperLottery");
  var_0 endon("awardSuperLottery");

  for(;;) {
    var_1 = getcurrentsuper(var_0);

    if(!isDefined(var_1)) {
      return;
    }

    if(!issuperinuse(var_0)) {
      break;
    }

    waitframe();
  }

  givesuperpoints(var_0, getsuperpointsneeded(), undefined, 1);
}

function getscriptdataversion() {
  if(getdvarint("scr_playtest_qa", 0) != 0) {
    return 254;
  }

  if(getdvarint("scr_playtest", 0) != 0) {
    return 7;
  }

  return 254;
}

function recordsuperearnedanalytics(var_0) {
  if(getdvarint("scr_super_earn_data", 0) == 0) {
    return;
  }

  var_1 = scripts\mp\persistence::statgetchildbuffered("round", "timePlayed", 1) / 60;
  getentitylessscriptablearray("mpscript_super_earning", ["super_ref", var_0.staticdata.ref, "earn_time", var_1, "gamemode", scripts\mp\utility\game::getgametype(), "script_version", getscriptdataversion(), "earned_count", self.pers["supersEarned"]]);
}