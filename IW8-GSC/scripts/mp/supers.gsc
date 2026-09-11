/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\supers.gsc
***********************************************/

function init() {
  var0 = spawnStruct();
  level.superglobals = var0;
  var0.staticsuperdata = [];
  var0.superweapons = [];
  var0.superearnratemultiplier = 1;
  var0.supersbyid = [];
  var0.supersbyoffhand = [];
  var0.ref_13987 = [];
  var0.pointeventdata = [];
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
  var0 = scripts\mp\utility\game::getgametype() == "br";

  for(var1 = 1;; var1++) {
    var2 = tablelookupbyrow("mp/supertable.csv", var1, 0);

    if(!isDefined(var2) || var2 == "") {
      break;
    }

    var3 = readsupertablecell(var1, 3, 1);

    if(istrue(var3) && !var0) {
      var1++;
      continue;
    }

    var4 = spawnStruct();
    level.superglobals.staticsuperdata[var2] = var4;
    var4.id = var1;
    var4.ref = var2;
    var4.weapon = readsupertablecell(var1, 1);
    var5 = undefined;

    if(scripts\mp\utility\game::isanymlgmatch()) {
      var5 = readsupertablecell(var1, 28, 1);
    }

    if(!isDefined(var5)) {
      var5 = readsupertablecell(var1, 2, 1);
    }

    var4.pointsneeded = var5;
    var6 = undefined;

    if(scripts\mp\utility\game::isanymlgmatch()) {
      var6 = readsupertablecell(var1, 26, 1);
    }

    if(!isDefined(var6)) {
      var6 = readsupertablecell(var1, 4, 1);
    }

    var4.usetime = var6;
    var4.maxactivations = readsupertablecell(var1, 5, 1);
    var4.ref_12acd = readsupertablecell(var1, 6, 1);
    var4.useweapon = readsupertablecell(var1, 11);
    var4.useweaponclipammo = readsupertablecell(var1, 12, 1);
    var4.useweaponstockammo = readsupertablecell(var1, 13, 1);
    var4.useweapontrackstats = readsupertablecell(var1, 31, 1) > 0;
    var4.movespeed = readsupertablecell(var1, 14, 1);
    var7 = undefined;

    if(scripts\mp\utility\game::isanymlgmatch()) {
      var7 = readsupertablecell(var1, 27, 1);
    }

    if(!isDefined(var7)) {
      var7 = readsupertablecell(var1, 15, 1);
    }

    var4.graceperiod = var7;
    var4.maxactivationsalt = readsupertablecell(var1, 16, 1);
    var4.usedelay = readsupertablecell(var1, 18, 1);
    var4.ending_mortars = readsupertablecell(var1, 19, 1);
    var4.archetype = readsupertablecell(var1, 17);
    var4.isweapon = readsupertablecell(var1, 20, 1);
    var4.canuseinlaststand = readsupertablecell(var1, 32, 1) > 0;
    var4.packextrascore0 = [];

    if(isDefined(var4.useweapon)) {
      var4.useweapon = asmdevgetallstates(var4.useweapon);
    }

    level.superglobals.supersbyid[var1] = var2;

    if(!isDefined(var4.weapon)) {
      level.superglobals.staticsuperdata[var2] = undefined;
    } else {
      level.superglobals.supersbyoffhand[var4.weapon] = var4;
    }

    if(!isDefined(var4.pointsneeded)) {
      level.superglobals.staticsuperdata[var2] = undefined;
    }

    if(isDefined(var4.maxactivations)) {
      if(var4.maxactivations > 0) {
        var4.activatepenalty = 1 / var4.maxactivations;
      } else {
        var4.activatepenalty = 1;
      }
    }

    if(isDefined(var4.maxactivationsalt)) {
      if(var4.maxactivationsalt > 0) {
        var4.activatepenaltyalt = 1 / var4.maxactivationsalt;
      }
    }

    if(isDefined(var4.useweapon)) {
      level.superglobals.superweapons[var4.useweapon.basename] = var4;
    }

    if(var4.weapon == "<default>") {
      var4.weapon = "super_default_mp";
    }

    if(isDefined(var4.graceperiod)) {
      var4.graceperiod *= 1000;
      continue;
    }

    var4.graceperiod = 0;
  }

  var8 = tablelookup("mp/superratetable.csv", 0, scripts\mp\utility\game::getgametype(), 1);

  if(isDefined(var8) && var8 != "") {
    level.superglobals.superearnratemultiplier = float(var8);
    return;
  }
}

function readsupertablecell(var0, var1, var2) {
  var3 = tablelookupbyrow("mp/supertable.csv", var0, var1);

  if(var3 == "") {
    return undefined;
  }

  if(istrue(var2)) {
    if(issubstr(var3, ".")) {
      var3 = float(var3);
    } else {
      var3 = int(var3);
    }
  }

  return var3;
}

function loadpointstable() {
  var0 = 2;
  var1 = scripts\mp\utility\game::getgametype();

  for(;;) {
    var2 = tablelookupbyrow("mp/superpointstable.csv", 0, var0);

    if(!isDefined(var2) || var2 == "") {
      var0 = undefined;
      break;
    }

    if(var2 == var1) {
      break;
    }

    var0++;
  }

  var3 = 0;

  for(;;) {
    var3++;
    var4 = tablelookupbyrow("mp/superpointstable.csv", var3, 0);

    if(!isDefined(var4) || var4 == "") {
      break;
    }

    var5 = undefined;

    if(isDefined(var0)) {
      var5 = tablelookupbyrow("mp/superpointstable.csv", var3, var0);

      if(isDefined(var5) && var5 == "") {
        var5 = undefined;
      }
    }

    if(!isDefined(var5)) {
      var5 = tablelookupbyrow("mp/superpointstable.csv", var3, 1);
    }

    var5 = float(var5);

    if(var5 <= 0) {
      continue;
    }

    level.superglobals.pointeventdata[var4] = var5;
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

function registersuper(var0, var1, var2, var3, var4) {
  var5 = level.superglobals.staticsuperdata[var0];

  if(!isDefined(var5)) {
    return;
  }

  var5.setfunc = var1;
  var5.unsetfunc = var2;
  var5.beginusefunc = var3;
  var5.endusefunc = var4;
  var5.isregistered = 1;
}

function ref_12b3c(var0, var1) {
  if(!isstring(var1)) {
    var1 = var1.basename;
  }

  var2 = level.superglobals.staticsuperdata[var0];
  var2.packextrascore0[var2.packextrascore0.size] = var1;
  level.superglobals.ref_13987[var1] = var2;
}

function ref_13978() {
  ref_14021();
  updatesuperuistate();
}

function givesuper(var0, var1, var2) {
  if(getdvarint("scr_supers_killswitch") != 0) {
    return;
  }

  clearsuper(var1);

  if(var0 == "") {
    return;
  }

  var3 = level.superglobals.staticsuperdata[var0];

  if(!isDefined(var3)) {
    return;
  }

  var4 = spawnStruct();
  self.super = var4;
  var4.staticdata = var3;
  var4.allowrefund = 1;
  var4.numkills = 0;
  var4.wasrefunded = 0;
  var4.canstow = 0;
  var4.basepoints = 0;
  var4.extrapoints = 0;
  var4.usestarttime = undefined;
  var4.usepercent = 0;
  var4.ref_12187 = undefined;
  ref_131c7(0);
  ref_13985(var0);
  self setclientomnvar("ui_super_ref", var0);
  var5 = self.pers["superBasePoints"];

  if(!isDefined(var5)) {
    var5 = 0;
  }

  self.pers["superBasePoints"] = undefined;
  setsuperbasepoints(var5);
  var6 = self.pers["superExtraPoints"];

  if(!isDefined(var6)) {
    var6 = 0;
  }

  self.pers["superExtraPoints"] = undefined;
  setsuperextrapoints(var6);

  if(!isDefined(self.pers["superExpended"])) {
    ref_131c6(0);
  }

  if(istrue(var2)) {
    givesuperpoints(getsuperpointsneeded());
    var4.madeavailabletime = gettime();
    scripts\mp\analyticslog::logevent_superearned(var4.madeavailabletime);
  }

  if(!issuperweapondisabled()) {
    scripts\cp_mp\utility\inventory_utility::_giveweapon(var3.weapon);
    var7 = scripts\engine\utility::ter_op(issuperready(), 1, 0);
    self setweaponammoclip(var3.weapon, var7);
    self assignweaponoffhandspecial(var3.weapon);
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

  var0 = gettime();
  waitframe();

  for(;;) {
    var1 = level.players.size;
    var2 = (gettime() - var0) / 50;

    if(var2 < 11) {
      wait(11 - var2) * 0.05;
      var2 = 11;
    }

    var0 = gettime();
    var3 = 0;

    while(var3 < var1) {
      for(var4 = 0; var4 < 15; var4++) {
        var5 = var3 + var4;
        var6 = level.players[var5];

        if(!isDefined(var6)) {
          continue;
        }

        if(istrue(var6.pausesuperpointsovertime)) {
          continue;
        }

        if(!scripts\mp\utility\player::isreallyalive(var6)) {
          continue;
        }

        if(isDefined(getcurrentsuper(var6)) && !getcurrentsuper(var6).isinuse) {
          givesuperpoints(var6, 0, "time", 0, var2);
        }
      }

      waitframe();
      var3 += 15;
    }

    waitframe();
  }
}

function clearsuper(var0) {
  var1 = getcurrentsuper();

  if(isDefined(var1) && isDefined(var1.staticdata)) {
    ref_13986(var1.staticdata.ref);
  }

  if(istrue(var0) && isDefined(var1)) {
    storesuperpoints();
  }

  self clearoffhandspecial();

  if(isDefined(var1)) {
    scripts\cp_mp\utility\inventory_utility::_takeweapon(var1.staticdata.weapon);
  }

  if(level.codcasterenabled && !isagent(self)) {
    self setspecialactive(0);
  }

  self notify("remove_super");
  self.super = undefined;
  thread _calloutmarkerping_handleluinotify_added::ref_1313d("ui_super_state", 0);
  self setclientomnvar("ui_super_ref", "none");
}

function ref_13985(var0) {
  if(!isDefined(var0)) {
    return;
  }

  if(var0 == "none" || var0 == "") {
    return;
  }

  var1 = level.superglobals.staticsuperdata[var0];

  if(!isDefined(var1)) {
    return;
  }

  var2 = var1.setfunc;

  if(!isDefined(var2)) {
    return;
  }

  self thread[[var2]]();
}

function ref_13986(var0) {
  if(!isDefined(var0)) {
    return;
  }

  if(var0 == "none" || var0 == "") {
    return;
  }

  var1 = level.superglobals.staticsuperdata[var0];

  if(!isDefined(var1)) {
    return;
  }

  var2 = var1.unsetfunc;

  if(!isDefined(var2)) {
    return;
  }

  self thread[[var2]]();
}

function setsuperbasepoints(var0, var1) {
  var2 = getcurrentsuper();
  var2.basepoints = clamp(var0, 0, getsuperpointsneeded());

  if(istrue(var1)) {
    return;
  }

  superpointschanged();
}

function setsuperextrapoints(var0, var1) {
  var2 = getcurrentsuper();
  var2.extrapoints = clamp(var0, 0, getsuperpointsneeded());

  if(istrue(var1)) {
    return;
  }

  superpointschanged();
}

function superpointschanged() {
  var0 = getcurrentsuper();

  if(getcurrentsuperpoints() >= getsuperpointsneeded()) {
    superearned();
  } else {
    self setweaponammoclip(var0.staticdata.weapon, 0);
  }

  ref_14021();
  updatesuperuistate();
}

function givesuperpoints(var0, var1, var2, var3) {
  if(istrue(game["isLaunchChunk"]) || !level.allowsupers) {
    return;
  }

  if(isDefined(var1)) {
    var0 = getsuperpointsforevent(var1);
  }

  if(isDefined(var3)) {
    var0 *= var3;
  }

  if(scripts\mp\utility\perk::_hasperk("specialty_faster_field_upgrade")) {
    var0 *= getdvarfloat("perk_faster_field_upgrade_rate");
  }

  if(getdvarint("scr_disableSuperPoints", 0) && !istrue(var2)) {
    return;
  }

  if(isDefined(var1) && var1 == "time") {
    var4 = var0 * level.superfastchargerate;
  } else {
    var4 = var1 * level.superpointsmod;
  }

  if(var4 <= 0) {
    return;
  }

  var5 = getcurrentsuper();

  if(!isDefined(var5) || issuperready() || var5.isinuse || issuperexpended()) {
    updatesppm(var1, 0, var2);
    return;
  }

  var6 = min(var4 + var5.basepoints, getsuperpointsneeded());
  setsuperbasepoints(var6);
  scripts\mp\analyticslog::logevent_reportsuperscore(var4, gettime());
  updatesppm(var1, 1, var2);
}

function ref_14021() {
  var0 = getcurrentsuper();

  if(!isDefined(var0)) {
    return;
  }

  if(scripts\mp\utility\player::isinkillcam() || !isalive(self)) {
    var0.ref_11fcd = undefined;
    return;
  }

  var1 = 0;

  if(var0.isinuse) {
    var1 = getsuperuseuiprogress();
  } else if(!issuperexpended()) {
    var2 = getsuperpointsneeded();
    var1 = clamp(getcurrentsuperbasepoints() / var2, 0, 1);
  }

  if(!isDefined(var0.ref_11fcd) || var1 != var0.ref_11fcd) {
    self setclientomnvar("ui_super_progress", var1);
  }

  self setplayersupermeterprogress(var1);
  var0.ref_11fcd = var1;
}

function updatesuperuistate() {
  var0 = getcurrentsuper();

  if(!isDefined(var0)) {
    return;
  }

  if(scripts\mp\utility\player::isinkillcam() || !isalive(self)) {
    var0.state = undefined;
    return;
  }

  var1 = var0.state;
  var2 = 1;

  if(issuperexpended()) {
    var2 = 4;
  } else if(issuperready()) {
    var2 = 2;
  } else if(issuperinuse()) {
    var2 = 3;
  }

  if(!isDefined(var1) || var2 != var1) {
    thread _calloutmarkerping_handleluinotify_added::ref_1313d("ui_super_state", var2);
  }

  var0.state = var2;
}

function watchforrespawn() {
  var0 = getcurrentsuper();
  self endon("disconnect");
  self endon("remove_super");

  for(;;) {
    self waittill("spawned_player");
    givesuperweapon(var0);
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
  var0 = self.team;
  self waittill("joined_team");

  if(self.team != var0) {
    self.currentfirstupgrade = undefined;
    thread clearsuper(0);
    return;
  }
}

function handlepointdecay() {
  self endon("disconnect");
  self endon("remove_super");
  level endon("game_ended");
  var0 = getcurrentsuper();
  var1 = getdvarfloat("scr_super_decay_rate", 6) * level.framedurationseconds;

  for(;;) {
    if(!issupercharging()) {
      waitframe();
      continue;
    }

    var2 = max(var0.extrapoints - var1, 0);
    setsuperextrapoints(var2);
    waitframe();
  }
}

function superearned() {
  var0 = getcurrentsuper();
  self setweaponammoclip(var0.staticdata.weapon, 1);
  var1 = !var0.wasrefunded;
  self notify("super_ready", var1);

  if(var1) {
    self.pers["supersEarned"]++;
    self notify("super_earned");
    recordsuperearnedanalytics(var0);
  }

  var0.madeavailabletime = gettime();
  var0.numkills = 0;
  scripts\mp\analyticslog::logevent_superearned(var0.madeavailabletime);
  setsuperextrapoints(0, 1);
  setsuperbasepoints(getsuperpointsneeded(), 1);

  if(isDefined(self.matchdatalifeindex)) {
    scripts\mp\analyticslog::logevent_fieldupgradeearned(self, var0.staticdata.id);
    return;
  }
}

function watchforsuperusebegin() {
  self endon("disconnect");
  self endon("remove_super");

  for(;;) {
    self waittill("special_weapon_fired", var0);
    var1 = trysuperusebegin(var0);

    if(!istrue(var1)) {
      continue;
    }

    self waittill("super_use_finished");
  }
}

function trysuperusebegin(var0) {
  if(!scripts\mp\utility\player::isreallyalive(self)) {
    return 0;
  }

  if(var0.basename != getcurrentsuper().staticdata.weapon) {
    return 0;
  }

  if(!scripts\common\utility::is_supers_allowed()) {
    return 0;
  }

  return beginsuperuse();
}

function beginsuperuse() {
  self endon("death_or_disconnect");
  var0 = getcurrentsuper();
  self notify("super_started");
  scripts\mp\gamelogic::sethasdonecombat(self, 1);

  if(var0.staticdata.weapon == "support_box_mp") {
    self playlocalsound("iw8_support_box_deploy");
  }

  if(isDefined(var0) && !var0.isinuse) {
    var1 = !istrue(self.inlaststand) || var0.staticdata.canuseinlaststand;
    var2 = 1;

    if(isDefined(var0.staticdata.useweapon)) {
      if(scripts\mp\arbitrary_up::isinarbitraryup() && superdisabledinarbitraryup(var0.staticdata.ref)) {
        superdisabledinarbitraryupmessage();
        var2 = 0;
      } else if(!var1) {
        var2 = 0;
      } else {
        var2 = trygiveuseweapon(var0.staticdata.useweapon, var0.staticdata.useweaponclipammo, var0.staticdata.useweaponstockammo);
      }
    }

    if(var2 && var1 && (!isDefined(var0.staticdata.beginusefunc) || istrue(self[[var0.staticdata.beginusefunc]]()))) {
      var3 = [];
      GscBinSkip0(0x2e, 0, "super_use_finished_lb");
    }

    if(isDefined(var1.staticdata.useweapon) && var3) {
      thread switchandtakesuperuseweapon();
    }

    if(istrue(self.inlaststand)) {
      thread ref_144fa(var1.staticdata.weapon);
    } else {
      self setweaponammoclip(var1.staticdata.weapon, 1);
    }
  }

  return false;
}

function activatesuper(var0, var1) {
  var2 = getcurrentsuper();

  if(!isDefined(var0)) {
    var0 = 0;
  }

  if(var0 && isDefined(var2.staticdata.activatepenaltyalt)) {
    reducesuperusepercent(var2.staticdata.activatepenaltyalt, var1);
  } else if(isDefined(var2.staticdata.activatepenalty)) {
    reducesuperusepercent(var2.staticdata.activatepenalty, var1);
  }

  return true;
}

function updateusetimedecay() {
  self endon("death_or_disconnect");
  self endon("game_ended");
  self endon("super_use_finished");
  var0 = getcurrentsuper();

  if(!isDefined(var0.staticdata.usetime)) {
    waitframe();

    if(issuperinuse()) {
      superusefinished();
    }

    return;
  }

  jumpiffalse(var0.staticdata.usetime < 0) LOC_0000004e;
  return;
}

function reducesuperusepercent(var0, var1, var2) {
  var3 = getcurrentsuper();
  var3.usepercent = max(var3.usepercent - var0, 0);

  if(istrue(var1)) {
    var3.allowrefund = 0;
  }

  if(!isDefined(var2) || var2 == 0) {
    superusedurationupdated();
    return;
  }
}

function resetsuperusepercent() {
  var0 = getcurrentsuper();
  var0.usepercent = 1;
  superusedurationupdated();
}

function superusedurationupdated() {
  var0 = getcurrentsuper();

  if(isbot(self)) {
    if(isDefined(var0.staticdata.useweapon) && var0.staticdata.isweapon == 1) {
      var1 = self getammocount(var0.staticdata.useweapon);

      if(isDefined(var1) && var1 > 0) {
        superusefinished();
        return;
      }
    }
  }

  if(var0.usepercent <= 0) {
    superusefinished();
    return;
  }
}

function superusefinished(var0, var1, var2, var3) {
  var4 = getcurrentsuper();
  self notify("super_use_finished_lb");
  var5 = 0;

  if(!isDefined(var3) || var3 == 0) {
    var5 = shouldrefundsuper();
  }

  ref_131c7(0);
  var4.canstow = 0;
  var6 = undefined;

  if(isDefined(var4.staticdata.endusefunc)) {
    if(!isDefined(var1)) {
      var1 = 0;
    }

    var6 = self[[var4.staticdata.endusefunc]](var1);
  }

  if(var5 || istrue(var0) || istrue(var6)) {
    ref_131c6(0);
    var4.wasrefunded = 1;
    setsuperbasepoints(getsuperpointsneeded());
  } else if(istrue(var2)) {
    ref_131c6(0);
    var7 = getsuperpointsneeded() * var4.usepercent;
    var4.wasrefunded = 1;
    setsuperbasepoints(var7);
  } else {
    ref_131c6(1);
    var4.lastfinishtime = gettime();
    var4.wasrefunded = 0;
  }

  thread switchandtakesuperuseweapon();
  var8 = var4.usestarttime - var4.madeavailabletime;
  scripts\mp\analyticslog::logevent_superended(var4.staticdata.ref, var8, 0, var4.numkills);

  if(level.codcasterenabled) {
    self setspecialactive(0);
  }

  scripts\mp\utility\print::printgameaction("super use ended - " + var4.staticdata.ref, self);

  if(scripts\mp\utility\game::getgametype() == "br") {
    if(!level.allowsupers) {
      if(!istrue(var0)) {
        self setclientomnvar("ui_perk_package_state", 0);
        self setclientomnvar("ui_super_progress", 0);
      }
    } else if(var4.staticdata.ending_mortars) {
      clearsuper();
      self setclientomnvar("ui_perk_package_state", 0);
      self setclientomnvar("ui_super_progress", 0);
      thread _calloutmarkerping_handleluinotify_added::ref_1313d("ui_super_state", 0);
    }
  }

  self notify("super_use_finished");
  scripts\cp\vehicles\vehicle_compass_cp::ref_12097(var4, var5);
}

function refundsuper() {
  var0 = getcurrentsuper();

  if(isDefined(var0)) {
    if(var0.isinuse) {
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

  var0 = getcurrentsuper();
  var1 = var0.staticdata.ref_12acd;
  superusefinished(var1, 1);
}

function monitoruseweaponfiring(var0) {
  self endon("death_or_disconnect");
  self endon("super_use_finished");
  self endon("remove_super");

  for(;;) {
    self waittill("weapon_fired", var1);

    if(isnullweapon(var1, var0, 1)) {
      activatesuper(var1.isalternate, 1);
    }
  }
}

function trygiveuseweapon(var0, var1, var2) {
  self endon("death_or_disconnect");
  scripts\cp_mp\utility\inventory_utility::_giveweapon(var0);
  self setweaponammoclip(var0, var1);
  self setweaponammostock(var0, var2);
  var3 = scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(var0, isbot(self));

  if(var3) {
    thread manageuseweapon(var0);
    thread monitoruseweaponfiring(var0);
    return true;
  }

  scripts\cp_mp\utility\inventory_utility::abortmonitoredweaponswitch(var0);
  return false;
}

function manageuseweapon(var0) {
  self endon("death_or_disconnect");
  self endon("super_use_finished");
  var1 = getcurrentsuper();
  var1.useweaponswapped = undefined;
  var2 = 0;

  for(;;) {
    var3 = self getcurrentweapon();

    if(!var1.canstow && !isnullweapon(var0, var3, 1)) {
      if(var3.basename == "iw7_uplinkball_mp" || var3.basename == "iw7_tdefball_mp") {
        var2 = 1;
      }

      break;
    }

    waitframe();
  }

  if(issuperinuse()) {
    var1.useweaponswapped = 1;
    superusefinished(undefined, undefined, var2);
    return;
  }
}

function switchandtakesuperuseweapon() {
  self endon("death");
  var0 = getcurrentsuper();
  var1 = var0.staticdata.useweapon;

  if(!isDefined(var1)) {
    return;
  }

  if(scripts\cp_mp\utility\inventory_utility::isswitchingtoweaponwithmonitoring(var1)) {
    scripts\cp_mp\utility\inventory_utility::abortmonitoredweaponswitch(var1);
    return;
  }

  self notify("super_switched");
  scripts\cp_mp\utility\inventory_utility::getridofweapon(var1);
}

function storesuperpoints() {
  var0 = getcurrentsuper();

  if(!isDefined(var0)) {
    return;
  }

  if(issupercharging() || issuperready()) {
    self.pers["superBasePoints"] = var0.basepoints;
    self.pers["superExtraPoints"] = var0.extrapoints;
    return;
  }

  if(issuperinuse() && shouldrefundsuper()) {
    var1 = getsuperpointsneeded();
    self.pers["superPoints"] = var0.usepercent * var1;
    self.pers["superExtraPoints"] = 0;
    return;
  }

  self.pers["superBasePoints"] = 0;
  self.pers["superExtraPoints"] = 0;
}

function getsuperuseuiprogress() {
  var0 = getcurrentsuper();
  return var0.usepercent;
}

function getcurrentsuperbasepoints() {
  return getcurrentsuper().basepoints;
}

function getcurrentsuperextrapoints() {
  return getcurrentsuper().basepoints;
}

function getcurrentsuperpoints() {
  var0 = getcurrentsuper();
  return var0.basepoints + var0.extrapoints;
}

function getsuperpointsneeded() {
  var0 = getcurrentsuper();
  var1 = var0.staticdata.pointsneeded;

  if(isDefined(var0.ref_12187)) {
    var1 = var0.ref_12187;
  }

  return var1;
}

function issuperready() {
  var0 = getcurrentsuper();

  if(!isDefined(var0) || var0.isinuse) {
    return false;
  }

  return getcurrentsuperpoints() >= getsuperpointsneeded();
}

function issuperinuse() {
  return isDefined(getcurrentsuper()) && getcurrentsuper().isinuse;
}

function ref_131c7(var0) {
  var1 = getcurrentsuper();
  var1.isinuse = var0;
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

function ref_131c6(var0) {
  self.pers["superExpended"] = var0;
  updatesuperuistate();
}

function getcurrentsuper() {
  return self.super;
}

function getcurrentsuperref() {
  var0 = getcurrentsuper();

  if(!isDefined(var0)) {
    return undefined;
  }

  return var0.staticdata.ref;
}

function shouldrefundsuper() {
  var0 = getcurrentsuper();
  var1 = var0.staticdata.graceperiod;
  var2 = undefined;

  if(isDefined(var0) && isDefined(var0.usestarttime)) {
    var2 = gettime() - var0.usestarttime;
  }

  if(!isDefined(var2) || var2 >= var1) {
    return 0;
  }

  if(var0.numkills > 0) {
    return 0;
  }

  return var0.allowrefund;
}

function getsuperrefforsuperuseweapon(var0) {
  if(!isstring(var0)) {
    var0 = var0.basename;
  }

  if(!isDefined(level.superglobals) || !isDefined(level.superglobals.superweapons) || !isDefined(level.superglobals.superweapons[var0])) {
    return undefined;
  }

  return level.superglobals.superweapons[var0].ref;
}

function getsuperrefforsuperoffhand(var0) {
  if(!isstring(var0)) {
    var0 = var0.basename;
  }

  if(!isDefined(level.superglobals.supersbyoffhand[var0])) {
    return undefined;
  }

  return level.superglobals.supersbyoffhand[var0].ref;
}

function roundkillexecute(var0) {
  if(!isstring(var0)) {
    var0 = var0.basename;
  }

  if(!isDefined(level.superglobals.ref_13987[var0])) {
    return undefined;
  }

  return level.superglobals.ref_13987[var0].ref;
}

function getsuperrefforsuperweapon(var0) {
  if(!isDefined(level.superglobals)) {
    return undefined;
  }

  if(!isstring(var0)) {
    var0 = var0.basename;
  }

  var1 = getsuperrefforsuperuseweapon(var0);

  if(isDefined(var1)) {
    return var1;
  }

  var2 = getsuperrefforsuperoffhand(var0);

  if(isDefined(var2)) {
    return var2;
  }

  var2 = roundkillexecute(var0);

  if(isDefined(var2)) {
    return var2;
  }

  return undefined;
}

function shouldtracksuperweaponstats(var0) {
  var1 = getsuperrefforsuperweapon(var0);

  if(isDefined(var1)) {
    var2 = level.superglobals.staticsuperdata[var1];
    return var2.useweapontrackstats;
  }

  return undefined;
}

function getsuperid(var0) {
  if(!isDefined(var0) || !isDefined(level.superglobals) || !isDefined(level.superglobals.staticsuperdata) || !isDefined(level.superglobals.staticsuperdata[var0]) || var0 == "none") {
    return 0;
  }

  return level.superglobals.staticsuperdata[var0].id;
}

function getmovespeedforsuperweapon(var0) {
  var1 = getsuperrefforsuperweapon(var0);

  if(!isDefined(var1)) {
    return undefined;
  }

  return level.superglobals.staticsuperdata[var1].movespeed;
}

function getrootsuperref(var0) {
  return getsubstr(var0, 6);
}

function allowsuperweaponstow() {
  var0 = getcurrentsuper();

  if(!isDefined(var0) || !var0.isinuse) {
    return;
  }

  var0.canstow = 1;
}

function unstowsuperweapon() {
  var0 = getcurrentsuper();

  if(!isDefined(var0) || !var0.canstow) {
    return;
  }

  if(!var0.isinuse || !isDefined(var0.staticdata.useweapon)) {
    var0.canstow = 0;
    return;
  }

  scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(var0.staticdata.useweapon);
  var0.canstow = 0;
}

function getsuperpointsforevent(var0) {
  var1 = level.superglobals.pointeventdata[var0];

  if(!isDefined(var1)) {
    return 0;
  }

  return var1;
}

function watchforgameend() {
  level waittill("game_ended");

  if(scripts\mp\utility\game::waslastround()) {
    foreach(var1 in level.players) {
      writesppmstats(var1);
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

function updatesppm(var0, var1, var2) {
  if(getdvarint("scr_sppm_data", 0) == 0) {
    return;
  }

  if(isai(self)) {
    return;
  }

  var3 = getsppmdata();
  var3.totalpoints += var0;

  if(istrue(var1)) {
    var3.totalappliedpoints += var0;
  }

  if(!isDefined(var2)) {
    var2 = "undefined";
  }

  if(!isDefined(var3.eventtotals[var2])) {
    var3.eventtotals[var2] = var0;
    return;
  }

  var3.eventtotals[var2] += var0;
}

function writesppmstats() {
  if(getdvarint("scr_sppm_data", 0) == 0) {
    return;
  }

  if(isai(self)) {
    return;
  }

  var0 = getsppmdata();
  var1 = scripts\mp\persistence::statgetchildbuffered("round", "timePlayed", 1) / 60;
  var2 = 0;
  var3 = 0;

  if(var1 > 0) {
    var2 = var0.totalpoints / var1;
    var3 = var0.totalappliedpoints / var1;
  }

  var4 = "";
  var5 = -1;

  foreach(var7 in var0.eventtotals) {
    if(var7 > var5) {
      var5 = var7;
      var4 = var8;
    }
  }

  getentitylessscriptablearray("mpscript_sppm", ["sppm", var2, "sppm_applied", var3, "gamemode", scripts\mp\utility\game::getgametype(), "kills", self.kills, "time_played", var1, "best_event", var4, "script_version", getscriptdataversion()]);
}

function modifysuperequipmentdamage(var0, var1, var2, var3, var4) {
  var5 = var3;

  if(isDefined(self.owner) && isDefined(var0) && var0 == self.owner) {
    var5 = int(ceil(var3 * 0.5));
  }

  return var5;
}

function updateactivesupers(var0, var1, var2, var3, var4, var5, var6, var7) {
  var8 = isDefined(var0) && isPlayer(var0);
  var9 = var5.basename == "throwingknife_mp" || var5.basename == "throwingknife_fire_mp" || var5.basename == "throwingknife_electric_mp" || var5.basename == "throwingknife_drill_mp";
  var10 = var9 && isDefined(var0) && isDefined(var0.classname) && var0.classname == "grenade";
  var11 = isDefined(var1) && isPlayer(var1) && var1 != var2;

  if(var11) {
    var12 = getcurrentsuper(var1);

    if(var8 || var10) {
      if(isDefined(var12) && var12.staticdata.ref == "super_deadsilence" && issuperinuse(var1)) {
        var1 thread scripts\mp\supers\super_deadsilence::superdeadsilence_onkill();
      }
    }

    if(var8 && var0 scripts\mp\utility\perk::_hasperk("specialty_bulletdamage")) {
      var1 thread scripts\mp\supers\super_stoppingpower::ref_138ec(var5);
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

function setsuperweapondisabled(var0) {
  self.issuperdisabled = var0;

  if(!var0) {
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
  var0 = getcurrentsuper();

  if(isDefined(var0)) {
    var1 = var0.staticdata.weapon;
    scripts\cp_mp\utility\inventory_utility::_takeweapon(var1);
    givesuperdisableweapon();
  }

  thread cleanupsuperdisableweapon();
  jumpiftrue(istrue(scripts\mp\flags::gameflag("prematch_done"))) LOC_00000070;
  level waittill("super_delay_start");

  for(;;) {
    self waittill("special_weapon_fired", var2);

    if(var2.basename != "super_delay_mp") {
      continue;
    }

    self setweaponammoclip(var2, 99);

    if(issuperready()) {
      var3 = (level.superdelayendtime - gettime()) / 1000;
      var3 = int(max(0, ceil(var3)));

      if(var3 > 0) {
        scripts\mp\hud_message::showerrormessage("MP/SUPERS_UNAVAILABLE_FOR_N", var3);
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
  var0 = getcurrentsuper();

  if(isDefined(var0)) {
    var1 = var0.staticdata.weapon;
    var2 = scripts\engine\utility::ter_op(issuperready(), 1, 0);
    scripts\cp_mp\utility\inventory_utility::_giveweapon(var1);
    self setweaponammoclip(var1, var2);
    self assignweaponoffhandspecial(var1);
    scripts\cp_mp\utility\inventory_utility::_takeweapon("super_delay_mp");
  }

  self notify("super_disable_end");
}

function givesuperdisableweapon() {
  scripts\cp_mp\utility\inventory_utility::_giveweapon("super_delay_mp");
  self setweaponammoclip("super_delay_mp", 99);
  self assignweaponoffhandspecial("super_delay_mp");
}

function givesuperweapon(var0) {
  if(superdelaypassed()) {
    if(!self hasweapon(var0.staticdata.weapon)) {
      var1 = scripts\engine\utility::ter_op(issuperready(), 1, 0);
      scripts\cp_mp\utility\inventory_utility::_giveweapon(var0.staticdata.weapon);
      self setweaponammoclip(var0.staticdata.weapon, var1);
      self assignweaponoffhandspecial(var0.staticdata.weapon);
      return;
    }

    return;
  }

  givesuperdisableweapon();
}

function watchobjuse(var0, var1) {
  self endon("death_or_disconnect");
  self endon("obj_drain_end");
  self endon("ball_dropped");

  if(scripts\mp\utility\game::getgametype() == "sd" || scripts\mp\utility\game::getgametype() == "sr" || scripts\mp\utility\game::getgametype() == "dd") {
    if(istrue(var1)) {
      self waittill("super_obj_drain");
    }
  } else if(!isDefined(self.carryobject)) {
    self waittill("obj_picked_up");
  } else {
    wait 0.05;
  }

  while(issuperinuse()) {
    reducesuperusepercent(var0);
    wait 0.05;
  }
}

function combatrecordsuperuse(var0) {
  if(!scripts\mp\utility\stats::canrecordcombatrecordstats()) {
    return;
  }

  if(var0 == "super_kiosk_drop") {
    return;
  }

  var1 = self getplayerdata("mp", "playerStats", "superStats", var0, "uses");
  self setplayerdata("mp", "playerStats", "superStats", var0, "uses", var1 + 1);
}

function combatrecordsuperkill(var0) {
  if(!scripts\mp\utility\stats::canrecordcombatrecordstats()) {
    return;
  }

  var1 = self getplayerdata("mp", "playerStats", "superStats", var0, "kills");
  self setplayerdata("mp", "playerStats", "superStats", var0, "kills", var1 + 1);
}

function hide_plunderboxes(var0, var1) {
  if(!scripts\mp\utility\stats::canrecordcombatrecordstats()) {
    return;
  }

  if(!isDefined(var1)) {
    var1 = 1;
  }

  var2 = relic_fastbleedout_returnfunc(var0);
  self setplayerdata("mp", "playerStats", "superStats", var0, "misc1", var2 + var1);
}

function relic_fastbleedout_returnfunc(var0) {
  return self getplayerdata("mp", "playerStats", "superStats", var0, "misc1");
}

function superdisabledinarbitraryup(var0) {
  if(var0 == "super_microturret" || var0 == "super_supertrophy") {
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
  var0 = spawn("script_model", self.origin + (0, 0, 400));
  self.scrambleent = var0;
  self.scrambleent setModel("super_scramble_mp");
  self.scrambleent linkTo(self);
  self.scrambleent.owner = self;
  self.scrambleent.team = self.team;
  self.scrambleent setotherent(self);
  self.scrambleent setscriptablepartstate("scramble_sfx", "on", 0);
  thread scripts\cp_mp\killstreaks\helper_drone::spawn_ai_single(self);
  return true;
}

function scrambleusefinished(var0) {
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

function recondroneenduse(var0) {
  return scripts\cp_mp\killstreaks\helper_drone::recondrone_endsuper(var0);
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

function deadsilenceenduse(var0) {
  return scripts\mp\supers\super_deadsilence::superdeadsilence_endsuper(var0);
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
  var0 = scripts\mp\perks\perkpackage::perkpackage_getfirstfieldupgrade();
  ref_13985(var0);
  self.super.firstupgrade = var0;
  var1 = scripts\mp\perks\perkpackage::perkpackage_getsecondfieldupgrade();
  ref_13985(var1);
  self.super.secondupgrade = var1;
  var2 = level.superglobals.staticsuperdata[var0];
  var3 = 0;

  if(isDefined(var2)) {
    var3 = var2.pointsneeded;
  }

  var2 = level.superglobals.staticsuperdata[var1];
  var4 = 0;

  if(isDefined(var2)) {
    var4 = var2.pointsneeded;
  }

  var5 = max(var3, var4);
  self.super.ref_12187 = var5;
}

function ref_13989() {
  var0 = self.super.firstupgrade;
  ref_13986(var0);
  var1 = self.super.secondupgrade;
  ref_13986(var1);
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

function vehicle_createspawnselectionlittlebirdmarker(var0) {
  _donewithcorpse::vehicle_compass_playerspawnedcallback();
}

function superslingerbeginuse() {
  return scripts\mp\equipment\slinger::slinger_allow_use();
}

function ref_13983() {
  return true;
}

function serumgadgetbeginuse() {
  var0 = getcurrentsuper();
  var1 = var0.staticdata.usetime;
  thread _findnewlocaleplacement::start_serum_gadget(var1);
  return true;
}

function serumgadgetenduse(var0) {
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

function clearsuperreminderondeath(var0) {
  if(!isPlayer(var0)) {
    return;
  }

  thread clearsuperreminderondeathinternal(var0);
}

function clearsuperreminderondeathinternal(var0) {
  var0 endon("disconnect");
  var0 waittill("death");
  clearsuperremindersplash(var0);
}

function initsuperdvars() {
  setdvarifuninitialized("scr_super_decay_rate", 6);
}

function watchsuperlottery() {
  level endon("game_ended");
  var0 = getdvarint("scr_superLotteryDelay", 60);
  var1 = getdvarint("scr_superLotteryIntervalMin", 45);
  var2 = getdvarint("scr_superLotteryIntervalMax", 90);
  var3 = var2 - var1;
  waitframe();

  if(!istrue(scripts\mp\flags::gameflag("prematch_done"))) {
    level waittill("prematch_over");
  }

  wait var0;
  var4 = undefined;
  var5 = undefined;
  var6 = [];
  var7 = [];

  foreach(var9 in level.teamnamelist) {
    var6[var9] = undefined;
    var7 = [];
  }

  for(;;) {
    var4 = var5;
    var5 = getdvarint("scr_superLotteryEnabled", 0) > 0;

    if(!isDefined(var4) || var4 != var5) {
      if(var5) {
        level notify("superLotteryEnabled");
      } else {
        level notify("superLotteryDisabled");
      }
    }

    foreach(var9 in level.teamnamelist) {
      if(!isDefined(var6[var9])) {
        var6 = gettime() + (var1 + randomint(var3)) * 1000;
        continue;
      }

      if(var6[var9] <= gettime()) {
        var12 = scripts\mp\utility\teams::getteamdata(var9, "players");

        if(var12.size > 0) {
          var12 = scripts\engine\utility::array_randomize(var12);
          var13 = [];
          var14 = undefined;

          foreach(var16 in var12) {
            if(!scripts\engine\utility::array_contains(var7[var9], var16)) {
              if(isDefined(getcurrentsuper(var16))) {
                var14 = var16;
                break;
              }

              continue;
            }

            if(isDefined(getcurrentsuper(var16))) {
              var13 = var16;
            }
          }

          if(!isDefined(var14)) {
            if(isDefined(var13[0])) {
              var14 = var13[0];
            } else {
              var14 = var12[0];
            }
          }

          if(var5) {
            GscBinSkip4(0x35, var14);
          }

          var7 = var14;
        }

        var6[var9] = undefined;
      }
    }

    waitframe();
  }
}

function ref_144fa(var0) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self waittill("last_stand_finished");
  self setweaponammoclip(var0, 1);
}

function awardsuperlottery(var0) {
  var0 endon("disconnect");
  var0 endon("joined_team");
  level endon("superLotteryDisabled");
  var0 notify("awardSuperLottery");
  var0 endon("awardSuperLottery");

  for(;;) {
    var1 = getcurrentsuper(var0);

    if(!isDefined(var1)) {
      return;
    }

    if(!issuperinuse(var0)) {
      break;
    }

    waitframe();
  }

  givesuperpoints(var0, getsuperpointsneeded(), undefined, 1);
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

function recordsuperearnedanalytics(var0) {
  if(getdvarint("scr_super_earn_data", 0) == 0) {
    return;
  }

  var1 = scripts\mp\persistence::statgetchildbuffered("round", "timePlayed", 1) / 60;
  getentitylessscriptablearray("mpscript_super_earning", ["super_ref", var0.staticdata.ref, "earn_time", var1, "gamemode", scripts\mp\utility\game::getgametype(), "script_version", getscriptdataversion(), "earned_count", self.pers["supersEarned"]]);
}