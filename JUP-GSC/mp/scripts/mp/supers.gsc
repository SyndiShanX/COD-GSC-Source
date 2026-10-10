/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\supers.gsc
***********************************************/

#using script_1311c5c284dd1537;
#using script_268c558ddb2267aa;
#using script_2d9d24f7c63ac143;
#using script_34e2c429f1463c06;
#using script_548072087c9fd504;
#using script_63634d9fa080435a;
#using script_a698cf430108fb7;
#using script_b7a9ce0a2282b79;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\killstreaks\emp_drone_targeted;
#using scripts\cp_mp\killstreaks\helper_drone;
#using scripts\cp_mp\killstreaks\recon_drone;
#using scripts\cp_mp\oxygenmask;
#using scripts\cp_mp\supers\supers;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\cp_mp\utility\loot;
#using scripts\cp_mp\utility\player_utility;
#using scripts\engine\utility;
#using scripts\mp\analyticslog;
#using scripts\mp\arbitrary_up;
#using scripts\mp\battlechatter_mp;
#using scripts\mp\equipment\balloon_extract;
#using scripts\mp\equipment\battlerage;
#using scripts\mp\equipment\deployed_decoy;
#using scripts\mp\equipment\door_barricade;
#using scripts\mp\equipment\sonar_pulse;
#using scripts\mp\equipment\sound_veil;
#using scripts\mp\equipment\support_box;
#using scripts\mp\equipment\tac_insert;
#using scripts\mp\equipment\tactical_camera;
#using scripts\mp\equipment\tactical_cover;
#using scripts\mp\equipment\trophy_system;
#using scripts\mp\equipment\weapon_drop;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\gametypes\br;
#using scripts\mp\gametypes\br_pickups;
#using scripts\mp\hud_message;
#using scripts\mp\killstreaks\killstreaks;
#using scripts\mp\killstreaks\recon_drone_mp;
#using scripts\mp\outofbounds;
#using scripts\mp\perks\perkfunctions;
#using scripts\mp\perks\perkpackage;
#using scripts\mp\persistence;
#using scripts\mp\supers;
#using scripts\mp\supers\blindingturret;
#using scripts\mp\supers\gas_trap;
#using scripts\mp\supers\honeypot;
#using scripts\mp\supers\laststand_heal;
#using scripts\mp\supers\loadout_drop;
#using scripts\mp\supers\smokeairdrop;
#using scripts\mp\supers\super_deadsilence;
#using scripts\mp\supers\super_emp_pulse;
#using scripts\mp\supers\super_stimpistol;
#using scripts\mp\supers\super_stoppingpower;
#using scripts\mp\supers\super_suppression_rounds;
#using scripts\mp\supers\vehicle_drop;
#using scripts\mp\utility\game;
#using scripts\mp\utility\perk;
#using scripts\mp\utility\player;
#using scripts\mp\utility\print;
#using scripts\mp\utility\spawn_event_aggregator;
#using scripts\mp\utility\stats;
#using scripts\mp\utility\teams;
#using scripts\mp\utility\weapon;
#namespace supers;

function init() {
  if(!isDefined(level.supertable)) {
    if(isDefined(level.gametypebundle) && isDefined(level.gametypebundle.super_list)) {
      level.supertable = "superlist:" + level.gametypebundle.super_list;
    } else if(isDefined(level.gamemodebundle) && isDefined(level.gamemodebundle.super_list)) {
      level.supertable = "superlist:" + level.gamemodebundle.super_list;
    }

    assertex(isDefined(level.supertable), "<dev string:x1c>");
  }

  globals = spawnStruct();
  level.superglobals = globals;
  globals.staticsuperdata = [];
  globals.superweapons = [];
  globals.supersbyid = [];
  globals.supersbyoffhand = [];
  globals.supersbyextraweapon = [];
  globals.pointeventdata = [];
  globals.var_6fbfc62ab2f01ec7 = getdvarint(@ "hash_ec4c4df4cf064acf", 1) == 1;
  globals.var_9c670f8da841bf77 = getdvarint(@ "hash_d9a4449e71b65ed9", 13);
  function_f0327aead8f016e2(globals);
  scripts\cp_mp\supers\supers::function_e3234be372f6209d(level.supertable);
  registersupers();
  var_d6ee83b63aa9f11d = spawnStruct();
  var_d6ee83b63aa9f11d.var_47ce480103f7129f = &function_53110a12409d01da;
  callback::callback(#"register_super", var_d6ee83b63aa9f11d);
  callback::remove(#"register_super", #"all");
  initsuperdvars();
  scripts\mp\utility\spawn_event_aggregator::registeronplayerspawncallback(&clearsuperreminderondeath);
  thread watchforgameend();

  if(getdvarint(@ "hash_350b9a835c1f30b8", 0) > 0) {
    thread watchsuperlottery();
  }

  if(level.allowsupers || scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    level thread handlesuperearnovertime();
  }

  level notify("init_supers");
  scripts\mp\flags::gameflaginit("init_supers", 1);
  scripts\mp\equipment\door_barricade::function_bfeeefe1b4413ef0();
  scripts\mp\equipment\tactical_cover::tac_cover_init();
  scripts\mp\equipment\support_box::supportbox_init();
  scripts\mp\supers\super_stoppingpower::stoppingpower_init();
  namespace_5633828963c62e57::function_e24031140ed11f4f();
  scripts\mp\equipment\tactical_camera::function_5027f03acd35a5ca();
  namespace_87a763dd2088afea::function_c35f8fe1f419bb40();
  scripts\mp\supers\super_emp_pulse::function_dca5550c46b2a111();
  scripts\mp\supers\smokeairdrop::function_d1f6522bc93ed94e();
  scripts\mp\equipment\sonar_pulse::function_a09bd8d12b478568();
  scripts\mp\equipment\sound_veil::function_735ed2b006dce0eb();
  scripts\mp\supers\super_suppression_rounds::function_d0930f871341093c();
  scripts\mp\supers\loadout_drop::function_68300cd2b488ba4d();
  scripts\mp\equipment\balloon_extract::function_9b095d72f2911ec8();

  if(issharedfuncdefined("super_capture_bot", "init")) {
    [[getsharedfunc("super_capture_bot", "init")]]();
  }

  scripts\mp\killstreaks\recon_drone_mp::function_4beb6ea484d2db90();
  scripts\mp\supers\gas_trap::function_d8b2df497e0b97f();
  scripts\mp\supers\super_stimpistol::function_c916427f116f1206();
  scripts\cp_mp\oxygenmask::function_234851f94416f178();

  if(issharedfuncdefined("super_med_box", "init")) {
    [[getsharedfunc("super_med_box", "init")]]();
  }

  if(issharedfuncdefined("super_comm_scrambler", "init")) {
    [[getsharedfunc("super_comm_scrambler", "init")]]();
  }

  if(issharedfuncdefined("super_hb_sensor", "init")) {
    [[getsharedfunc("super_hb_sensor", "init")]]();
  }

  if(issharedfuncdefined("super_launcher", "init")) {
    [[getsharedfunc("super_launcher", "init")]]();
  }

  waittillframeend();
  scripts\mp\utility\spawn_event_aggregator::registeronplayerspawncallback(&super_onspawned);
  level.var_3e969a1cc0ad79cc = strtok(getDvar(@ "hash_51bbc6411bd93fea", ""), " ");
}

function function_4bdddfbb49e54102(var_511f1c7eaf0d2df7, initfunc) {
  if(!isDefined(level.var_db30cf1837ca94fd)) {
    level.var_db30cf1837ca94fd = [];
  }

  assertex(!isDefined(level.var_db30cf1837ca94fd[var_511f1c7eaf0d2df7]), "<dev string:x89>");
  level.var_db30cf1837ca94fd[var_511f1c7eaf0d2df7] = initfunc;
}

function function_f0327aead8f016e2(globals) {
  if(isDefined(level.gametypebundle)) {
    globals.var_2652b1ba218bbaf5 = istrue(level.gametypebundle.var_2652b1ba218bbaf5);
    globals.var_a33f6855d9867dbf = istrue(level.gametypebundle.var_a33f6855d9867dbf);
    globals.var_5b66ed80c98f795b = istrue(level.gametypebundle.var_5b66ed80c98f795b);
    return;
  }

  globals.var_2652b1ba218bbaf5 = 0;
  globals.var_a33f6855d9867dbf = 0;
  globals.var_5b66ed80c98f795b = 0;
}

function private initializesuper(var_511f1c7eaf0d2df7) {
  if(!isDefined(level.var_db30cf1837ca94fd)) {
    return;
  }

  initfunc = level.var_db30cf1837ca94fd[var_511f1c7eaf0d2df7];

  if(!isDefined(initfunc)) {
    return;
  }

  level[[initfunc]]();
}

function function_22bff45fcf920417(var_a5f886642fea5345) {
  assert(!isDefined(level.var_7de15b4c7f0a425));
  level.var_7de15b4c7f0a425 = [];
  level.var_a5f886642fea5345 = istrue(var_a5f886642fea5345);
}

function function_18a7c22094077fe9(var_db0176d05c1d9564) {
  var_db0176d05c1d9564 = default_to(var_db0176d05c1d9564, 96);
  var_7bfb992cee74d051 = 0.05 * var_db0176d05c1d9564 / 60;
  function_4d75a970580a253c(#"time", var_7bfb992cee74d051);
}

function function_4d75a970580a253c(eventref, points) {
  if(!isDefined(points)) {
    return;
  }

  assert(isxhash(eventref));
  assert(isDefined(level.var_7de15b4c7f0a425));

  if(level.var_a5f886642fea5345 && eventref != #"time") {
    return;
  }

  level.var_7de15b4c7f0a425[eventref] = points;
}

function registersupers() {
  if(getdvarint(@ "hash_742caa13b3c2e685")) {
    return;
  }

  function_53110a12409d01da("super_test", undefined, undefined, &testsuperbeginuse, undefined, undefined, undefined, undefined);
  function_53110a12409d01da("super_br_extract", undefined, undefined, &brcircleextract, undefined, undefined, undefined, undefined);
  function_53110a12409d01da("super_tac_cover", undefined, &taccoverunset, &taccoverbeginuse, undefined, undefined, undefined, undefined);
  function_53110a12409d01da("super_recon_drone", undefined, &recondroneunset, &recondronebeginuse, &recondroneenduse, &function_3529248aa2d81abc, undefined, undefined);
  function_53110a12409d01da("super_support_box", undefined, &supportboxunset, &stoppingpowerbeginuse, undefined, undefined, undefined, undefined);
  function_53110a12409d01da("super_trophy", &trophyonset, undefined, undefined, undefined, undefined, undefined, undefined);
  function_53110a12409d01da("super_scramble", undefined, undefined, &scramblebeginuse, &scrambleusefinished, undefined, undefined, undefined);
  function_53110a12409d01da("super_deadsilence", undefined, undefined, &deadsilencebeginuse, &deadsilenceenduse, undefined, undefined, undefined);
  function_53110a12409d01da("super_tac_insert", &tacinsertonset, &tacinsertonunset, undefined, undefined, undefined, undefined, undefined);
  function_53110a12409d01da("super_weapon_drop", undefined, undefined, &superweapondropbeginuse, undefined, undefined, undefined, undefined);
  function_53110a12409d01da("super_select", &superselectonset, &superselectonunset, &superselectbeginuse, undefined, undefined, &function_baf9eeef4cf2bac5, &function_fad6d78d6b3b3359);
  function_53110a12409d01da("super_fulton", undefined, undefined, &superfultonbeginuse, undefined, undefined, undefined, undefined);
  function_53110a12409d01da("super_supply_drop", undefined, undefined, &supersupplydropbeginuse, undefined, undefined, undefined, undefined);
  function_53110a12409d01da("super_tac_camera", &function_d1bd30be0c5ec282, &function_2ef8268013bdbe57, undefined, undefined, undefined, &function_dfc3421815005e62, &function_2b9e988cdb17f507);
  function_53110a12409d01da("super_recon_dart", &function_fad76ffce1bc5317, &function_af1d2e4473f5057e, undefined, undefined, undefined, undefined, undefined);
  function_53110a12409d01da("super_suppression_rounds", undefined, &suppressunset, &function_66c2b6fb2734cbae, undefined, undefined, undefined, undefined);
  function_53110a12409d01da("super_emp_pulse", undefined, &emppulseunset, &function_2de710d6b3c9388e, &function_ca449b017d946d26, undefined, &function_d93f331b74c647f2, undefined);
  function_53110a12409d01da("super_battlerage", undefined, undefined, &function_81a2df228546136e, &function_d1b35aa1689beb06, undefined, undefined, undefined);
  function_53110a12409d01da("super_stimpistol", &function_afd34c64e8c8d5d, &function_90a74a57a43c9808, &function_53025970eb68a86b, &function_fdfae98bcfbf8c7f, undefined, undefined, undefined);
  function_53110a12409d01da("super_smoke_airdrop", undefined, &function_2e14b99891ecbbf4, &function_14761663823dbcb7, undefined, undefined, undefined, undefined);
  function_53110a12409d01da("super_balloon_extract", undefined, undefined, &superfultonbeginuse, undefined, undefined, undefined, undefined);
  function_53110a12409d01da("super_loadout_drop", undefined, undefined, &function_8d6d142bceb819f2, undefined, undefined, undefined, undefined);
  function_53110a12409d01da("super_door_barricade", undefined, undefined, &function_9c38f7ea2223b47c, undefined, undefined, undefined, undefined);
  function_53110a12409d01da("super_deployed_decoy", undefined, &deployeddecoyunset, undefined, undefined, undefined, undefined, &function_25b1b1c8cae25c68);
  function_53110a12409d01da("super_oxygen_mask", undefined, undefined, &scripts\cp_mp\oxygenmask::give_oxygenmask, undefined, &function_e3c0d84aa4294ee9, undefined, undefined);
  function_53110a12409d01da("super_deployable_kiosk", undefined, undefined, &function_3bc4f06f06e9c62, undefined, undefined, undefined, undefined);
  function_53110a12409d01da("super_fulton", undefined, undefined, &superfultonbeginuse, undefined, undefined, undefined, undefined);
  function_53110a12409d01da("super_supply_drop", undefined, undefined, &supersupplydropbeginuse, undefined, undefined, undefined, undefined);
  function_53110a12409d01da("super_tac_camera", &function_d1bd30be0c5ec282, &function_2ef8268013bdbe57, undefined, undefined, undefined, &function_dfc3421815005e62, &function_2b9e988cdb17f507);
  function_53110a12409d01da("super_recon_dart", &function_fad76ffce1bc5317, &function_af1d2e4473f5057e, undefined, undefined, undefined, undefined, undefined);
  function_53110a12409d01da("super_suppression_rounds", undefined, &suppressunset, &function_66c2b6fb2734cbae, undefined, undefined, undefined, undefined);
  function_53110a12409d01da("super_emp_pulse", undefined, &emppulseunset, &function_2de710d6b3c9388e, &function_ca449b017d946d26, undefined, &function_d93f331b74c647f2, undefined);
  function_53110a12409d01da("super_battlerage", undefined, undefined, &function_81a2df228546136e, &function_d1b35aa1689beb06, undefined, undefined, undefined);
  function_53110a12409d01da("super_smoke_airdrop", undefined, &function_2e14b99891ecbbf4, &function_14761663823dbcb7, undefined, undefined, undefined, undefined);
  function_53110a12409d01da("super_balloon_extract", undefined, undefined, &superfultonbeginuse, undefined, undefined, undefined, undefined);
  function_53110a12409d01da("super_loadout_drop", undefined, undefined, &function_8d6d142bceb819f2, undefined, undefined, undefined, undefined);
  function_53110a12409d01da("super_honeypot", undefined, undefined, &function_b8e4c757481c3bf2, &function_20d973416d5e8d9a, undefined, undefined, undefined);
  function_53110a12409d01da("super_door_barricade", undefined, undefined, &function_9c38f7ea2223b47c, undefined, undefined, undefined, undefined);
  function_53110a12409d01da("super_deployed_decoy", undefined, &deployeddecoyunset, undefined, undefined, undefined, undefined, &function_25b1b1c8cae25c68);
  function_53110a12409d01da("super_laststand_syringe", undefined, undefined, &function_77a8296b67aa7a1c, &function_25ea1075448678c, undefined, undefined, undefined);
  function_53110a12409d01da("super_spykit", undefined, undefined, undefined, &function_e285dcf9693ca723, undefined, undefined, undefined);
  function_53110a12409d01da("super_vehicle_drop", undefined, undefined, &function_7eead274ef83e1b9, undefined, undefined, undefined, undefined);
  function_53110a12409d01da("super_high_jump", undefined, undefined, &function_f98d4ec41407bc75, &function_975965422d6bcb49, undefined, undefined, undefined);
  function_53110a12409d01da("super_teleport_deploy", undefined, undefined, &function_e9993ee767c0acf5, &function_ec715b4038ae47c9, undefined, undefined, undefined);
  function_53110a12409d01da("super_melee_jugg", undefined, undefined, &function_e67d9c8005d3f178, &function_13214dc30f36bf08, undefined, undefined, undefined);
  function_53110a12409d01da("super_hb_sensor", undefined, undefined, undefined, undefined, undefined, &function_6129eaac0c283bb7, &function_96042b357c338ada);
  function_53110a12409d01da("super_evg", undefined, &function_69e46ed9d65ec7e4, undefined, undefined, undefined, &function_63cb15591c54cb1, &function_971b383d95556418);

  if(isDefined(level.var_762c63041675c851)) {
    [[level.var_762c63041675c851]]();
  }

  registersuperextraweapon("super_emp_drone", "emp_drone_player_mp");
  registersuperextraweapon("super_emp_drone", "emp_drone_non_player_mp");
  registersuperextraweapon("super_emp_drone", "emp_drone_non_player_direct_mp");
  registersuperextraweapon("super_weapon_drop", "deploy_weapondrop_mp");
}

function function_53110a12409d01da(ref, setfunc, unsetfunc, beginusefunc, endusefunc, var_e0af69536a727f03, var_70b09ed29c10732f, var_1bb8c2de6198881a) {
  staticdata = level.superglobals.staticsuperdata[ref];

  if(!isDefined(staticdata)) {
    println("<dev string:xae>" + ref + "<dev string:xdb>" + level.supertable);
    return;
  }

  staticdata.setfunc = setfunc;
  staticdata.unsetfunc = unsetfunc;
  staticdata.beginusefunc = beginusefunc;
  staticdata.endusefunc = endusefunc;
  staticdata.var_e0af69536a727f03 = var_e0af69536a727f03;
  staticdata.var_70b09ed29c10732f = var_70b09ed29c10732f;
  staticdata.var_1bb8c2de6198881a = var_1bb8c2de6198881a;

  if(!isDefined(var_e0af69536a727f03) && istrue(staticdata.var_ff2e3a3658646a3f)) {
    staticdata.var_e0af69536a727f03 = &function_97eecce0124a7b50;
  }
}

function function_b11714522b76c040() {
  scripts\engine\utility::registersharedfunc("supers", "setSuperIsActive", &setsuperisactive);
  scripts\engine\utility::registersharedfunc("supers", "isUsingSuperWeapon", &isusingsuperweapon);
  scripts\engine\utility::registersharedfunc("supers", "superHasTimedUsage", &superhastimedusage);
  scripts\engine\utility::registersharedfunc("supers", "superHasAmmoUsage", &superhasammousage);
}

function registersuperextraweapon(ref, weapon) {
  if(!isstring(weapon)) {
    weapon = weapon.basename;
  }

  staticdata = level.superglobals.staticsuperdata[ref];

  if(!isDefined(staticdata)) {
    println("<dev string:x113>" + ref + "<dev string:x129>");
    return;
  }

  staticdata.extraweapons[staticdata.extraweapons.size] = weapon;
  level.superglobals.supersbyextraweapon[weapon] = staticdata;
}

function super_onspawned() {
  if(isDefined(self.super) && level.superglobals.var_2652b1ba218bbaf5) {
    givesuperpoints(getsuperpointsneeded(), undefined, 0);
    thread function_66cc363da0bf8520();
  }

  updatesuperuiprogress();
  updatesuperuistate();
  function_e20ab7a8971ee3f2();
}

function function_66cc363da0bf8520() {
  self endon("death_or_disconnect");
  level endon("game_ended");
  self notify("supers_watchingLoadoutchange");
  self endon("supers_watchingLoadoutChange");

  while(true) {
    self waittill("super_set");
    givesuperpoints(getsuperpointsneeded());
  }
}

function function_9d0de1f8996c57f8(superref) {
  self endon("death_or_disconnect");
  level endon("game_ended");
  waitframe();
  self setclientomnvar("ui_super_ref", superref);
}

function givesuper(superref, var_6c70bf5ad211f464, immediate, blueprintindex) {
  if(getdvarint(@ "hash_64156ad0392158e4") != 0) {
    return;
  }

  clearsuper(var_6c70bf5ad211f464, superref);
  assertex(!issuperinuse(), "<dev string:x163>");

  if(superref == "") {
    return;
  }

  staticdata = level.superglobals.staticsuperdata[superref];

  if(!isDefined(staticdata)) {
    assertmsg("<dev string:x1bb>" + superref + "<dev string:x1e5>" + level.supertable);
    return;
  }

  superinfo = spawnStruct();
  self.super = superinfo;
  superinfo.staticdata = staticdata;
  superinfo.allowrefund = 1;
  superinfo.numkills = 0;
  superinfo.wasrefunded = 0;
  superinfo.canstow = 0;
  superinfo.lifeid = scripts\cp_mp\utility\killstreak_utility::getcurrentplayerlifeidforkillstreak();
  superinfo.basepoints = 0;
  superinfo.extrapoints = 0;
  superinfo.usestarttime = undefined;
  superinfo.usepercent = 0;
  superinfo.overridepointsneeded = undefined;
  superinfo.var_2d439ede1c8ec8b9 = 0;
  superinfo.var_b0104dddec932264 = 0;
  superinfo.var_7da7aeb063e429ee = 1;
  superinfo.weaponobj = scripts\cp_mp\supers\supers::buildsuper(staticdata.weapon, blueprintindex);
  superinfo.blueprintindex = blueprintindex;
  function_ca3ed045947e9de0();
  function_1029081898b028c(0);
  setsuperisinuse(0);
  setsuperisactive(0);

  if(isDefined(superinfo.staticdata.useweapon)) {
    function_9aa5fdb675559e34();
  }

  superonset(superref);
  thread function_9d0de1f8996c57f8(superref);
  superbasepoints = self.pers["superBasePoints"];

  if(!isDefined(superbasepoints)) {
    superbasepoints = 0;
  }

  self.pers["superBasePoints"] = undefined;
  setsuperbasepoints(superbasepoints);
  superextrapoints = self.pers["superExtraPoints"];

  if(!isDefined(superextrapoints)) {
    superextrapoints = 0;
  }

  self.pers["superExtraPoints"] = undefined;
  setsuperextrapoints(superextrapoints);

  if(!isDefined(self.pers["superExpended"])) {
    setsuperexpended(0);
  }

  if(istrue(immediate)) {
    givesuperpoints(getsuperpointsneeded());

    if(getdvarint(@ "hash_16adc8396fb1019e", 1) != 0) {
      if(scripts\cp_mp\utility\game_utility::isbrstylegametype() && !scripts\mp\flags::gameflag("prematch_done")) {
        self.var_1066fbd86c88a6df = 1;
      }
    }

    superinfo.madeavailabletime = gettime();
    scripts\mp\analyticslog::logevent_superearned(superinfo.madeavailabletime);
  }

  _giveweapon(superinfo.weaponobj);
  ammo = ter_op(issuperready(), 1, 0);
  self setweaponammoclip(superinfo.weaponobj, ammo);
  firstupgrade = level.superglobals.staticsuperdata[scripts\mp\perks\perkpackage::perkpackage_getfirstfieldupgrade()];
  secondupgrade = level.superglobals.staticsuperdata[scripts\mp\perks\perkpackage::perkpackage_getsecondfieldupgrade()];
  var_4e7ea53a34c37fbe = "none";
  var_294b52d8009b81da = "none";

  if(isDefined(firstupgrade) && firstupgrade != staticdata) {
    var_4e7ea53a34c37fbe = firstupgrade.weapon;
  }

  if(isDefined(secondupgrade) && secondupgrade != staticdata) {
    var_294b52d8009b81da = secondupgrade.weapon;
  }

  self assignweaponoffhandspecial(superinfo.weaponobj, var_4e7ea53a34c37fbe, var_294b52d8009b81da);
  params = spawnStruct();
  params.player = self;
  params.superref = superref;
  callback::callback("equipped_super", params);
  thread watchforsuperusebegin();
  thread handlespectating();

  if(!scripts\cp_mp\utility\game_utility::isbrstylegametype() || level.allowsupers) {
    thread watchforrespawn();
    thread storesupercooldownforroundchange();
    thread handleteamchange();
  }
}

function handlesuperearnovertime() {
  level endon("game_ended");

  if(level.superglobals.var_a33f6855d9867dbf) {
    return;
  }

  if(!scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    scripts\mp\flags::gameflagwait("prematch_done");
  }

  starttime = gettime();
  waitframe();

  while(true) {
    if(istrue(level.var_d659494e95bd9496)) {
      starttime = gettime();
      waitframe();
      continue;
    }

    playercount = level.players.size;
    var_5c504378bde978e1 = (gettime() - starttime) / 50;

    if(var_5c504378bde978e1 < 11) {
      wait(11 - var_5c504378bde978e1) * 0.05;
      var_5c504378bde978e1 = 11;
    }

    starttime = gettime();
    allowsupers = istrue(level.allowsupers);
    startplayer = 0;

    while(startplayer < playercount) {
      for(updateindex = 0; updateindex < 15; updateindex++) {
        playerindex = startplayer + updateindex;
        player = level.players[playerindex];

        if(!isDefined(player)) {
          continue;
        }

        if(istrue(player.pausesuperpointsovertime)) {
          continue;
        }

        if(!(istrue(player.var_678855513f5076ca) || allowsupers || player function_868a75fd7c215c07())) {
          continue;
        }

        if(!isreallyalive(player)) {
          continue;
        }

        currentsuper = player getcurrentsuper();

        if(isDefined(currentsuper) && !currentsuper.isinuse) {
          player givesuperpoints(0, #"time", 0, var_5c504378bde978e1);
        }
      }

      waitframe();
      startplayer += 15;
    }

    waitframe();
  }
}

function function_50f445936b3ddd9e(var_d220971ffe40c601) {
  if(!isDefined(var_d220971ffe40c601)) {
    return 1;
  }

  if(!isDefined(self.perkpackagedata)) {
    return 1;
  }

  if(var_d220971ffe40c601 == "super_select") {
    return 0;
  }

  if(scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    if(self.perkpackagedata.firstupgrade == var_d220971ffe40c601) {
      return 0;
    } else {
      return 1;
    }
  }

  var_b4a8899a61e7eee9 = self.perkpackagedata.lastsuper;

  if(!isDefined(var_b4a8899a61e7eee9)) {
    return 1;
  }

  if(var_d220971ffe40c601 == var_b4a8899a61e7eee9) {
    return 1;
  }

  var_1647b158aa996cf8 = function_4b10d71720fc4a4(var_b4a8899a61e7eee9);
  var_327fc859a32ae60 = function_4b10d71720fc4a4(var_d220971ffe40c601);
  var_35b042c5224a1646 = function_d8f9e4158e12de6b();

  if(var_327fc859a32ae60) {
    if(!isDefined(var_35b042c5224a1646) || var_35b042c5224a1646 != var_d220971ffe40c601) {
      function_26f98b45fb791c0e();
    }

    superonunset(var_b4a8899a61e7eee9);
    return 1;
  }

  if(var_1647b158aa996cf8 && !var_327fc859a32ae60) {
    function_7abbee267d3aad2f(var_b4a8899a61e7eee9);
    return 0;
  }

  superonunset(var_b4a8899a61e7eee9);
  return 1;
}

function function_4b10d71720fc4a4(superref) {
  staticdata = level.superglobals.staticsuperdata[superref];

  if(!isDefined(staticdata)) {
    return false;
  }

  return istrue(staticdata.var_6af942bb3f913f9f);
}

function function_7abbee267d3aad2f(superref) {
  if(isDefined(self.var_35b042c5224a1646) && self.var_35b042c5224a1646 != superref) {
    function_26f98b45fb791c0e();
  }

  self.var_35b042c5224a1646 = superref;
}

function function_26f98b45fb791c0e() {
  if(!isDefined(self.var_35b042c5224a1646)) {
    return;
  }

  if(istrue(self.var_3a4fe3013eb35ea0)) {
    return;
  }

  staticdata = level.superglobals.staticsuperdata[self.var_35b042c5224a1646];
  unsetfunc = staticdata.unsetfunc;

  if(!isDefined(unsetfunc)) {
    return;
  }

  self thread[[unsetfunc]]();
  self.var_35b042c5224a1646 = undefined;
}

function function_d8f9e4158e12de6b() {
  return self.var_35b042c5224a1646;
}

function clearsuper(var_6c70bf5ad211f464, var_d220971ffe40c601, playerkilled) {
  superinfo = getcurrentsuper();
  var_fa91721e4a69c230 = scripts\mp\perks\perkfunctions::function_66f0cbd5ff8458fe();

  if(issuperinuse() && (istrue(superinfo.staticdata.persistondeath) || superhastimedusage() || isusingsuperweapon())) {
    superusefinished(0, istrue(playerkilled), 0, 0, 0, 1);
  }

  if(isDefined(superinfo) && isDefined(superinfo.staticdata)) {
    if(function_50f445936b3ddd9e(var_d220971ffe40c601)) {
      superonunset(superinfo.staticdata.ref);
    }
  }

  if(istrue(var_6c70bf5ad211f464) && isDefined(superinfo)) {
    storesuperpoints();
  }

  self clearoffhandspecial();

  if(isDefined(superinfo)) {
    _takeweapon(superinfo.weaponobj);
  }

  if(istrue(level.codcasterenabled) && !isagent(self)) {
    self setspecialactive(0);
  }

  self notify("remove_super");
  self.super = undefined;

  if(function_565913010c84ffca()) {
    function_c0fe8dee01b2adac(0);
  }

  if(scripts\cp_mp\utility\game_utility::isbrstylegametype() && !var_fa91721e4a69c230) {
    self.var_1066fbd86c88a6df = 0;
  }

  thread handlesuperuistatechange(0);
  thread function_93b5448ea8f6277b(0);
  self setclientomnvar("ui_super_second_progress", 0);
  self setclientomnvar("ui_super_ref", "none");
}

function superonset(superref) {
  if(!isDefined(superref)) {
    return;
  }

  if(superref == "none" || superref == "") {
    return;
  }

  staticdata = level.superglobals.staticsuperdata[superref];

  if(!isDefined(staticdata)) {
    return;
  }

  clientnum = self getentitynumber();
  namespace_f5675568ccc8acc6::function_f63556dc2aa67fdc(2, clientnum, undefined);

  if(isDefined(staticdata.var_e0af69536a727f03)) {
    self setclientomnvar("ui_block_fu_not_ready_error", 1);
  }

  self notify("super_set");
  setfunc = staticdata.setfunc;

  if(!isDefined(setfunc)) {
    return;
  }

  if(level.superglobals.var_2652b1ba218bbaf5) {
    givesuperpoints(getsuperpointsneeded(), undefined, 0);
  }

  self thread[[setfunc]]();
}

function superonunset(superref) {
  if(!isDefined(superref)) {
    return;
  }

  if(superref == "none" || superref == "") {
    return;
  }

  staticdata = level.superglobals.staticsuperdata[superref];

  if(!isDefined(staticdata)) {
    return;
  }

  if(isDefined(staticdata.var_e0af69536a727f03)) {
    self setclientomnvar("ui_block_fu_not_ready_error", 0);
  }

  self notify("unset_super");
  unsetfunc = staticdata.unsetfunc;

  if(!isDefined(unsetfunc)) {
    return;
  }

  self thread[[unsetfunc]]();
}

function function_6a13616c0032bf21() {
  setsuperbasepoints(scripts\mp\supers::getsuperpointsneeded(), 1);
  updatesuperuiprogress();
  updatesuperuistate();
  function_e20ab7a8971ee3f2();
  superinfo = getcurrentsuper();
  self setweaponammoclip(superinfo.weaponobj, 1);
}

function setsuperbasepoints(points, setonly, var_5e5d91e0ed56109e) {
  assert(isDefined(points));
  superinfo = getcurrentsuper();
  assertex(!superinfo.isinuse, "<dev string:x207>");
  superinfo.basepoints = clamp(points, 0, getsuperpointsneeded());

  if(istrue(setonly)) {
    return;
  }

  superpointschanged(var_5e5d91e0ed56109e);
}

function setsuperextrapoints(points, setonly) {
  assert(isDefined(points));
  superinfo = getcurrentsuper();
  assertex(!superinfo.isinuse, "<dev string:x241>");
  superinfo.extrapoints = clamp(points, 0, getsuperpointsneeded());

  if(istrue(setonly)) {
    return;
  }

  superpointschanged();
}

function function_8c7b1312cf5986b(points, setonly) {
  assert(isDefined(points));
  superinfo = getcurrentsuper();

  if(isDefined(self.overclockcharge) && scripts\mp\utility\perk::_hasperk("specialty_overcharge_field_upgrade")) {
    self.overclockcharge = clamp(points, 0, getsuperpointsneeded());

    if(!istrue(setonly)) {
      function_b3d636936ec98aa0(self.overclockcharge);
      function_e20ab7a8971ee3f2();
    }
  }
}

function superpointschanged(var_5e5d91e0ed56109e) {
  superinfo = getcurrentsuper();

  if(getcurrentsuperpoints() >= getsuperpointsneeded()) {
    superearned();
  } else if(!istrue(var_5e5d91e0ed56109e)) {
    self setweaponammoclip(superinfo.weaponobj, 0);
  }

  updatesuperuiprogress();
  updatesuperuistate();
  function_e20ab7a8971ee3f2();
}

function givesuperpoints(points, scoreevent, var_b4b593facaa83af7, pointsmultiplier, var_2569ec7d8016f67f, var_7601733fb3a9ae73) {
  var_74cc2858b7ac655f = function_868a75fd7c215c07();
  var_f2516e5f323caf9d = isDefined(self.var_678855513f5076ca) || var_74cc2858b7ac655f;

  if((istrue(game["isLaunchChunk"]) || !level.allowsupers) && !var_f2516e5f323caf9d) {
    return;
  }

  if(!scripts\mp\perks\perkfunctions::function_66f0cbd5ff8458fe()) {
    return;
  }

  assert(isDefined(points));

  if(getdvarint(@ "hash_eba0ef12e9c9260b", 0) && !istrue(var_b4b593facaa83af7)) {
    return;
  }

  var_11f1f4d158695f06 = isDefined(scoreevent) && scoreevent == #"time";

  if(var_74cc2858b7ac655f && var_11f1f4d158695f06) {
    superinfo = getcurrentsuper();
    points = superinfo.var_aa000a24012e5de2;
  } else if(isDefined(scoreevent)) {
    points = getsuperpointsforevent(scoreevent);
  }

  if(isDefined(pointsmultiplier)) {
    points *= pointsmultiplier;
  }

  if(scripts\mp\utility\perk::_hasperk("specialty_faster_field_upgrade") && !isDefined(var_2569ec7d8016f67f)) {
    if(isDefined(self.perktunables) && isnumber(self.perktunables.var_d7d948c55db143ae)) {
      points *= self.perktunables.var_d7d948c55db143ae;
    } else {
      points *= getdvarfloat(@ "hash_28e84932a9fb43fd");
    }
  }

  modifiedpoints = points;

  if(var_11f1f4d158695f06) {
    modifiedpoints = points * level.superfastchargerate;
  } else if(level.superglobals.var_2652b1ba218bbaf5) {
    modifiedpoints = points;
  } else if(!istrue(var_7601733fb3a9ae73)) {
    modifiedpoints = points * level.superpointsmod;
  }

  if(modifiedpoints <= 0) {
    return;
  }

  superinfo = getcurrentsuper();

  if(level.superglobals.var_2652b1ba218bbaf5) {
    superinfo.var_7d00742b258a5aad = 1;
    skiprefill = 0;
  } else {
    skiprefill = issuperready();
  }

  if(!istrue(var_7601733fb3a9ae73)) {
    if(!isDefined(superinfo) || skiprefill || superinfo.isinuse) {
      doovercharge = !scripts\cp_mp\utility\game_utility::isbrstylegametype() || istrue(self.var_514192f8282796c);

      if(isDefined(superinfo) && isDefined(self.overclockcharge) && scripts\mp\utility\perk::_hasperk("specialty_overcharge_field_upgrade") && doovercharge) {
        function_8c7b1312cf5986b(self.overclockcharge + modifiedpoints);
      }

      updatesppm(points, 0, scoreevent);
      return;
    }
  }

  newpointtotal = min(modifiedpoints + superinfo.basepoints, getsuperpointsneeded());
  setsuperbasepoints(newpointtotal);

  if(newpointtotal >= getsuperpointsneeded() && var_11f1f4d158695f06) {
    if(isDefined(superinfo) && isDefined(superinfo.staticdata) && isDefined(superinfo.staticdata.ref)) {
      if(issharedfuncdefined(superinfo.staticdata.ref, "onSuperRecharged")) {
        self[[getsharedfunc(superinfo.staticdata.ref, "onSuperRecharged")]]();
      }
    }
  }

  updatesppm(points, 1, scoreevent);
}

function function_e20ab7a8971ee3f2() {
  superinfo = getcurrentsuper();

  if(!isDefined(superinfo)) {
    return;
  }

  if(isinkillcam() || !isalive(self)) {
    self.var_6b4b4c0692f7bf67 = undefined;
    return;
  }

  if(!isDefined(self.var_491f93d0219d8d44)) {
    self.var_491f93d0219d8d44 = 1;
  }

  pointsneeded = getsuperpointsneeded();
  progress = 0;

  if(superinfo.isinuse) {
    progress = getsuperuseuiprogress();
  } else if(pointsneeded > 0) {
    progress = clamp(getcurrentsuperbasepoints() / pointsneeded, 0, 1);
  }

  var_f52e8a5add0f7ff8 = 0;

  if(isDefined(self.overclockcharge)) {
    if(pointsneeded > 0) {
      var_f52e8a5add0f7ff8 = clamp(self.overclockcharge / pointsneeded, 0, 1);
    }
  }

  if(self.var_491f93d0219d8d44 > 0) {
    var_9cf33e852e0e768a = progress + var_f52e8a5add0f7ff8;
    self setplayersupermeterprogress(var_9cf33e852e0e768a);
  }

  self.var_6b4b4c0692f7bf67 = self.var_491f93d0219d8d44;
}

function function_b3d636936ec98aa0(overclockprogress) {
  superinfo = getcurrentsuper();

  if(!isDefined(superinfo)) {
    return;
  }

  if(!isDefined(self.overclockcharge)) {
    return;
  }

  if(isinkillcam() || !isalive(self)) {
    self.var_2c0bf62a8db71fd0 = undefined;
    return;
  }

  pointsneeded = getsuperpointsneeded();
  progress = 0;

  if(pointsneeded > 0) {
    progress = clamp(overclockprogress / pointsneeded, 0, 1);
  }

  if(!isDefined(self.var_2c0bf62a8db71fd0) || progress != self.var_2c0bf62a8db71fd0) {
    self setclientomnvar("ui_super_second_progress", progress);
  }

  self.var_2c0bf62a8db71fd0 = progress;
}

function updatesuperuiprogress() {
  superinfo = getcurrentsuper();

  if(!isDefined(superinfo)) {
    return;
  }

  if(isinkillcam() || !isalive(self)) {
    superinfo.oldprogress = undefined;
    return;
  }

  progress = 0;

  if(superinfo.isinuse) {
    progress = getsuperuseuiprogress();
  } else {
    pointsneeded = getsuperpointsneeded();

    if(pointsneeded > 0) {
      progress = clamp(getcurrentsuperbasepoints() / pointsneeded, 0, 1);
    }
  }

  if(!isDefined(superinfo.oldprogress) || progress != superinfo.oldprogress) {
    thread function_93b5448ea8f6277b(progress);
  }

  superinfo.oldprogress = progress;
}

function handlesuperuistatechange(state) {
  self endon("disconnect");
  self endon("remove_super");
  level endon("game_ended");
  self notify("super_state_change");
  self endon("super_state_change");
  waittillframeend();
  self setclientomnvar("ui_super_state", state);
}

function function_93b5448ea8f6277b(progress) {
  self endon("disconnect");
  self endon("remove_super");
  level endon("game_ended");
  self notify("super_progress_change");
  self endon("super_progress_change");
  waittillframeend();
  self setclientomnvar("ui_super_progress", progress);
}

function updatesuperuistate() {
  superinfo = getcurrentsuper();

  if(!isDefined(superinfo)) {
    return;
  }

  if(!isDefined(superinfo.isactive)) {
    return;
  }

  if(isinkillcam() || !isalive(self)) {
    superinfo.state = undefined;
    return;
  }

  oldstate = superinfo.state;
  state = 1;

  if(issuperexpended()) {
    state = 4;
  } else if(issuperready()) {
    self setclientomnvar("ui_super_can_use", 1);
    state = 2;
  } else if(issuperinuse()) {
    state = 3;
  }

  if(!isDefined(oldstate) || state != oldstate) {
    if(state == 1) {
      self notify("super_use_charging");
    }

    thread handlesuperuistatechange(state);
  }

  superinfo.state = state;
}

function watchforrespawn() {
  superinfo = getcurrentsuper();
  self endon("disconnect");
  self endon("remove_super");

  while(true) {
    self waittill("spawned_player");
    givesuperweapon(superinfo);
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

  if(issuperinuse()) {
    waitframe();
  }

  thread clearsuper(1);
}

function handleteamchange() {
  self endon("disconnect");
  self endon("remove_super");
  oldteam = self.team;
  self waittill("joined_team");

  if(issuperinuse()) {
    waitframe();
  }

  if(self.team != oldteam) {
    self.currentfirstupgrade = undefined;
    thread clearsuper(1);
  }
}

function handlepointdecay() {
  self endon("disconnect");
  self endon("remove_super");
  level endon("game_ended");
  superinfo = getcurrentsuper();
  pointreduction = getdvarfloat(@ "hash_e1d7f49648b75f36", 6) * level.framedurationseconds;

  while(true) {
    if(!issupercharging()) {
      waitframe();
      continue;
    }

    points = max(superinfo.extrapoints - pointreduction, 0);
    setsuperextrapoints(points);
    waitframe();
  }
}

function superearned() {
  superinfo = getcurrentsuper();

  if(isDefined(superinfo) && isDefined(superinfo.blueprintindex) && istrue(superinfo.blueprintindex > 0) && isDefined(superinfo.staticdata) && isDefined(superinfo.staticdata.bundle) && isDefined(superinfo.staticdata.bundle.var_d96d3e6ceed581fd) && isDefined(superinfo.staticdata.bundle.var_d96d3e6ceed581fd.blueprints) && isDefined(superinfo.staticdata.bundle.var_d96d3e6ceed581fd.blueprints[superinfo.blueprintindex - 1])) {
    var_9b32d1936831f5aa = superinfo.staticdata.bundle.var_d96d3e6ceed581fd.blueprints[superinfo.blueprintindex - 1].genericblueprint;
    self function_53c61cc39f6a3b11(var_9b32d1936831f5aa);
  }

  self setweaponammoclip(superinfo.weaponobj, 1);
  wasearned = !superinfo.wasrefunded && !istrue(superinfo.var_7d00742b258a5aad);
  superinfo.var_7d00742b258a5aad = undefined;

  if(scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    self.var_1066fbd86c88a6df = 1;
  }

  var_bfce2b88ef4bc0fd = isDefined(superinfo.secondupgrade) && superinfo.secondupgrade != "none";
  self notify("super_ready", wasearned, var_bfce2b88ef4bc0fd);
  thread watchforsuperhold();

  if(isDefined(superinfo.staticdata.useweapon)) {
    function_9aa5fdb675559e34();
  }

  if(isDefined(superinfo.staticdata.var_70b09ed29c10732f)) {
    self thread[[superinfo.staticdata.var_70b09ed29c10732f]]();
  }

  if(wasearned) {
    self.pers["supersEarned"]++;
    self notify("super_earned");
    recordsuperearnedanalytics(superinfo);
  }

  superinfo.madeavailabletime = gettime();
  superinfo.numkills = 0;
  scripts\mp\analyticslog::logevent_superearned(superinfo.madeavailabletime);
  setsuperextrapoints(0, 1);
  setsuperbasepoints(getsuperpointsneeded(), 1);

  if(isDefined(self.matchdatalifeindex)) {
    scripts\mp\analyticslog::logevent_fieldupgradeearned(self, superinfo.staticdata.id);
  }
}

function watchforsuperusebegin() {
  self endon("disconnect");
  self endon("remove_super");

  while(true) {
    self waittill("special_weapon_fired", objweapon);
    var_113e50541adbc51f = trysuperusebegin(objweapon);

    if(!istrue(var_113e50541adbc51f)) {
      if(getdvarint(@ "hash_c8b6c4e40dcae41e", 1) == 1) {
        currentsuper = getcurrentsuper();

        if(isDefined(currentsuper) && isDefined(currentsuper.staticdata) && isDefined(currentsuper.weaponobj) && isDefined(objweapon) && objweapon.basename == currentsuper.weaponobj.basename) {
          refundsuper();
        }
      } else {
        refundsuper();
      }

      continue;
    }

    self waittill("super_use_finished");
  }
}

function watchforsuperhold() {
  self endon("disconnect");
  self endon("remove_super");
  self endon("super_use_finished");
  self notify("watchForSuperHold");
  self endon("watchForSuperHold");

  while(true) {
    superinfo = getcurrentsuper();

    if(isDefined(self.var_333e1986ecf511ba)) {
      self.var_333e1986ecf511ba = undefined;
    }

    self.var_333e1986ecf511ba = spawnStruct();
    childthread function_c1b1e5be45024c77(superinfo);
    waittill_any_3("weapon_switch_started", "perkPackage_endThink", "grenade_pullback");
    childthread function_bad0aa1c878da781();
    childthread function_45b568a3dc8beade();
    msg = waittill_any_return_2("superWeaponHoldFail", "superWeaponHoldSucceed");

    if(isDefined(msg) && msg == "superWeaponHoldSucceed") {
      if(isDefined(superinfo) && isDefined(superinfo.weaponobj)) {
        objweapon = superinfo.weaponobj;

        if(self superbuttonPressed() || istrue(self.var_333e1986ecf511ba.var_77c833f50a563d4e)) {
          if(isDefined(superinfo.staticdata.var_1bb8c2de6198881a)) {
            self thread[[superinfo.staticdata.var_1bb8c2de6198881a]](objweapon);
          }
        }
      }
    }
  }
}

function function_c1b1e5be45024c77(superinfo) {
  self endon("superHoldMonitoringOffhands");

  while(true) {
    self waittill("offhand_pullback", weapon);
    var_6cbf70934193b715 = 0;

    if(isDefined(superinfo) && isDefined(superinfo.staticdata) && isDefined(weapon.basename)) {
      var_7906bdc926143b34 = superinfo.weaponobj.basename;

      if(weapon.basename == var_7906bdc926143b34) {
        var_6cbf70934193b715 = 1;
      }
    }

    if(var_6cbf70934193b715) {
      self.var_333e1986ecf511ba.var_e8042a24357a2e1e = gettime();
      self.var_333e1986ecf511ba.objweapon = weapon;
    }

    waitframe();
  }
}

function function_45b568a3dc8beade() {
  waitframe();
  childthread function_f605d1759fb37327();
  childthread function_fabca6d2e89350c5();
  childthread function_6e3d8c7959967643();
  childthread function_be547df7936c91dd();
}

function function_be547df7936c91dd() {
  self waittill("superWeaponForceHoldSucceed");
  wait 0.3;
  self notify("superWeaponHoldSucceed");
}

function function_f605d1759fb37327() {
  self endon("superWeaponHoldFail");
  self endon("superWeaponHoldSucceed");
  self endon("superWeaponForceHoldSucceed");
  self waittill("weapon_change");
  self notify("superWeaponHoldFail");
}

function function_fabca6d2e89350c5() {
  self endon("superWeaponHoldFail");
  self endon("superWeaponHoldSucceed");
  self waittill("death");
  self notify("superWeaponHoldFail");
}

function function_6e3d8c7959967643() {
  self endon("superWeaponHoldFail");
  self endon("superWeaponForceHoldSucceed");
  self notify("superHoldMonitoringOffhands");
  objweapon = undefined;
  struct = self.var_333e1986ecf511ba;
  var_503d210471627672 = 0;

  if(isDefined(struct.var_e8042a24357a2e1e)) {
    if(gettime() - struct.var_e8042a24357a2e1e < 500) {
      objweapon = struct.objweapon;
      var_503d210471627672 = 1;
    }
  } else {
    self waittill("offhand_pullback", objweapon);
  }

  if(!isDefined(objweapon)) {
    self notify("superWeaponHoldFail");
    return;
  }

  var_4adc98643bc5e471 = 1;

  if(!isreallyalive(self)) {
    var_4adc98643bc5e471 = 0;
  }

  super = getcurrentsuper();

  if(isDefined(super) && objweapon.basename != super.weaponobj.basename) {
    var_4adc98643bc5e471 = 0;
  }

  if(!val::get("supers")) {
    var_4adc98643bc5e471 = 0;
  }

  if(var_4adc98643bc5e471) {
    if(var_503d210471627672) {
      waitframe();
      self notify("superWeaponForceHoldSucceed");
    } else {
      self notify("superWeaponHoldSucceed");
    }

    return;
  }

  self notify("superWeaponHoldFail");
}

function function_bad0aa1c878da781() {
  self notify("checkSuperButtonHeld");
  self endon("checkSuperButtonHeld");
  counter = 0;

  while(self superbuttonPressed()) {
    self setclientomnvar("ui_super_activation_button_held", 1);

    if(counter >= 0.75) {
      self.var_333e1986ecf511ba.var_77c833f50a563d4e = 1;
      break;
    }

    counter += level.framedurationseconds;
    waitframe();
  }

  self setclientomnvar("ui_super_activation_button_held", 0);
}

function trysuperusebegin(objweapon) {
  if(!isreallyalive(self)) {
    return 0;
  }

  if(self isinexecutionvictim()) {
    return 0;
  }

  if(objweapon.basename != getcurrentsuper().weaponobj.basename) {
    return 0;
  }

  if(!val::get("supers")) {
    return 0;
  }

  return beginsuperuse();
}

function beginsuperuse() {
  self endon("disconnect");
  superinfo = getcurrentsuper();
  self notify("super_started");
  scripts\mp\gamelogic::sethasdonecombat(self, 1);

  if(superinfo.weaponobj.basename == "support_box_mp") {
    self playlocalsound("iw9_support_box_bring_up_plr_1");
  } else if(superinfo.weaponobj.basename == "tempv_mp" && soundexists("iw9_mtx_tb_stim_activate_plr")) {
    self playsoundtoplayer("iw9_mtx_tb_stim_activate_plr", self);

    if(isDefined(self.team) && soundexists("iw9_mtx_tb_stim_activate_npc")) {
      self playsoundtoteam("iw9_mtx_tb_stim_activate_npc", self.team, self, self);
    }
  }

  var_ba41d234ae2de809 = isDefined(superinfo);
  superisinuse = var_ba41d234ae2de809 && istrue(superinfo.isinuse);
  var_f579d98fe982ce3e = var_ba41d234ae2de809 && isDefined(superinfo.staticdata) && istrue(superinfo.staticdata.var_f579d98fe982ce3e);
  params = spawnStruct();
  params.player = self;
  params.superinfo = superinfo;
  callback::callback("on_used_super", params);

  if(!superisinuse && !var_f579d98fe982ce3e) {
    laststanduse = !istrue(self.inlaststand) || istrue(superinfo.staticdata.canuseinlaststand);
    var_c34782e615981851 = scripts\mp\perks\perkpackage::function_3f7b66d60199a6a6();
    function_c0fe8dee01b2adac(1);
    var_1338411613704f7a = 1;

    if(isDefined(superinfo.staticdata.useweapon)) {
      if(scripts\mp\arbitrary_up::isinarbitraryup() && superdisabledinarbitraryup(superinfo.staticdata.ref)) {
        superdisabledinarbitraryupmessage();
        var_1338411613704f7a = 0;
      } else if(!laststanduse) {
        var_1338411613704f7a = 0;
      } else {
        clipammo = superinfo.staticdata.useweaponclipammo;
        stockammo = superinfo.staticdata.useweaponstockammo;

        if(isDefined(superinfo.var_2ebcbd70919376a7)) {
          clipammo = superinfo.var_2ebcbd70919376a7.clipammo;
          stockammo = superinfo.var_2ebcbd70919376a7.stockammo;
        }

        if(var_c34782e615981851) {
          clipammo = self.perkpackagedata.weaponclipammo[superinfo.staticdata.ref];
          stockammo = self.perkpackagedata.weaponstockammo[superinfo.staticdata.ref];
          self.super.var_3d2b63c4e181029d = clipammo;
          self.super.var_b9ef26fa33686273 = stockammo;
        }

        var_1338411613704f7a = trygiveuseweapon(superinfo.staticdata.useweapon, clipammo, stockammo);
      }
    }

    if(istrue(var_1338411613704f7a) && istrue(laststanduse)) {
      printgameaction("super use started - " + superinfo.staticdata.ref, self);

      if(!isDefined(superinfo.staticdata.beginusefunc) || istrue(self[[superinfo.staticdata.beginusefunc]]())) {
        function_c0fe8dee01b2adac(0);
        var_612c93cfb9f62839 = [];
        var_612c93cfb9f62839[0] = "super_use_finished_lb";
        var_612c93cfb9f62839[1] = "super_switched";
        setsuperbasepoints(0);
        setsuperextrapoints(0);
        setsuperisinuse(1);
        setsuperisactive(1);

        if(scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
          self.var_1066fbd86c88a6df = 0;
        }

        superinfo.allowrefund = ter_op(superinfo.staticdata.graceperiod > 0, 1, 0);
        superinfo.usestarttime = gettime();
        superinfo.usepercent = 1;
        self notify("super_use_started");
        thread function_15fe9c03174d698d();
        function_ea2a406d00e424f2();

        if(isDefined(self.matchdatalifeindex)) {
          scripts\mp\analyticslog::logevent_fieldupgradeactivated(self, superinfo.staticdata.id);
        }

        combatrecordsuperuse(superinfo.staticdata.ref);

        if(istrue(level.codcasterenabled)) {
          self setspecialactive(1);
          clientnum = self getentitynumber();
          namespace_f5675568ccc8acc6::function_f63556dc2aa67fdc(3, clientnum, undefined);
        }

        if(isDefined(self.var_d0c1f5bbf172f9d9)) {
          self.var_d0c1f5bbf172f9d9 = undefined;
        }

        if(isDefined(superinfo.staticdata.bundle.var_a2d48adbe4702769)) {
          level thread battlechatter_mp::trysaylocalsound(self, superinfo.staticdata.bundle.var_a2d48adbe4702769);
        }

        return true;
      } else {
        setsuperbasepoints(0);
        setsuperextrapoints(0);
        refundsuper();
        function_c0fe8dee01b2adac(0);
        return false;
      }
    } else {
      if(isDefined(superinfo.staticdata.useweapon) && istrue(var_1338411613704f7a)) {
        thread switchandtakesuperuseweapon();
      }

      if(!istrue(var_1338411613704f7a)) {
        function_c0fe8dee01b2adac(0);
        setsuperbasepoints(0);
        setsuperextrapoints(0);
        setsuperisinuse(1);
        superusefinished(1);
      }
    }

    if(function_565913010c84ffca()) {
      function_c0fe8dee01b2adac(0);
    }
  }

  return false;
}

function function_ea2a406d00e424f2() {
  superinfo = getcurrentsuper();
  assertex(isDefined(superinfo.staticdata.var_5c8e66e22b288b33), "<dev string:x27c>");
  var_5c8e66e22b288b33 = superinfo.staticdata.var_5c8e66e22b288b33;

  if(var_5c8e66e22b288b33 == "ONUSE" || var_5c8e66e22b288b33 == "TIME") {
    thread updateusetimedecay();
    return;
  }

  if(var_5c8e66e22b288b33 == "AMMO") {
    thread function_c4c44e009d4f4c6b();
    return;
  }

  return;
}

function activatesuper(altmode, var_1e71e1f458960b93) {
  superinfo = getcurrentsuper();

  if(!isDefined(altmode)) {
    altmode = 0;
  }

  assertex(superinfo.isinuse, "<dev string:x2e1>");

  if(altmode && isDefined(superinfo.staticdata.activatepenaltyalt)) {
    reducesuperusepercent(superinfo.staticdata.activatepenaltyalt, var_1e71e1f458960b93);
  } else if(isDefined(superinfo.staticdata.activatepenalty)) {
    reducesuperusepercent(superinfo.staticdata.activatepenalty, var_1e71e1f458960b93);
  }

  return true;
}

function function_15fe9c03174d698d() {
  self endon("disconnect");
  self endon("game_ended");
  self endon("super_use_finished");
  superinfo = getcurrentsuper();

  if(!isDefined(superinfo.staticdata.usetime)) {
    return;
  }

  while(true) {
    waitframe();
    success = 0;

    if(isbot(self)) {
      return;
    }

    success = function_49983afe0a8eb2b1();

    if(!success) {
      continue;
    }

    if(!issuperinuse()) {
      continue;
    }

    if(function_c3479770ffec05e2()) {
      continue;
    }

    repeatresult = function_ada5045140ee0fdf();

    if(!istrue(repeatresult)) {
      if(issharedfuncdefined("hud", "showErrorMessage")) {
        self[[getsharedfunc("hud", "showErrorMessage")]]("MP/SUPERS_UNAVAILABLE");
      }
    }
  }
}

function function_49983afe0a8eb2b1() {
  childthread function_c4c39359ee1fdecb();
  childthread function_e440752fbbed0dd5();
  childthread function_885e7d0266b391ee();
  self waittill("superRepeatUse", msg);
  self notifyonplayercommandremove("tacButtonPress", "+smoke");
  self notifyonplayercommandremove("tacButtonPress", "+actionslot 1");
  self notifyonplayercommandremove("fragButtonPress", "+frag");
  self notifyonplayercommandremove("fragButtonPress", "+equip_toggle_throw");
  self notifyonplayercommandremove("repeatUseActivate", "+special");
  return msg == "success";
}

function function_c4c39359ee1fdecb() {
  self endon("superRepeatUse");
  self notifyonplayercommand("repeatUseActivate", "+special");
  self waittill("repeatUseActivate");
  self notify("superRepeatUse", "success");
}

function function_e440752fbbed0dd5() {
  self endon("superRepeatUse");
  self notifyonplayercommand("tacButtonPress", "+smoke");
  self notifyonplayercommand("fragButtonPress", "+frag");
  var_bd1267e9dea3dba9 = ["tacButtonPress", "fragButtonPress"];
  thread function_8d6d95114b2c9b0d(var_bd1267e9dea3dba9, ["superRepeatUse"], 0.75);
  self waittill("controllerSuperPress", msg);
  self notify("superRepeatUse", msg);
}

function function_885e7d0266b391ee() {
  self endon("superRepeatUse");
  self notifyonplayercommand("tacButtonPress", "+actionslot 1");
  self notifyonplayercommand("fragButtonPress", "+equip_toggle_throw");
  var_bd1267e9dea3dba9 = ["tacButtonPress", "fragButtonPress"];
  thread function_8d6d95114b2c9b0d(var_bd1267e9dea3dba9, ["superRepeatUse"], 0.75);
  self waittill("controllerSuperPress", msg);
  self notify("superRepeatUse", msg);
}

function function_8d6d95114b2c9b0d(var_cf95e74ffd3666c0, var_ad02f85b88a0b345, time) {
  level endon("game_ended");
  ent = spawnStruct();
  ent.threads = 0;

  foreach(endonnotify in var_ad02f85b88a0b345) {
    self endon(endonnotify);
  }

  foreach(stringnotify in var_cf95e74ffd3666c0) {
    childthread waittill_string_no_endon_death(stringnotify, ent);
    ent.threads++;
  }

  while(ent.threads) {
    if(ent.threads == 1) {
      if(isDefined(time)) {
        ent childthread timeout_struct(time);
        ent waittill("returned", msg);

        if(msg == "timeout") {
          self notify("controllerSuperPress", "timeout");
        } else {
          self notify("controllerSuperPress", "success");
        }

        ent.threads--;
      }

      continue;
    }

    ent waittill("returned", message);
    ent.threads--;
  }

  ent notify("die");
}

function function_ada5045140ee0fdf() {
  if(!isreallyalive(self)) {
    return 0;
  }

  if(!val::get("supers")) {
    return 0;
  }

  if(isusingremote()) {
    return 0;
  }

  if(istrue(self.oob)) {
    return 0;
  }

  if(self isonladder()) {
    return 0;
  }

  if(self ismantling()) {
    return 0;
  }

  if(!self isonground()) {
    if(self isparachuting() || self isinfreefall()) {
      return 0;
    }
  }

  superinfo = getcurrentsuper();
  repeatresult = 0;

  if(isDefined(superinfo.staticdata.var_e0af69536a727f03)) {
    repeatresult = [[superinfo.staticdata.var_e0af69536a727f03]]();
  }

  return repeatresult;
}

function function_c4c44e009d4f4c6b() {
  self endon("disconnect");
  self endon("game_ended");
  self endon("super_use_finished");
  self endon("unset_super");
  superinfo = getcurrentsuper();
  usinguseweapon = isDefined(superinfo.staticdata.useweapon);
  useweaponclipammo = superinfo.staticdata.useweaponclipammo;
  var_cca155763701359 = superinfo.staticdata.weaponammo;

  if((!usinguseweapon || useweaponclipammo < 1) && var_cca155763701359 <= 1) {
    return;
  }

  weaponnotify = "weapon_fired";

  if(!usinguseweapon) {
    weaponnotify = "offhand_fired";
  }

  var_354f8655b711b4b1 = ter_op(usinguseweapon, superinfo.staticdata.useweapon, superinfo.weaponobj);

  if(istrue(superinfo.staticdata.var_ff2e3a3658646a3f)) {
    allowsuperweaponstow();
  }

  var_569d925e5a25df1 = function_395a9cb3ebe25d55(superinfo);
  bulletsfired = scripts\mp\supers::function_45c01cf6ebb2ba62();
  thread function_a4496878854ae85b(superinfo.staticdata.useweapon, var_354f8655b711b4b1, var_569d925e5a25df1 * bulletsfired + 0.001);

  while(true) {
    self waittill(weaponnotify, firedweapon);
    thread function_a4496878854ae85b(firedweapon, var_354f8655b711b4b1, var_569d925e5a25df1);
  }
}

function function_a4496878854ae85b(firedweapon, superweapon, percentreduced) {
  superinfo = getcurrentsuper();

  if(!isDefined(superweapon)) {
    if(!isDefined(superinfo) || !isDefined(superinfo.staticdata)) {
      return;
    }

    superweapon = ter_op(isDefined(superinfo.staticdata.useweapon), superinfo.staticdata.useweapon, superinfo.weaponobj);
  }

  issameweapon = 0;

  if(isweapon(firedweapon)) {
    firedweapon = firedweapon.basename;
  }

  if(isweapon(superweapon)) {
    superweapon = superweapon.basename;
  }

  if(firedweapon == superweapon) {
    function_22e13024dc2774e9();
    reducesuperusepercent(percentreduced);
    updatesuperuiprogress();
    updatesuperuistate();
    function_e20ab7a8971ee3f2();
  }
}

function function_45c01cf6ebb2ba62() {
  ammo = function_3889d69492a93008();
  maxammo = getcurrentsuper().staticdata.useweaponstockammo + getcurrentsuper().staticdata.useweaponclipammo;
  ammoused = maxammo - ammo;
  return ammoused;
}

function function_9aa5fdb675559e34() {
  superinfo = getcurrentsuper();

  if(!isDefined(self.super.var_2ebcbd70919376a7)) {
    superinfo.var_2ebcbd70919376a7 = spawnStruct();
  }

  superinfo.var_2ebcbd70919376a7.clipammo = superinfo.staticdata.useweaponclipammo;
  superinfo.var_2ebcbd70919376a7.stockammo = superinfo.staticdata.useweaponstockammo;
}

function function_60e9ab8c0ad6a01c(ammo, type) {
  superinfo = getcurrentsuper();

  if(!isDefined(superinfo)) {
    return;
  }

  if(issharedfuncdefined(superinfo.staticdata.ref, "setAmmo")) {
    self[[getsharedfunc(superinfo.staticdata.ref, "setAmmo")]](ammo);
  }

  ammostruct = superinfo.var_2ebcbd70919376a7;

  if(!isDefined(ammostruct)) {
    return;
  }

  useweapon = superinfo.staticdata.useweapon;

  if(!isDefined(useweapon)) {
    return;
  }

  if(!isDefined(type)) {
    type = "all";
  }

  maxclipammo = weaponclipsize(useweapon);
  remainder = 0;

  if(type == "clip" || type == "all") {
    if(ammo > maxclipammo) {
      remainder = ammo - maxclipammo;
      ammo = maxclipammo;
    }

    ammostruct.clipammo = ammo;
  }

  if(type == "stock") {
    ammostruct.stockammo = ammo;
    return;
  }

  if(type == "clip") {
    ammostruct.stockammo += remainder;
    return;
  }

  if(type == "all") {
    ammostruct.stockammo = remainder;
    return;
  }

  assertex(0, "<dev string:x327>");
}

function isusingsuperweapon() {
  if(!isDefined(self.super)) {
    return false;
  }

  hasammostruct = isDefined(self.super.var_2ebcbd70919376a7);
  hasammocallbacks = isDefined(self.super.staticdata) && issharedfuncdefined(self.super.staticdata.ref, "getAmmo") && issharedfuncdefined(self.super.staticdata.ref, "setAmmo");
  return hasammostruct || hasammocallbacks;
}

function function_c2432256b64355ce() {
  superinfo = getcurrentsuper();

  if(!isDefined(superinfo)) {
    return 0;
  }

  ammostruct = superinfo.var_2ebcbd70919376a7;

  if(!isDefined(ammostruct)) {
    return 0;
  }

  return ammostruct.clipammo;
}

function function_1f4b9f3ad4696db6() {
  superinfo = getcurrentsuper();

  if(!isDefined(superinfo)) {
    return 0;
  }

  ammostruct = superinfo.var_2ebcbd70919376a7;

  if(!isDefined(ammostruct)) {
    return 0;
  }

  return ammostruct.stockammo;
}

function function_3889d69492a93008() {
  superinfo = getcurrentsuper();

  if(!isDefined(superinfo)) {
    return 0;
  }

  if(isDefined(superinfo.staticdata) && issharedfuncdefined(superinfo.staticdata.ref, "getAmmo")) {
    return self[[getsharedfunc(superinfo.staticdata.ref, "getAmmo")]]();
  }

  ammostruct = superinfo.var_2ebcbd70919376a7;

  if(!isDefined(ammostruct)) {
    return 0;
  }

  return ammostruct.stockammo + ammostruct.clipammo;
}

function function_36246fa2b22036ab() {
  superinfo = getcurrentsuper();

  if(!isDefined(superinfo)) {
    return;
  }

  superinfo.var_2ebcbd70919376a7 = undefined;
}

function function_22e13024dc2774e9() {
  superinfo = getcurrentsuper();
  useweapon = superinfo.staticdata.useweapon;

  if(!isDefined(useweapon)) {
    return;
  }

  clipammo = self getweaponammoclip(useweapon);
  stockammo = self getweaponammostock(useweapon);
  function_60e9ab8c0ad6a01c(clipammo + stockammo, "all");
}

function updateusetimedecay() {
  self endon("disconnect");
  self endon("game_ended");
  self endon("super_use_finished");
  self endon("unset_super");
  superinfo = getcurrentsuper();

  if(!isDefined(superinfo.staticdata.usetime) || superinfo.staticdata.usetime == 0) {
    waitframe();
    superusefinished();
    return;
  }

  if(superinfo.staticdata.usetime < 0) {
    return;
  }

  while(true) {
    waitframe();

    if(isDefined(superinfo.staticdata.usedelay)) {
      usedtime = gettime() - superinfo.usestarttime;

      if(usedtime < superinfo.staticdata.usedelay) {
        continue;
      }
    }

    percentreduction = level.framedurationseconds / superinfo.staticdata.usetime;

    if(function_43ec2fc7986c3310()) {
      percentreduction = 0;
    }

    var_c047144a8d9939fe = function_415ab9351849fba8(superinfo) / superinfo.staticdata.usetime;
    reducesuperusepercent(percentreduction - var_c047144a8d9939fe);
    updatesuperuiprogress();
    updatesuperuistate();
    function_e20ab7a8971ee3f2();
  }
}

function reducesuperusepercent(percentoff, var_1e71e1f458960b93, var_80bd4dd71b59356b) {
  superinfo = getcurrentsuper();
  assertex(superinfo.isinuse, "<dev string:x37b>");
  superinfo.usepercent = clamp(superinfo.usepercent - percentoff, 0, 1);

  if(istrue(var_1e71e1f458960b93)) {
    superinfo.allowrefund = 0;
  }

  if(!isDefined(var_80bd4dd71b59356b) || var_80bd4dd71b59356b == 0) {
    superusedurationupdated();
  }
}

function function_a2a1403d5924109(percentage) {
  superinfo = getcurrentsuper();
  var_b4588f310900dba5 = superinfo.usepercent + percentage;
  superinfo.usepercent = clamp(var_b4588f310900dba5, 0, 1);
  return var_b4588f310900dba5;
}

function function_7c67c8e12db38300(seconds) {
  superinfo = getcurrentsuper();
  maxseconds = superinfo.staticdata.usetime;

  if(!isDefined(seconds)) {
    return 0;
  }

  if(seconds <= 0) {
    return 0;
  }

  if(seconds > maxseconds) {
    seconds = maxseconds;
  }

  percentage = 0;

  if(maxseconds > 0) {
    percentage = seconds / maxseconds;
  }

  function_a2a1403d5924109(percentage);
}

function resetsuperusepercent() {
  superinfo = getcurrentsuper();
  assertex(superinfo.isinuse, "<dev string:x3bc>");
  superinfo.usepercent = 1;
  superusedurationupdated();
}

function superusedurationupdated() {
  superinfo = getcurrentsuper();

  if(superinfo.usepercent <= 0) {
    superusefinished();
  }
}

function superusefinished(var_3179afaa208defa2, fromdeath, var_e68637fb8c1c346b, var_e743a22765d93795, attacker, fromclear) {
  superinfo = getcurrentsuper();
  self notify("super_use_finished_lb");
  clientnum = self getentitynumber();
  namespace_f5675568ccc8acc6::function_f63556dc2aa67fdc(4, clientnum, undefined);

  if(isDefined(superinfo)) {
    shouldrefund = 0;

    if(!istrue(var_3179afaa208defa2) && !istrue(var_e743a22765d93795)) {
      shouldrefund = shouldrefundsuper();
    }

    setsuperisinuse(0);
    setsuperisactive(0);
    superinfo.canstow = 0;
    var_e2c5bb15593b4812 = undefined;

    if(isDefined(superinfo.staticdata.endusefunc)) {
      if(!isDefined(fromdeath)) {
        fromdeath = 0;
      }

      var_e2c5bb15593b4812 = self[[superinfo.staticdata.endusefunc]](fromdeath, attacker);
    }

    if(shouldrefund || istrue(var_3179afaa208defa2) || istrue(var_e2c5bb15593b4812)) {
      setsuperexpended(0);
      refundsuper();
    } else if(istrue(var_e68637fb8c1c346b)) {
      setsuperexpended(0);
      var_8f0a7c929337d710 = getsuperpointsneeded() * superinfo.usepercent;
      superinfo.wasrefunded = 1;
      setsuperbasepoints(var_8f0a7c929337d710);
    } else if(function_868a75fd7c215c07()) {
      setsuperexpended(0);
      setsuperbasepoints(0);
      superinfo.lastfinishtime = gettime();
      superinfo.wasrefunded = 0;
    } else if(istrue(self.var_678855513f5076ca) && scripts\mp\perks\perkfunctions::function_66f0cbd5ff8458fe() || !istrue(self.var_678855513f5076ca) && isDefined(self.overclockcharge) && scripts\mp\utility\perk::_hasperk("specialty_overcharge_field_upgrade")) {
      setsuperexpended(0);
      setsuperbasepoints(self.overclockcharge);
      function_8c7b1312cf5986b(0);
      superinfo.lastfinishtime = gettime();
      superinfo.wasrefunded = 0;
    } else if(!istrue(fromclear)) {
      thread function_e648b6fc93bbc0e0();
      superinfo.lastfinishtime = gettime();
      superinfo.wasrefunded = 0;
    }

    thread switchandtakesuperuseweapon(1, 1);

    if(scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
      if(!level.allowsupers && !isDefined(self.var_678855513f5076ca) && !function_868a75fd7c215c07()) {
        if(!istrue(var_3179afaa208defa2)) {
          self setclientomnvar("ui_perk_package_state", 0);
          thread function_93b5448ea8f6277b(0);
          namespace_a38a2e1fe7519183::function_351fe4ac57ca37e5(self, "super");
          self.var_1066fbd86c88a6df = 0;

          if(function_f95bcca44e8cba53(superinfo.staticdata.ref)) {
            scripts\mp\supers::clearsuper();
          }
        }
      } else if(isDefined(superinfo.staticdata.brsingleuse) || function_f95bcca44e8cba53(superinfo.staticdata.ref)) {
        scripts\mp\supers::clearsuper();
        thread function_93b5448ea8f6277b(0);
        thread handlesuperuistatechange(0);
      }
    }

    if(isDefined(superinfo.blueprintindex) && superinfo.blueprintindex > 0 && isDefined(superinfo.staticdata.bundle.var_d96d3e6ceed581fd.blueprints) && isDefined(superinfo.staticdata.bundle.var_d96d3e6ceed581fd.blueprints[superinfo.blueprintindex - 1])) {
      var_9b32d1936831f5aa = superinfo.staticdata.bundle.var_d96d3e6ceed581fd.blueprints[superinfo.blueprintindex - 1].genericblueprint;
      self function_9bc014e7042e8339(var_9b32d1936831f5aa);
    }

    if(isDefined(superinfo.usestarttime) && isDefined(superinfo.madeavailabletime)) {
      timedifference = superinfo.usestarttime - superinfo.madeavailabletime;
      scripts\mp\analyticslog::logevent_superended(superinfo.staticdata.ref, timedifference, 0, superinfo.numkills);
    }

    printgameaction("super use ended - " + superinfo.staticdata.ref, self);
  }

  if(istrue(level.codcasterenabled)) {
    self setspecialactive(0);
  }

  level.var_44c84134585ab85b = 1;
  callback::callback("on_super_use_finished", superinfo);
  thread br_superrestockwatch(superinfo.staticdata.ref);
  self notify("super_use_finished");
}

function br_superrestockwatch(superref) {
  if(!scripts\cp_mp\utility\game_utility::isbrstylegametype() || function_868a75fd7c215c07()) {
    return;
  }

  if(!isDefined(level.superglobals) || !istrue(level.superglobals.var_6fbfc62ab2f01ec7)) {
    return;
  }

  if(level.superglobals.staticsuperdata[superref].var_202e9663db810505) {
    return;
  }

  player = self;
  player endon("br_pickup_super");
  player endon("death_or_disconnect");
  level endon("game_ended");
  player notify("br_superRestockWatch");
  player endon("br_superRestockWatch");
  player waittill("super_use_finished");

  if(level.superglobals.var_9c670f8da841bf77 >= 0 && superref == "super_tac_camera") {
    result = player waittill_any_timeout_1(level.superglobals.var_9c670f8da841bf77, "tacticalCamera_camera_spawned");

    for(var_ab3410c734591ca9 = 0; !var_ab3410c734591ca9; var_ab3410c734591ca9 = 1) {
      level waittill("tacticalCamera_camera_removed", camera, cameraindex);

      if(!isDefined(player)) {
        return;
      }

      if(camera.owner == player) {}
    }
  }

  wait 0.5;

  if(superref == "super_reinforcement_flare") {
    while(isDefined(player) && player isthrowinggrenade()) {
      waitframe();
    }
  }

  if(superref == "super_deployed_decoy") {
    player waittill("super_deployedDecoy_deleted");
  }

  player thread function_ea7187bdba6dff15(superref);
}

function function_e648b6fc93bbc0e0() {
  level endon("game_ended");
  self endon("disconnect");
  setsuperexpended(1);
  waitframe();
  setsuperexpended(0);
}

function refundsuper() {
  if(scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    if(isDefined(self.equipment["super"])) {
      scripts\mp\gametypes\br_pickups::function_1615eaec0c470f4f(self.equipment["super"], self.super.staticdata.ref);
    }

    return;
  }

  superinfo = getcurrentsuper();

  if(superinfo.isinuse) {
    superusefinished(1);
  }

  if(isDefined(superinfo)) {
    self.super.wasrefunded = 1;

    if(superinfo.isinuse) {
      superusefinished(0);
    }

    givesuperpoints(getsuperpointsneeded(), undefined, undefined, undefined, undefined, 1);
    self setweaponammoclip(superinfo.weaponobj, 1);
  }
}

function handledeath(attacker) {
  self endon("disconnect");

  if(!issuperinuse()) {
    return;
  }

  superinfo = getcurrentsuper();
  var_3179afaa208defa2 = superinfo.staticdata.refundondeath;
  persistondeath = superinfo.staticdata.persistondeath;

  if(!istrue(persistondeath)) {
    superusefinished(var_3179afaa208defa2, 1, undefined, undefined, attacker);
  }
}

function monitoruseweaponfiring(var_354f8655b711b4b1) {
  self endon("death_or_disconnect");
  self endon("super_use_finished");
  self endon("remove_super");

  while(true) {
    self waittill("weapon_fired", objweapon);

    if(issameweapon(objweapon, var_354f8655b711b4b1, 1)) {}
  }
}

function trygiveuseweapon(useweapon, clipammo, stockammo) {
  self endon("death_or_disconnect");
  _giveweapon(useweapon);

  if(!isDefined(clipammo)) {
    clipammo = function_c2432256b64355ce();
  }

  if(!isDefined(stockammo)) {
    stockammo = function_1f4b9f3ad4696db6();
  }

  if(clipammo + stockammo == 0) {
    return false;
  }

  self setweaponammoclip(useweapon, clipammo);
  self setweaponammostock(useweapon, stockammo);
  switchresult = domonitoredweaponswitch(useweapon, isbot(self));

  if(switchresult) {
    thread function_573f49bb5d5a86ea(useweapon);
    function_22e13024dc2774e9();
    return true;
  }

  abortmonitoredweaponswitch(useweapon);
  return false;
}

function manageuseweapon(useweapon) {
  self endon("death_or_disconnect");
  self endon("super_use_finished");
  superinfo = getcurrentsuper();
  superinfo.useweaponswapped = undefined;
  var_9de0ea5672c044fc = 0;

  while(true) {
    weapon = self getcurrentweapon();

    if(!istrue(superinfo.canstow) && !issameweapon(useweapon, weapon, 1)) {
      if(weapon.basename == "iw7_uplinkball_mp" || weapon.basename == "iw7_tdefball_mp") {
        var_9de0ea5672c044fc = 1;
      }

      break;
    }

    waitframe();
  }

  if(issuperinuse()) {
    superinfo.useweaponswapped = 1;
    superusefinished(undefined, undefined, var_9de0ea5672c044fc);
  }
}

function function_ff3b77706565dacf(useweapon, newweapon) {
  if(!issameweapon(useweapon, newweapon, 1) && newweapon.basename != "iw9_knifestab_mp" && newweapon.basename != "iw9_lm_dblmg_execution_mp" && newweapon.basename != "iw9_gunless" && newweapon.basename != "none") {
    return 1;
  }

  return 0;
}

function function_573f49bb5d5a86ea(useweapon) {
  self endon("death_or_disconnect");
  self endon("super_use_finished");
  self waittill("weapon_change", useweapon);

  while(true) {
    self waittill("weapon_change", newweapon);
    weapon = self getcurrentweapon();

    if(function_ff3b77706565dacf(useweapon, newweapon)) {
      switchandtakesuperuseweapon(1);
      return;
    }
  }
}

function switchandtakesuperuseweapon(cacheammo, onend) {
  self endon("death");
  superinfo = getcurrentsuper();
  useweapon = superinfo.staticdata.useweapon;

  if(!isDefined(useweapon)) {
    return;
  }

  if(istrue(cacheammo) && issameweapon(self getcurrentweapon(), useweapon)) {
    function_22e13024dc2774e9();
  }

  if(isswitchingtoweaponwithmonitoring(useweapon)) {
    abortmonitoredweaponswitch(useweapon);
  }

  if(istrue(onend)) {
    self notify("super_switched");
  }

  getridofweapon(useweapon);

  if(!istrue(onend)) {
    setsuperisactive(0);
  }
}

function storesuperpoints() {
  superinfo = getcurrentsuper();

  if(!isDefined(superinfo)) {
    return;
  }

  if(issupercharging() || issuperready()) {
    self.pers["superBasePoints"] = superinfo.basepoints;
    self.pers["superExtraPoints"] = superinfo.extrapoints;
    return;
  }

  if(issuperinuse() && shouldrefundsuper()) {
    pointsneeded = getsuperpointsneeded();
    self.pers["superPoints"] = superinfo.usepercent * pointsneeded;
    self.pers["superExtraPoints"] = 0;
    return;
  }

  self.pers["superBasePoints"] = 0;
  self.pers["superExtraPoints"] = 0;
}

function getsuperuseuiprogress() {
  superinfo = getcurrentsuper();
  assertex(superinfo.isinuse, "<dev string:x3fc>");

  return superinfo.usepercent;
}

function getcurrentsuperbasepoints() {
  return getcurrentsuper().basepoints;
}

function getcurrentsuperextrapoints() {
  return getcurrentsuper().basepoints;
}

function getcurrentsuperpoints() {
  superinfo = getcurrentsuper();
  return superinfo.basepoints + superinfo.extrapoints;
}

function getsuperpointsneeded() {
  superinfo = getcurrentsuper();
  pointsneeded = 0;

  if(isDefined(superinfo)) {
    pointsneeded = superinfo.staticdata.pointsneeded;
  }

  if(isDefined(self.perkpackagedata.overridepointsneeded)) {
    pointsneeded = self.perkpackagedata.overridepointsneeded;
  }

  return pointsneeded;
}

function issuperready() {
  if(scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    return self.var_1066fbd86c88a6df;
  }

  superinfo = getcurrentsuper();

  if(!isDefined(superinfo) || superinfo.isinuse) {
    return 0;
  }

  return getcurrentsuperpoints() >= getsuperpointsneeded();
}

function function_6c06220f8b5b7079() {
  superinfo = getcurrentsuper();

  if(!isDefined(superinfo) || superinfo.isinuse) {
    return false;
  }

  if(!isDefined(self.overclockcharge) || !scripts\mp\utility\perk::_hasperk("specialty_overcharge_field_upgrade")) {
    return false;
  }

  return self.overclockcharge >= getsuperpointsneeded();
}

function function_c3479770ffec05e2() {
  return isDefined(getcurrentsuper()) && getcurrentsuper().isactive;
}

function issuperinuse() {
  return isDefined(getcurrentsuper()) && getcurrentsuper().isinuse;
}

function function_565913010c84ffca() {
  return istrue(self.var_65bd32c9df8d4292);
}

function function_c0fe8dee01b2adac(var_623c13007339ec2f) {
  self.var_65bd32c9df8d4292 = var_623c13007339ec2f;
}

function function_1029081898b028c(ispaused) {
  superinfo = getcurrentsuper();
  superinfo.var_6b24c44c436dd911 = ispaused;
}

function setsuperisinuse(isinuse) {
  superinfo = getcurrentsuper();
  superinfo.isinuse = isinuse;
  updatesuperuistate();
}

function setsuperisactive(isactive) {
  superinfo = getcurrentsuper();
  superinfo.isactive = isactive;

  if(!isactive && issuperinuse()) {
    self setclientomnvar("ui_super_can_use", 1);
    return;
  }

  if(isactive && superinfo.staticdata.ref == "super_evg") {
    return;
  }

  self setclientomnvar("ui_super_can_use", 0);
}

function issupercharging() {
  return !issuperready() && !issuperinuse();
}

function issuperexpended() {
  return istrue(getpersstat("superExpended"));
}

function function_f95bcca44e8cba53(superref) {
  if(!isDefined(superref)) {
    return 0;
  }

  if(!isDefined(level.var_3e969a1cc0ad79cc)) {
    return 0;
  }

  if(!scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    return 0;
  }

  return array_contains(level.var_3e969a1cc0ad79cc, superref);
}

function setsuperexpended(var_a6b84f600dc33630) {
  self.pers["superExpended"] = var_a6b84f600dc33630;
  updatesuperuistate();
}

function getcurrentsuper() {
  return self.super;
}

function getcurrentsuperref() {
  superinfo = getcurrentsuper();

  if(!isDefined(superinfo)) {
    return undefined;
  }

  return superinfo.staticdata.ref;
}

function function_43ec2fc7986c3310() {
  superinfo = getcurrentsuper();

  if(!isDefined(superinfo)) {
    return 0;
  }

  if(!isDefined(superinfo.var_6b24c44c436dd911)) {
    return 0;
  }

  return superinfo.var_6b24c44c436dd911;
}

function function_415ab9351849fba8(superinfo) {
  if(!superinfo.isinuse) {
    return;
  }

  var_adb9fb37d7698f6c = max(0, superinfo.var_2d439ede1c8ec8b9 - superinfo.var_b0104dddec932264);
  refillrate = min(superinfo.var_7da7aeb063e429ee, var_adb9fb37d7698f6c);
  superinfo.var_b0104dddec932264 += refillrate;
  return refillrate;
}

function function_b5e551ba033bbd3b(seconds) {
  superinfo = getcurrentsuper();

  if(!isDefined(superinfo) || !superinfo.isinuse) {
    return;
  }

  superinfo.var_2d439ede1c8ec8b9 += max(0, seconds);
}

function function_c018f54841eb7b(var_500338cbcd60c91e) {
  superinfo = getcurrentsuper();

  if(!isDefined(superinfo)) {
    return;
  }

  superinfo.var_7da7aeb063e429ee = max(0, var_500338cbcd60c91e);
}

function shouldrefundsuper() {
  assert(issuperinuse());
  superinfo = getcurrentsuper();
  graceperiod = superinfo.staticdata.graceperiod;

  if(!isDefined(superinfo.usestarttime)) {
    return 0;
  }

  usedtime = gettime() - superinfo.usestarttime;

  if(usedtime >= graceperiod) {
    return 0;
  }

  if(superinfo.numkills > 0) {
    return 0;
  }

  return superinfo.allowrefund;
}

function getsuperrefforsuperuseweapon(weapon) {
  if(!isstring(weapon)) {
    weapon = weapon.basename;
  }

  if(!isDefined(level.superglobals) || !isDefined(level.superglobals.superweapons) || !isDefined(level.superglobals.superweapons[weapon])) {
    return undefined;
  }

  return level.superglobals.superweapons[weapon].ref;
}

function getsuperrefforsuperoffhand(weapon) {
  if(!isstring(weapon)) {
    weapon = weapon.basename;
  }

  if(!isDefined(level.superglobals.supersbyoffhand[weapon])) {
    return undefined;
  }

  return level.superglobals.supersbyoffhand[weapon].ref;
}

function getsuperrefforsuperextraweapon(weapon) {
  if(!isstring(weapon)) {
    weapon = weapon.basename;
  }

  if(!isDefined(level.superglobals.supersbyextraweapon[weapon])) {
    return undefined;
  }

  return level.superglobals.supersbyextraweapon[weapon].ref;
}

function getsuperrefforsuperweapon(weapon) {
  if(!isDefined(level.superglobals)) {
    return undefined;
  }

  if(!isstring(weapon)) {
    weapon = weapon.basename;
  }

  superuseweapon = getsuperrefforsuperuseweapon(weapon);

  if(isDefined(superuseweapon)) {
    return superuseweapon;
  }

  superoffhand = getsuperrefforsuperoffhand(weapon);

  if(isDefined(superoffhand)) {
    return superoffhand;
  }

  superoffhand = getsuperrefforsuperextraweapon(weapon);

  if(isDefined(superoffhand)) {
    return superoffhand;
  }

  switch (weapon) {
    case #"hash_1a30d3a1753a5b6":
      return "super_tac_insert";
    case #"hash_e2c74e289201361":
      return "super_loadout_drop";
    case #"hash_10480ca9423043c7":
      return "super_laser_charge";
  }

  return undefined;
}

function shouldtracksuperweaponstats(objweapon) {
  ref = getsuperrefforsuperweapon(objweapon);

  if(isDefined(ref)) {
    data = level.superglobals.staticsuperdata[ref];
    return data.useweapontrackstats;
  }

  return undefined;
}

function getsuperid(superref) {
  if(!isDefined(superref) || !isDefined(level.superglobals) || !isDefined(level.superglobals.staticsuperdata) || !isDefined(level.superglobals.staticsuperdata[superref]) || superref == "none") {
    return 0;
  }

  return level.superglobals.staticsuperdata[superref].id;
}

function getmovespeedforsuperweapon(objweapon) {
  ref = getsuperrefforsuperweapon(objweapon);

  if(!isDefined(ref)) {
    return undefined;
  }

  return level.superglobals.staticsuperdata[ref].movespeed;
}

function getrootsuperref(superref) {
  return getsubstr(superref, 6);
}

function function_eb25267ee439cabe(superref) {
  if(isDefined(level.superglobals.staticsuperdata[superref])) {
    return level.superglobals.staticsuperdata[superref].weapon;
  }

  return undefined;
}

function function_36c4aa603286c24f(weapon) {
  superref = getsuperrefforsuperweapon(weapon);

  if(isDefined(superref) && isDefined(level.var_ebf0955a0c675ff3)) {
    return istrue(level.var_ebf0955a0c675ff3[superref]);
  }

  return false;
}

function function_e7f40551b644fb00(superref) {
  if(!isDefined(level.var_ebf0955a0c675ff3)) {
    level.var_ebf0955a0c675ff3 = [];
  }

  level.var_ebf0955a0c675ff3[superref] = 1;
}

function function_83a68723acc3296d(weaponname) {
  superref = getsuperrefforsuperoffhand(weaponname);

  if(isDefined(superref)) {
    superdata = level.superglobals.staticsuperdata[superref];

    if(isDefined(superdata)) {
      return superdata.bundle;
    }
  }

  return undefined;
}

function function_5cc7d8c432d5d6c1(superref) {
  superdata = level.superglobals.staticsuperdata[superref];

  if(isDefined(superdata)) {
    return superdata.var_94deac09d462d41e;
  }

  return undefined;
}

function function_c519ae03535afe0f(superref) {
  superdata = level.superglobals.staticsuperdata[superref];

  if(isDefined(superdata)) {
    return superdata.var_41f94bca374ed58a;
  }

  return undefined;
}

function allowsuperweaponstow() {
  superinfo = getcurrentsuper();

  if(!isDefined(superinfo) || !superinfo.isinuse) {
    return;
  }

  superinfo.canstow = 1;
}

function unstowsuperweapon() {
  superinfo = getcurrentsuper();

  if(!isDefined(superinfo) || !superinfo.canstow) {
    return;
  }

  if(!superinfo.isinuse || !isDefined(superinfo.staticdata.useweapon)) {
    superinfo.canstow = 0;
    return;
  }

  domonitoredweaponswitch(superinfo.staticdata.useweapon);
  superinfo.canstow = 0;
}

function getsuperpointsforevent(eventref) {
  if(!isxhash(eventref)) {
    assertex(1, eventref);
    eventref = function_1823ff50bb28148d(eventref);
  }

  if(!isDefined(level.var_7de15b4c7f0a425)) {
    return 0;
  }

  points = level.var_7de15b4c7f0a425[eventref];

  if(!isDefined(points)) {
    return 0;
  }

  return points;
}

function watchforgameend() {
  level waittill("game_ended");

  if(waslastround()) {
    foreach(player in level.players) {
      player writesppmstats();
    }
  }
}

function getsppmdata() {
  if(getdvarint(@ "hash_a3220d5d00c60fc0", 0) == 0) {
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

function updatesppm(pointsearned, var_f3b601e04de761d9, eventref) {
  if(getdvarint(@ "hash_a3220d5d00c60fc0", 0) == 0) {
    return;
  }

  if(isai(self)) {
    return;
  }

  data = getsppmdata();
  data.totalpoints += pointsearned;

  if(istrue(var_f3b601e04de761d9)) {
    data.totalappliedpoints += pointsearned;
  }

  if(!isDefined(eventref)) {
    eventref = "undefined";
  }

  if(!isDefined(data.eventtotals[eventref])) {
    data.eventtotals[eventref] = pointsearned;
    return;
  }

  data.eventtotals[eventref] += pointsearned;
}

function writesppmstats() {
  if(getdvarint(@ "hash_a3220d5d00c60fc0", 0) == 0) {
    return;
  }

  if(isai(self)) {
    return;
  }

  data = getsppmdata();
  totaltime = scripts\mp\persistence::statgetchildbuffered("round", "timePlayed", 1) / 60;
  sppm = 0;
  appliedsppm = 0;

  if(totaltime > 0) {
    sppm = data.totalpoints / totaltime;
    appliedsppm = data.totalappliedpoints / totaltime;
  }

  bestevent = "";
  var_be43446b63cc7949 = -1;

  foreach(event, eventtotal in data.eventtotals) {
    if(eventtotal > var_be43446b63cc7949) {
      var_be43446b63cc7949 = eventtotal;
      bestevent = event;
    }
  }

  if(isxhash(bestevent)) {
    bestevent = function_f28fd66285fa2c9(bestevent);
  }

  dlog_recordevent("mpscript_sppm", ["sppm", sppm, "sppm_applied", appliedsppm, "gamemode", getgametype(), "kills", self.kills, "time_played", totaltime, "best_event", bestevent, "script_version", getscriptdataversion()]);
}

function modifysuperequipmentdamage(attacker, objweapon, type, damage, idflags) {
  modifieddamage = damage;

  if(isDefined(self.owner) && isDefined(attacker) && attacker == self.owner) {
    modifieddamage = int(ceil(damage * 0.5));
  }

  return modifieddamage;
}

function updateactivesupers(einflictor, attacker, victim, idamage, smeansofdeath, objweapon, shitloc, vdir) {
  var_c3a55ee9f23fb616 = isDefined(einflictor) && isPlayer(einflictor);
  var_d758f68157febc76 = objweapon.basename == "throwingknife_mp" || objweapon.basename == "throwingknife_fire_mp" || objweapon.basename == "throwingknife_electric_mp" || objweapon.basename == "shuriken_mp" || objweapon.basename == "throwstar_mp";
  var_4f5e5bf85bdb8c7a = var_d758f68157febc76 && isDefined(einflictor) && isDefined(einflictor.classname) && einflictor.classname == "grenade";
  var_99d1abc1148a35ad = isDefined(attacker) && isPlayer(attacker) && attacker != victim;

  if(var_99d1abc1148a35ad) {
    var_7639389406e14c2e = attacker scripts\mp\supers::getcurrentsuper();

    if(var_c3a55ee9f23fb616 || var_4f5e5bf85bdb8c7a) {
      if(isDefined(var_7639389406e14c2e) && attacker issuperinuse() && isPlayer(victim) && scripts\cp_mp\utility\player_utility::playersareenemies(attacker, victim)) {
        if(var_7639389406e14c2e.staticdata.ref == "super_deadsilence") {
          attacker thread scripts\mp\supers\super_deadsilence::superdeadsilence_onkill();
        }

        if(var_7639389406e14c2e.staticdata.ref == "super_battlerage" || var_7639389406e14c2e.staticdata.ref == "super_squadrage") {
          attacker thread scripts\mp\equipment\battlerage::function_fe088cdea420c6d6();
        }

        if(var_7639389406e14c2e.staticdata.ref == "super_honeypot") {
          attacker thread scripts\mp\supers\honeypot::function_9bc4debdef524e6a();
        }
      }
    }

    if(var_c3a55ee9f23fb616) {
      if(einflictor scripts\mp\utility\perk::_hasperk("specialty_bulletdamage")) {
        attacker thread scripts\mp\supers\super_stoppingpower::stoppingpower_onkill(objweapon);
      }

      if(einflictor scripts\mp\utility\perk::_hasperk("specialty_bulletsuppress") && scripts\mp\utility\perk::_hasperk("specialty_bulletpenetration")) {
        attacker thread scripts\mp\supers\super_suppression_rounds::function_8f9a9c04e9e4b5af(objweapon);
      }
    }
  }
}

function watchsuperdelay() {
  level endon("super_delay_end");
  level endon("round_end");
  level endon("game_ended");

  if(isanymlgmatch()) {
    level.superdelay = 0;
  } else {
    level.superdelay = getdvarfloat(@ "scr_superdelay", 0);
  }

  if(!scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
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

  val::set("super_delay", "supers", 0);
  waittill_any_ents(level, "super_delay_end", self, "watchPlayerSuperDelayWeapon");
  val::reset_all("super_delay");
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

function givesuperweapon(superinfo) {
  if(!self hasweapon(superinfo.weaponobj)) {
    ammo = ter_op(issuperready(), 1, 0);
    _giveweapon(superinfo.weaponobj);
    self setweaponammoclip(superinfo.weaponobj, ammo);
    self assignweaponoffhandspecial(superinfo.weaponobj);
  }
}

function issuperdisabled() {
  return !scripts\common\values::get("supers");
}

function watchobjuse(drainrate, var_1507e598e016eb8) {
  self endon("death_or_disconnect");
  self endon("obj_drain_end");
  self endon("ball_dropped");

  if(getbasegametype() == "sd" || getgametype() == "sr" || getgametype() == "dd") {
    if(istrue(var_1507e598e016eb8)) {
      self waittill("super_obj_drain");
    }
  } else if(!isDefined(self.carryobject)) {
    self waittill("obj_picked_up");
  } else {
    wait 0.05;
  }

  while(issuperinuse()) {
    reducesuperusepercent(drainrate);
    wait 0.05;
  }
}

function combatrecordsuperuse(super) {
  if(!canrecordcombatrecordstats()) {
    return;
  }

  oldvalue = self getplayerdata(level.var_5d69837cf4db0407, "playerStats", "superStats", super, "uses");
  self setplayerdata(level.var_5d69837cf4db0407, "playerStats", "superStats", super, "uses", oldvalue + 1);
}

function combatrecordsuperkill(super) {
  if(!canrecordcombatrecordstats()) {
    return;
  }

  oldvalue = self getplayerdata(level.var_5d69837cf4db0407, "playerStats", "superStats", super, "kills");
  self setplayerdata(level.var_5d69837cf4db0407, "playerStats", "superStats", super, "kills", oldvalue + 1);
}

function combatrecordsupermisc(super, increment) {
  if(!canrecordcombatrecordstats()) {
    return;
  }

  if(!isDefined(increment)) {
    increment = 1;
  }

  oldvalue = getcombatrecordsupermisc(super);
  self setplayerdata(level.var_5d69837cf4db0407, "playerStats", "superStats", super, "misc1", oldvalue + increment);
}

function getcombatrecordsupermisc(super) {
  return self getplayerdata(level.var_5d69837cf4db0407, "playerStats", "superStats", super, "misc1");
}

function superdisabledinarbitraryup(superref) {
  if(superref == "super_microturret" || superref == "super_supertrophy") {
    return true;
  }

  return false;
}

function superdisabledinarbitraryupmessage() {
  scripts\mp\hud_message::showerrormessage("MP/SUPERS_UNAVAILABLE_ARB_UP");
}

function choppergunnerbeginuse() {
  return scripts\mp\killstreaks\killstreaks::trytriggerkillstreakfromsuper("chopper_gunner");
}

function cruisepredatorbeginuse() {
  return scripts\mp\killstreaks\killstreaks::trytriggerkillstreakfromsuper("cruise_predator");
}

function scramblebeginuse() {
  scrambleent = spawn("script_model", self.origin + (0, 0, 400));
  self.scrambleent = scrambleent;
  self.scrambleent setModel("super_scramble_mp");
  self.scrambleent linkTo(self);
  self.scrambleent.owner = self;
  self.scrambleent.team = self.team;
  self.scrambleent setotherent(self);
  self.scrambleent setscriptablepartstate("scramble_sfx", "on", 0);
  thread scripts\cp_mp\killstreaks\helper_drone::helperdrone_watchscramblereffectdist(self);
  return true;
}

function scrambleusefinished(fromdeath) {
  self.scrambleent unlink();
  self.scrambleent delete();
  scripts\cp_mp\killstreaks\helper_drone::helperdrone_endscramblereffect();
}

function trophyonset() {
  return scripts\mp\equipment\trophy_system::trophy_onsuperset();
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

function function_9c38f7ea2223b47c() {
  return scripts\mp\equipment\door_barricade::function_2e07802ab9938047();
}

function function_3bc4f06f06e9c62() {
  return true;
}

function function_d1bd30be0c5ec282() {
  return scripts\mp\equipment\tactical_camera::tacticalcamera_set();
}

function function_2ef8268013bdbe57() {
  return scripts\mp\equipment\tactical_camera::tacticalcamera_unset();
}

function function_2b9e988cdb17f507(objweapon) {
  return scripts\mp\equipment\tactical_camera::function_1af63adb97f131a1(objweapon);
}

function function_dfc3421815005e62() {
  return scripts\mp\equipment\tactical_camera::function_60367230245c7390();
}

function deployeddecoyunset() {
  return scripts\mp\equipment\deployed_decoy::deployeddecoy_unset();
}

function function_25b1b1c8cae25c68(objweapon) {
  return scripts\mp\equipment\deployed_decoy::function_786a7189ad105a77(objweapon);
}

function function_96042b357c338ada(objweapon) {
  if(issharedfuncdefined("super_hb_sensor", "onSuperButtonHold")) {
    return function_f3bb4f4911a1beb2("super_hb_sensor", "onSuperButtonHold", objweapon);
  }

  return undefined;
}

function function_6129eaac0c283bb7(objweapon) {
  if(issharedfuncdefined("super_hb_sensor", "given")) {
    return function_f3bb4f4911a1beb2("super_hb_sensor", "given", objweapon);
  }

  return undefined;
}

function function_971b383d95556418(objweapon) {
  if(issharedfuncdefined("super_evg", "onSuperButtonPressed")) {
    return function_f3bb4f4911a1beb2("super_evg", "onSuperButtonPressed", objweapon);
  }

  return undefined;
}

function function_63cb15591c54cb1(objweapon) {
  if(issharedfuncdefined("super_evg", "given")) {
    return function_f3bb4f4911a1beb2("super_evg", "given", objweapon);
  }

  return undefined;
}

function function_fad76ffce1bc5317() {
  return namespace_87a763dd2088afea::function_2cf7e1e0b6513c6f();
}

function function_af1d2e4473f5057e() {
  return namespace_87a763dd2088afea::function_79893d5ed21ae366();
}

function recondronebeginuse() {
  return scripts\cp_mp\killstreaks\recon_drone::recondrone_beginsuper();
}

function function_3529248aa2d81abc() {
  return scripts\cp_mp\killstreaks\recon_drone::function_439e22ca27f68ce3();
}

function recondroneenduse(fromdeath, attacker) {
  return scripts\cp_mp\killstreaks\recon_drone::recondrone_endsuper(fromdeath);
}

function recondroneunset() {
  scripts\cp_mp\killstreaks\recon_drone::recondrone_unsetsuper();
}

function empdronebeginuse() {
  return scripts\cp_mp\killstreaks\emp_drone_targeted::empdrone_beginsuper();
}

function deadsilencebeginuse() {
  return scripts\mp\supers\super_deadsilence::superdeadsilence_beginsuper();
}

function deadsilenceenduse(fromdeath, attacker) {
  return scripts\mp\supers\super_deadsilence::superdeadsilence_endsuper(fromdeath);
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

function superweapondropbeginuse() {
  return scripts\mp\equipment\weapon_drop::weapondrop_beginsuper();
}

function suppressunset() {
  scripts\mp\supers\super_suppression_rounds::function_b2d2056ee8b00689();
}

function function_66c2b6fb2734cbae() {
  return scripts\mp\supers\super_suppression_rounds::suppressionrounds_beginuse();
}

function function_2de710d6b3c9388e() {
  return scripts\mp\supers\super_emp_pulse::function_f62e25cb503d7bab();
}

function function_ca449b017d946d26(fromdeath, attacker) {
  return scripts\mp\supers\super_emp_pulse::function_2f0d9315ab20c4bf();
}

function function_d93f331b74c647f2() {
  return scripts\mp\supers\super_emp_pulse::function_e83e2d8dc74ffdbb();
}

function emppulseunset() {
  return scripts\mp\supers\super_emp_pulse::emppulse_unset();
}

function function_81a2df228546136e() {
  return scripts\mp\equipment\battlerage::function_905b7bada6fd91cb();
}

function function_d1b35aa1689beb06(fromdeath, attacker) {
  return scripts\mp\equipment\battlerage::function_739a5f064c7debdf();
}

function function_14761663823dbcb7() {
  return scripts\mp\supers\smokeairdrop::function_685e618d30da1588();
}

function function_2e14b99891ecbbf4() {
  return scripts\mp\supers\smokeairdrop::function_269055d8846e4665();
}

function function_69e46ed9d65ec7e4() {
  return function_f3bb4f4911a1beb2("super_evg", "taken");
}

function blindingturretunset() {
  return scripts\mp\supers\blindingturret::blindingturret_unset();
}

function function_53025970eb68a86b() {
  return scripts\mp\supers\super_stimpistol::function_321c7891711e583f();
}

function function_fdfae98bcfbf8c7f(fromdeath, attacker) {
  return scripts\mp\supers\super_stimpistol::function_f5037ba4a5399b63(fromdeath);
}

function function_dec15d25ce41a183() {
  return scripts\mp\supers\super_stimpistol::function_a377d33613e0c83();
}

function launcherset() {
  if(issharedfuncdefined("super_launcher", "launcher_set")) {
    return [[getsharedfunc("super_launcher", "launcher_set")]]();
  }
}

function launcherunset() {
  if(issharedfuncdefined("super_launcher", "launcher_unset")) {
    return [[getsharedfunc("super_launcher", "launcher_unset")]]();
  }
}

function launcherbeginuse() {
  if(issharedfuncdefined("super_launcher", "launcher_begin_use")) {
    return [[getsharedfunc("super_launcher", "launcher_begin_use")]]();
  }
}

function launcherenduse(fromdeath, attacker) {
  if(issharedfuncdefined("super_launcher", "launcher_end_use")) {
    return [[getsharedfunc("super_launcher", "launcher_end_use")]](fromdeath);
  }
}

function function_b8ba0f8c9f136125() {
  if(issharedfuncdefined("super_launcher", "launcher_repeat")) {
    return [[getsharedfunc("super_launcher", "launcher_repeat")]]();
  }
}

function function_8d6d142bceb819f2() {
  return scripts\mp\supers\loadout_drop::function_40f1163063c26637();
}

function function_e3c0d84aa4294ee9() {
  success = 0;
  success = function_97eecce0124a7b50();

  if(success) {
    success = scripts\cp_mp\oxygenmask::function_2e4cd4d627c30c24();
  }

  return success;
}

function function_cf347a049095421b() {}

function function_19b0130d94d96b0b() {}

function function_34956da8dd3afd1f(fromdeath, attacker) {}

function function_fc34a7d0e83b6d77() {}

function function_a7043870418bf96b(fromdeath, attacker) {}

function function_f98d4ec41407bc75() {
  return namespace_1f2efdb89e5f3a6e::function_d45fd98510d7b7e9();
}

function function_975965422d6bcb49(fromdeath, attacker) {
  return namespace_1f2efdb89e5f3a6e::function_e0a9daa14c0b948b();
}

function function_e9993ee767c0acf5() {
  return namespace_9f9a23de1f1dc7ff::function_cfb677b5f7d5e644();
}

function function_ec715b4038ae47c9(fromdeath, attacker) {
  return true;
}

function function_e67d9c8005d3f178() {
  return namespace_314b181252bf1520::function_c54f7da664700b4b();
}

function function_13214dc30f36bf08(fromdeath, attacker) {}

function function_8d08654f0023d631() {}

function function_3a1b0ee4f020ab35() {}

function function_2b9dfa62d7e245f5(fromdeath, attacker) {}

function function_b8e4c757481c3bf2() {
  return scripts\mp\supers\honeypot::function_99877ccd9f1a6857();
}

function function_20d973416d5e8d9a(fromdeath, attacker) {
  return scripts\mp\supers\honeypot::function_c91188ff5b13a34b(attacker);
}

function superselectonset() {
  firstupgrade = scripts\mp\perks\perkpackage::perkpackage_getfirstfieldupgrade();
  self.super.firstupgrade = firstupgrade;
  secondupgrade = scripts\mp\perks\perkpackage::perkpackage_getsecondfieldupgrade();
  self.super.secondupgrade = secondupgrade;
}

function function_c9491df86b072612(firstupgrade, secondupgrade) {
  if(!isDefined(firstupgrade)) {
    firstupgrade = scripts\mp\perks\perkpackage::perkpackage_getfirstfieldupgrade();
  }

  if(!isDefined(secondupgrade)) {
    secondupgrade = scripts\mp\perks\perkpackage::perkpackage_getsecondfieldupgrade();
  }

  staticdata = level.superglobals.staticsuperdata[firstupgrade];
  var_d5c938e8c28ec207 = 0;

  if(isDefined(staticdata)) {
    var_d5c938e8c28ec207 = staticdata.pointsneeded;
  }

  staticdata = level.superglobals.staticsuperdata[secondupgrade];
  var_55fca3a9d50b3bb3 = 0;

  if(isDefined(staticdata)) {
    var_55fca3a9d50b3bb3 = staticdata.pointsneeded;
  }

  var_f50865a8840fa2b7 = max(var_d5c938e8c28ec207, var_55fca3a9d50b3bb3);
  self.perkpackagedata.overridepointsneeded = var_f50865a8840fa2b7;
}

function function_e78f07efbcdb9e97() {
  self.perkpackagedata.overridepointsneeded = undefined;
}

function superselectonunset() {
  function_ddeb08081f6fabea();
}

function function_fad6d78d6b3b3359(objweapon) {
  if(isDefined(self.var_35b042c5224a1646)) {
    var_908084e5cdd0ae1a = level.superglobals.staticsuperdata[self.var_35b042c5224a1646];

    if(isDefined(var_908084e5cdd0ae1a.var_1bb8c2de6198881a)) {
      if(istrue([[var_908084e5cdd0ae1a.var_1bb8c2de6198881a]](objweapon))) {
        self notify("perkPackageMenu_close");
      }
    }
  }
}

function superselectbeginuse() {
  return scripts\mp\perks\perkpackage::perkpackage_openselect();
}

function function_baf9eeef4cf2bac5() {
  firstupgrade = scripts\mp\perks\perkpackage::perkpackage_getfirstfieldupgrade();
  secondupgrade = scripts\mp\perks\perkpackage::perkpackage_getsecondfieldupgrade();

  if(!isDefined(self.var_35b042c5224a1646) || isDefined(self.var_35b042c5224a1646) && self.var_35b042c5224a1646 == "super_emp_pulse") {
    if(firstupgrade == "super_emp_pulse" || secondupgrade == "super_emp_pulse") {
      scripts\mp\supers::function_7203e7aa96ff0ba9(30);
      scripts\mp\supers\super_emp_pulse::function_75baa17a54260f6f(1);
    }
  }
}

function testsuperbeginuse() {
  thread testsuperrefundwatcher();
  return true;
}

function superfultonbeginuse() {
  return true;
}

function supersupplydropbeginuse() {
  return true;
}

function function_7eead274ef83e1b9() {
  return scripts\mp\supers\vehicle_drop::function_172a790b85bbc40b();
}

function function_afd34c64e8c8d5d() {
  return scripts\mp\supers\super_stimpistol::function_9db6a100a4046d0c();
}

function function_90a74a57a43c9808() {
  return scripts\mp\supers\super_stimpistol::function_3f29f7ceb8c0ec6d();
}

function function_77a8296b67aa7a1c() {
  if(issharedfuncdefined(#"super_laststand_syringe", #"beginuse", 1)) {
    return [[getsharedfunc(#"super_laststand_syringe", #"beginuse")]]();
  }

  return 0;
}

function function_25ea1075448678c(fromdeath, attacker) {
  if(issharedfuncdefined(#"super_laststand_syringe", #"enduse", 1)) {
    return [[getsharedfunc(#"super_laststand_syringe", #"enduse")]](fromdeath);
  }

  return 0;
}

function function_e285dcf9693ca723(fromdeath, attacker) {
  if(issharedfuncdefined(#"super_spykit", #"enduse", 1)) {
    return [[getsharedfunc(#"super_spykit", #"enduse")]](fromdeath);
  }

  return 0;
}

function testsuperrefundwatcher() {
  self endon("super_use_finished");

  while(true) {
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
  return;
}

function clearsuperremindersplash() {
  self notify("showSuperReminderSplash");
  self.superreminderset = undefined;
  self setclientomnvar("ui_super_reminder", 0);
}

function clearsuperreminderondeath(player) {
  if(!isPlayer(player)) {
    return;
  }

  thread clearsuperreminderondeathinternal(player);
}

function clearsuperreminderondeathinternal(player) {
  player endon("disconnect");
  player waittill("death");
  player clearsuperremindersplash();
}

function initsuperdvars() {
  setdevdvarifuninitialized(@ "hash_eba0ef12e9c9260b", 0);
  setdevdvarifuninitialized(@ "hash_350b9a835c1f30b8", 0);
  setdevdvarifuninitialized(@ "hash_89ab277fb91d0852", 60);
  setdevdvarifuninitialized(@ "hash_eea9235538d727fe", 45);
  setdevdvarifuninitialized(@ "hash_ee86355538b107dc", 90);
  setdevdvarifuninitialized(@ "hash_71b04bfc490e137a", 0);

  setdvarifuninitialized(@ "hash_e1d7f49648b75f36", 6);
  var_25303120c23ade8d = getdvarint(@ "hash_71b04bfc490e137a", 0);

  if(var_25303120c23ade8d) {
    level.superglobals.var_2652b1ba218bbaf5 = var_25303120c23ade8d;
  }
}

function watchsuperlottery() {
  level endon("game_ended");
  var_69f8c933a9416fd4 = getdvarint(@ "hash_89ab277fb91d0852", 60);
  var_ceb102618af8a2a0 = getdvarint(@ "hash_eea9235538d727fe", 45);
  var_ce8d18618ad0584a = getdvarint(@ "hash_ee86355538b107dc", 90);
  var_c2c32ebb75125711 = var_ce8d18618ad0584a - var_ceb102618af8a2a0;
  assert(var_ceb102618af8a2a0 > 0 && var_ceb102618af8a2a0 < var_ce8d18618ad0584a);
  waitframe();

  if(!istrue(gameflag("prematch_done"))) {
    level waittill("prematch_over");
  }

  wait var_69f8c933a9416fd4;
  var_650c8acdffcc5af7 = undefined;
  superlotteryenabled = undefined;
  var_6b769601e87e9c1e = [];
  var_2f915c7e43a8c53c = [];

  foreach(entry in level.teamnamelist) {
    var_6b769601e87e9c1e[entry] = undefined;
    var_2f915c7e43a8c53c[entry] = [];
  }

  while(true) {
    var_650c8acdffcc5af7 = superlotteryenabled;
    superlotteryenabled = getdvarint(@ "hash_350b9a835c1f30b8", 0) > 0;

    if(!isDefined(var_650c8acdffcc5af7) || var_650c8acdffcc5af7 != superlotteryenabled) {
      if(superlotteryenabled) {
        level notify("superLotteryEnabled");
      } else {
        level notify("superLotteryDisabled");
      }
    }

    foreach(entry in level.teamnamelist) {
      if(!isDefined(var_6b769601e87e9c1e[entry])) {
        var_6b769601e87e9c1e[entry] = gettime() + (var_ceb102618af8a2a0 + randomint(var_c2c32ebb75125711)) * 1000;
        continue;
      }

      if(var_6b769601e87e9c1e[entry] <= gettime()) {
        players = getteamdata(entry, "players");

        if(players.size > 0) {
          players = array_randomize(players);
          var_760ebc212d9d24e1 = [];
          bestplayer = undefined;

          foreach(player in players) {
            if(!array_contains(var_2f915c7e43a8c53c[entry], player)) {
              if(isDefined(player getcurrentsuper())) {
                bestplayer = player;
                break;
              }

              continue;
            }

            if(isDefined(player getcurrentsuper())) {
              var_760ebc212d9d24e1[var_760ebc212d9d24e1.size] = player;
            }
          }

          if(!isDefined(bestplayer)) {
            if(isDefined(var_760ebc212d9d24e1[0])) {
              bestplayer = var_760ebc212d9d24e1[0];
            } else {
              bestplayer = players[0];
            }
          }

          if(superlotteryenabled) {
            childthread awardsuperlottery(bestplayer);
          }

          var_2f915c7e43a8c53c[var_2f915c7e43a8c53c.size] = bestplayer;
        }

        var_6b769601e87e9c1e[entry] = undefined;
      }
    }

    waitframe();
  }
}

function awardsuperlottery(player) {
  player endon("disconnect");
  player endon("joined_team");
  level endon("superLotteryDisabled");
  player notify("awardSuperLottery");
  player endon("awardSuperLottery");

  while(true) {
    superinfo = player getcurrentsuper();

    if(!isDefined(superinfo)) {
      return;
    }

    if(!player issuperinuse()) {
      break;
    }

    waitframe();
  }

  player givesuperpoints(getsuperpointsneeded(), undefined, 1);
}

function getscriptdataversion() {
  if(getdvarint(@ "hash_6af7e4425b1f5d10", 0) != 0) {
    return 254;
  }

  if(getdvarint(@ "hash_ff689af941dd10a1", 0) != 0) {
    return 7;
  }

  return 254;
}

function recordsuperearnedanalytics(superinfo) {
  if(getdvarint(@ "hash_13856880331b5596", 0) == 0) {
    return;
  }

  timeplayed = scripts\mp\persistence::statgetchildbuffered("round", "timePlayed", 1) / 60;
  dlog_recordevent("mpscript_super_earning", ["super_ref", superinfo.staticdata.ref, "earn_time", timeplayed, "gamemode", getgametype(), "script_version", getscriptdataversion(), "earned_count", self.pers["supersEarned"]]);
}

function function_395a9cb3ebe25d55(superinfo) {
  var_f3ee0300341f6d5 = isDefined(superinfo.staticdata.useweapon);
  superweapon = ter_op(var_f3ee0300341f6d5, superinfo.staticdata.useweapon, superinfo.weaponobj);
  maxclipammo = weaponmaxammo(superweapon);
  ammopool = 0;

  if(var_f3ee0300341f6d5) {
    ammopool += superinfo.staticdata.useweaponclipammo;
    ammopool += min(maxclipammo, superinfo.staticdata.useweaponstockammo);
  } else {
    ammopool += min(maxclipammo, superinfo.staticdata.weaponammo);
  }

  return 1 / ammopool;
}

function private function_af7e8fca939f7347(superinfo) {
  if(!isDefined(level.gamemodebundle) || !istrue(level.gamemodebundle.var_e12ed09bf2e43167)) {
    return 0;
  }

  if(!isDefined(self.perkpackagedata) || !isDefined(self.perkpackagedata.weaponclipammo) || !isDefined(self.perkpackagedata.weaponstockammo) || !isDefined(self.perkpackagedata.weaponclipammo[superinfo.staticdata.ref]) || !isDefined(self.perkpackagedata.weaponstockammo[superinfo.staticdata.ref])) {
    return 0;
  }

  maxclipammo = weaponmaxammo(superinfo.staticdata.useweapon);
  ammopool = 0;
  ammopool += superinfo.staticdata.useweaponclipammo;
  ammopool += min(maxclipammo, superinfo.staticdata.useweaponstockammo);
  curammo = self.perkpackagedata.weaponclipammo[superinfo.staticdata.ref] + self.perkpackagedata.weaponstockammo[superinfo.staticdata.ref];
  return ammopool - curammo;
}

function function_235470b268f029ca(destroyfunc) {
  isoob = scripts\mp\outofbounds::ispointinoutofbounds(self.origin, self.owner.team);

  if(isoob) {
    if(isDefined(destroyfunc)) {
      self thread[[destroyfunc]]();
    }

    if(isDefined(self.owner)) {
      self.owner refundsuper();
    }
  }
}

function function_ddeb08081f6fabea() {
  fullclear = 0;

  if(isDefined(self.var_35b042c5224a1646)) {
    var_6e77f955d2c33644 = level.superglobals.staticsuperdata[self.var_35b042c5224a1646].var_f6604eebabcac6c2;

    if(!isDefined(var_6e77f955d2c33644)) {
      fullclear = 1;
    } else {
      id = level.superglobals.staticsuperdata[self.var_35b042c5224a1646].id;
      var_86747f1f24df567b = [[level.superglobals.staticsuperdata[self.var_35b042c5224a1646].var_f6604eebabcac6c2]]();

      if(istrue(var_86747f1f24df567b)) {
        scripts\mp\supers::function_7203e7aa96ff0ba9(id, 0, 1);
      } else {
        fullclear = 1;
      }
    }
  } else {
    fullclear = 1;
  }

  if(fullclear) {
    scripts\mp\supers::function_7203e7aa96ff0ba9(0);
  }
}

function function_7203e7aa96ff0ba9(superid, var_86c4bb77bc9871cd, forceshow) {
  assertex(isDefined(superid), "<dev string:x436>");

  if(superid == 0) {
    self setclientomnvar("ui_field_upgrade_use", superid);

    if(!istrue(var_86c4bb77bc9871cd)) {
      self.var_57d85036ea10552d = undefined;
    }

    return;
  }

  canshow = 0;

  if(!isDefined(self.super)) {
    return;
  }

  if(istrue(self.perkpackagedata.istwomode) && !istrue(forceshow)) {
    if(!isDefined(self.perkpackagedata.lastsuper)) {
      canshow = 1;
    } else if(isDefined(self.var_57d85036ea10552d)) {
      var_902970e912ecfbd5 = level.superglobals.supersbyid[self.var_57d85036ea10552d];
      var_6cfeb740aa80163a = level.superglobals.supersbyid[superid];
      var_fe1ca90a8e7694a0 = level.superglobals.staticsuperdata[var_902970e912ecfbd5].var_d835cd7abd661b88;
      var_857bc7a94ecf5791 = level.superglobals.staticsuperdata[var_6cfeb740aa80163a].var_d835cd7abd661b88;

      if(var_857bc7a94ecf5791 == -1) {
        canshow = 0;
      } else if(var_857bc7a94ecf5791 <= var_fe1ca90a8e7694a0) {
        canshow = 1;
      } else {
        canshow = 1;
        superid = self.var_57d85036ea10552d;
      }
    } else {
      canshow = 1;
    }
  } else {
    canshow = 1;
  }

  if(canshow || istrue(forceshow)) {
    self setclientomnvar("ui_field_upgrade_use", superid);
    self.var_57d85036ea10552d = superid;
  }
}

function function_a465412785d4c550(objweapon) {
  weaponname = undefined;

  if(!isDefined(objweapon)) {
    return false;
  }

  switch (objweapon.basename) {
    case #"hash_e2c74e289201361":
    case #"hash_c0d55eb64b4656ff":
    case #"hash_ca1eabc559246db2":
      return true;
  }

  return false;
}

function function_ea7187bdba6dff15(superref) {
  player = self;

  if(!isDefined(player)) {
    return;
  }

  scriptablename = scripts\cp_mp\utility\loot::function_b88cfb4893ceedac(superref);

  if(!player scripts\mp\gametypes\br::function_1c7f3f4e23f94f86(scriptablename)) {
    return;
  }

  lootid = scripts\cp_mp\utility\loot::function_fae5e1d3de32d3f7(scriptablename);
  var_ec3be9f70c7f5ae9 = player namespace_aead94004cf4c147::function_5915bdbc5f6302b6([lootid]);

  if(var_ec3be9f70c7f5ae9.size > 0) {
    player scripts\mp\gametypes\br_pickups::equipbackpackitem(var_ec3be9f70c7f5ae9[0]);
    return;
  }

  if(array_contains(level.br_pickups.br_superreference, superref)) {
    var_3d0262df72b9d0cc = player namespace_aead94004cf4c147::function_69f1f154cb91d491();

    if(var_3d0262df72b9d0cc.size > 0) {
      player scripts\mp\gametypes\br_pickups::equipbackpackitem(var_3d0262df72b9d0cc[0]);
    }
  }
}

function function_c1c41a5273f29351(objweapon, isimmediate) {
  self endon("death");
  self endon("disconnect");

  if(!isweapon(objweapon)) {
    if(isstring(objweapon)) {
      objweapon = makeweapon(objweapon);
    }

    assert(isweapon(objweapon), "<dev string:x484>");
  }

  if(!val::get("supers")) {
    return 0;
  }

  if(!isweapon(objweapon)) {
    self notify("giveAndFireSuperWeaponFailed", objweapon);
    return 0;
  }

  if(objweapon.classname == "grenade") {
    self giveandfireoffhand(objweapon);
  } else {
    return domonitoredweaponswitch(objweapon, isimmediate);
  }

  if(!self hasweapon(objweapon)) {
    self notify("giveAndFireSuperWeaponFailed", objweapon);
    return 0;
  }

  result = spawnStruct();
  result childthread function_7fdcd12f0e769a07(self, objweapon);
  result childthread function_abfceeedf55fde6(self, objweapon);
  result waittill("race_start");
  waittillframeend();
  result notify("race_end");

  if(istrue(result.success)) {
    self notify("giveAndFireOffhandReliableSucceeded", objweapon);
    return 1;
  }

  if(istrue(result.failure)) {
    self notify("giveAndFireOffhandReliableFailed", objweapon);
    return 0;
  }
}

function private function_7fdcd12f0e769a07(player, objweapon, var_81ea6bd318c54254) {
  self endon("race_end");
  player waittillmatch("offhand_fired", objweapon);
  self.success = 1;
  self notify("race_start");
}

function private function_abfceeedf55fde6(player, objweapon) {
  self endon("race_end");
  timeelapsed = 0;
  timeout = 5;

  while(player hasweapon(objweapon) && val::get("supers") && timeelapsed < timeout) {
    waitframe();
    timeelapsed += level.framedurationseconds;
  }

  self.failure = 1;
  self notify("race_start");
}

function superhastimedusage(superinfo) {
  if(!isDefined(superinfo)) {
    superinfo = getcurrentsuper();
  }

  if(!isDefined(superinfo)) {
    return false;
  }

  assertex(isDefined(superinfo.staticdata.var_5c8e66e22b288b33), "<dev string:x27c>");
  var_5c8e66e22b288b33 = superinfo.staticdata.var_5c8e66e22b288b33;
  return var_5c8e66e22b288b33 == "TIME";
}

function superhasammousage(superinfo) {
  if(!isDefined(superinfo)) {
    superinfo = getcurrentsuper();
  }

  if(!isDefined(superinfo)) {
    return false;
  }

  assertex(isDefined(superinfo.staticdata.var_5c8e66e22b288b33), "<dev string:x27c>");
  var_5c8e66e22b288b33 = superinfo.staticdata.var_5c8e66e22b288b33;
  return var_5c8e66e22b288b33 == "AMMO";
}

function function_97eecce0124a7b50() {
  setsuperisactive(1);
  superinfo = getcurrentsuper();
  clipammo = superinfo.staticdata.useweaponclipammo;
  stockammo = superinfo.staticdata.useweaponstockammo;

  if(isDefined(superinfo.var_2ebcbd70919376a7)) {
    clipammo = superinfo.var_2ebcbd70919376a7.clipammo;
    stockammo = superinfo.var_2ebcbd70919376a7.stockammo;
  }

  result = trygiveuseweapon(superinfo.staticdata.useweapon, clipammo, stockammo);

  if(istrue(result)) {
    setsuperisactive(1);
  } else {
    setsuperisactive(0);
  }

  return result;
}

function getsuperref() {
  superinfo = getcurrentsuper();

  if(isDefined(superinfo)) {
    return superinfo.staticdata.ref;
  }

  return undefined;
}

function function_907944a173ed27e1(superref) {
  switch (superref) {
    case #"hash_758dccf604db9844":
    case #"hash_7fabc8194cf34999":
    case #"hash_d90c2bd8c6e12ea2":
    case #"hash_d9df50cd7638b51d":
      return true;
    default:
      return false;
  }

  return false;
}

function function_868a75fd7c215c07() {
  superinfo = getcurrentsuper();

  if(!isDefined(superinfo) || !isDefined(superinfo.staticdata)) {
    return false;
  }

  return istrue(superinfo.staticdata.var_9270ee84f5a4a7a1);
}

function function_ca3ed045947e9de0(var_1501eb1bcd967969) {
  if(!function_868a75fd7c215c07()) {
    return;
  }

  superinfo = getcurrentsuper();
  pointsneeded = getsuperpointsneeded();
  var_1ee3cdaf7e0e4486 = superinfo.staticdata.var_1ee3cdaf7e0e4486;

  if(isDefined(var_1501eb1bcd967969) && isDefined(var_1ee3cdaf7e0e4486)) {
    var_1ee3cdaf7e0e4486 *= var_1501eb1bcd967969;
  }

  if(!isDefined(var_1ee3cdaf7e0e4486) || var_1ee3cdaf7e0e4486 <= 0) {
    superinfo.var_aa000a24012e5de2 = pointsneeded;
    return;
  }

  superinfo.var_aa000a24012e5de2 = pointsneeded / var_1ee3cdaf7e0e4486 * 0.05;
}