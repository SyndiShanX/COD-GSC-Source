/********************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\gametypes\br_publicevent_lootcratedrop.gsc
********************************************************************/

#using script_261e315c49e5e4ef;
#using scripts\common\utility;
#using scripts\cp_mp\killstreaks\airdrop;
#using scripts\engine\utility;
#using scripts\mp\gametypes\br_circle;
#using scripts\mp\gametypes\br_lootcache;
#using scripts\mp\gametypes\br_lootchopper;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\gametypes\br_publicevents;
#using scripts\mp\gametypes\br_supply_drops_common;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\utility\game;
#using scripts\mp\utility\perk;
#namespace br_publicevent_lootcratedrop;

function autoexec main() {
  scripts\mp\gametypes\br_publicevents::function_dbc8f6cb3760cd82(%"lootcratedrop", &function_a84cf6614b8b31e);
}

function function_a84cf6614b8b31e(eventinfo) {
  eventinfo.validatefunc = &function_a78763ea0cf7510e;
  eventinfo.activatefunc = &function_71b5f57cd836a45d;
  eventinfo.postinitfunc = &function_e85cf8591ec416e4;
  scripts\engine\utility::registersharedfunc("br_cashcrate", "cashCrate_onCrateUse", &function_fc6fffaed5b50c85);
}

function initweaponcrate(eventinfo) {}

function function_51c524af89207cd5(eventinfo) {}

function function_e85cf8591ec416e4() {
  thread function_fae94a598dce531e();
  postinitfunc();
}

function function_87e6691e7d8c03ac() {
  postinitfunc();
}

function function_a77e39e3a8937837() {
  postinitfunc();
}

function postinitfunc() {
  if(isDefined(level.var_9b34d707b8d9d76)) {
    return;
  }

  level.var_9b34d707b8d9d76 = 1;
  game["dialog"]["cash_drop"] = "cash_grav_ncmn";
  game["dialog"]["weapon_drop"] = "drop_resupply";
  game["dialog"]["medical_drop"] = "medical_announcement";
  level.conf_fx["vanish"] = loadfx("vfx/core/impacts/small_snowhit");
}

function function_a78763ea0cf7510e() {
  return true;
}

function function_1d60c987a31953a6() {
  return true;
}

function function_599c8b86b0fede65() {
  return true;
}

function function_71b5f57cd836a45d() {
  activateinternal(3);
}

function function_183f7f5ceb7a8f3b() {
  activateinternal(1);
}

function function_921e8477fdbb38ba() {
  activateinternal(2);
}

function activateinternal(var_afb1e307ca3c0ed7) {
  level.var_6a7847bed8f16264 = getdvarfloat(@ "hash_302f97714cae9d45", 1);
  crateinfo = spawnStruct();

  switch (var_afb1e307ca3c0ed7) {
    case 3:
      level.var_eaf636cc14e840ae = getdvarint(@ "hash_73e1b59a77872e46", 15000);
      level thread scripts\mp\gametypes\br_lootchopper::init();
      level thread scripts\cp_mp\killstreaks\airdrop::function_53a94fee5954af57();
      crateinfo.var_b5af62407c69adc9 = "battle_royale_cash_crate";
      crateinfo.var_5411956fb9cdc64d = "active";
      crateinfo.var_cf327c477c7cd3f0 = "cashdrop_common_world";
      crateinfo.var_2833481bef266a60 = "on";
      crateinfo.var_73028fdd377ed0c4 = "br_plunder_pe_cash_drop_active";
      crateinfo.var_548d317a24c84e75 = "splash_list_jup_br";
      crateinfo.var_7a39e7c938990279 = "cash_drop";
      level.var_2831ff636b688bf5 = 0;
      break;
  }

  leveldata = scripts\cp_mp\killstreaks\airdrop::getleveldata(crateinfo.var_b5af62407c69adc9);
  leveldata.capturestring = &"MP/GENERIC_LOOT_CRATE_CAPTURE";
  leveldata.minimapicon = undefined;

  if(isDefined(leveldata.var_c9042cdfe65fb49d)) {
    crateinfo.var_5411956fb9cdc64d = leveldata.var_c9042cdfe65fb49d;
  }

  if(!istrue(leveldata.disablesplash) && isDefined(crateinfo.var_73028fdd377ed0c4)) {
    scripts\mp\gametypes\br_publicevents::showsplashtoall(crateinfo.var_73028fdd377ed0c4, crateinfo.var_548d317a24c84e75);
  }

  scripts\mp\gametypes\br_public::brleaderdialog(crateinfo.var_7a39e7c938990279, 1);
  numcrates = getdvarint(@ "hash_3cb6406502812dc6", 10);
  level.var_2a89743460772ea0 = [];
  namespace_f51c41a139e03299::function_607167c18661377b([1], "pe_crate_drop");
}

function function_1e632783fe9d057d(dropend, dropstruct) {
  leveldata = scripts\cp_mp\killstreaks\airdrop::getleveldata("battle_royale_cash_crate");
  crateowner = undefined;
  crateteam = undefined;
  cratetype = "battle_royale_cash_crate";
  cratestartposition = (dropend[0], dropend[1], 0) + (0, 0, level.var_5d2af95280a3cf58);
  var_90d4fe050e6864d4 = (0, randomfloat(360), 0);
  cratedestination = dropend;
  crate = scripts\cp_mp\killstreaks\airdrop::dropcrate(crateowner, crateteam, cratetype, cratestartposition, var_90d4fe050e6864d4, cratedestination);

  if(!isDefined(crate)) {
    return;
  }

  if(!istrue(leveldata.var_9ea9e33fa2a90171)) {
    crate setscriptablepartstate("trail", "active", 0);
    crate.smokesignal = spawn("script_model", cratestartposition + (0, 0, 58));
    crate.smokesignal setModel("ks_airdrop_crate_br");
    crate.smokesignal linkTo(crate);
    crate.smokesignal setscriptablepartstate("smoke_trail", "on");
  }

  triggerobject = scripts\cp_mp\killstreaks\airdrop::gettriggerobject(crate);
  triggerobject.usetimeoverride = level.var_6a7847bed8f16264;
  objid = scripts\mp\objidpoolmanager::requestobjectiveid(99);

  if(objid != -1) {
    crate setscriptablepartstate("objective_map", "hidden");
    scripts\mp\objidpoolmanager::objective_add_objective(objid, "current", crate.origin, "ui_map_icon_cash_drop");
    scripts\mp\objidpoolmanager::update_objective_setbackground(objid, 5);
    scripts\mp\objidpoolmanager::function_d7e3c4a08682c1b9(objid, 1);
    scripts\mp\objidpoolmanager::update_objective_onentity(objid, crate);
    scripts\mp\objidpoolmanager::update_objective_setzoffset(objid, 75);
    scripts\mp\objidpoolmanager::function_2946e9eb07acb3f1(objid, &"MP_BR_INGAME/CASH_DROP");
    scripts\mp\objidpoolmanager::objective_set_play_intro(objid, 0);
    scripts\mp\objidpoolmanager::objective_set_play_outro(objid, 0);
    scripts\mp\objidpoolmanager::function_98ba077848896a3(objid, 1);
    var_fbe99be3716910ed = getdvarint(@ "hash_db57480d855ab212", 20000);
    scripts\mp\objidpoolmanager::function_f21e9b2e78de984b(objid, var_fbe99be3716910ed, var_fbe99be3716910ed + 1000);
    scripts\mp\objidpoolmanager::function_846c2acd91309cd8(objid, 151, 171, 128);

    foreach(player in level.players) {
      if(isalive(player) && !isbot(player) && !player scripts\mp\gametypes\br_public::isplayeringulag()) {
        scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(objid, player);
      }
    }

    crate.scriptedobjid = objid;
  } else {
    crate setscriptablepartstate("objective_map", "cashdrop_common_world");
  }

  crate.nevertimeout = 1;
  crate.var_13ba232eee7e6069 = "ks_airdrop_crate_br";
  level.var_2a89743460772ea0[level.var_2a89743460772ea0.size] = crate;
  return crate;
}

function function_fc6fffaed5b50c85(player) {
  self.itemsdropped = 0;

  if(!isDefined(level.var_87252118c429bd32)) {
    level.var_87252118c429bd32 = 0;
  } else {
    level.var_87252118c429bd32 = (level.var_87252118c429bd32 + 1) % 10;
  }

  items = getscriptcachecontents("pe_crate_drop", level.var_87252118c429bd32);

  if(isDefined(items) && player scripts\mp\utility\perk::_hasperk("specialty_br_extra_killstreak_chance")) {
    items = scripts\mp\gametypes\br_lootcache::lootcontentsadjustkillchain(items, player);
  }

  if(isDefined(items)) {
    pickupents = scripts\mp\gametypes\br_lootcache::lootcachespawncontents(items, 0, player);
  }

  if(!isDefined(player.lootcachesopened)) {
    player.lootcachesopened = 1;
  } else {
    player.lootcachesopened++;
  }

  if(isDefined(self.scriptedobjid)) {
    objective_delete(self.scriptedobjid);
    scripts\mp\objidpoolmanager::returnobjectiveid(self.scriptedobjid);
    self.scriptedobjid = undefined;
  }

  if(scripts\mp\utility\game::getsubgametype() == "risk" || scripts\mp\utility\game::getsubgametype() == "plunder") {
    player scripts\mp\gametypes\br_public::updatebrscoreboardstat("lootCachesOpened", player.lootcachesopened);
  }
}

function function_fae94a598dce531e() {
  level waittill("br_supply_drops_init");
  dropstruct = scripts\mp\gametypes\br_supply_drops_common::function_69b2e5235bfb7998("pe_crate_drop", "military_carepackage_03_br", undefined, &function_fc6fffaed5b50c85);
  dropstruct scripts\mp\gametypes\br_supply_drops_common::function_80e49e34fc8d70b8("pe_crate_drop", "spawnDropCrate", &function_1e632783fe9d057d);
  dropstruct scripts\mp\gametypes\br_supply_drops_common::function_80e49e34fc8d70b8("pe_crate_drop", "onPlayerEnterGulag", &function_ae1a3e74689d656a);
  dropstruct scripts\mp\gametypes\br_supply_drops_common::function_80e49e34fc8d70b8("pe_crate_drop", "onPlayerRespawn", &onplayerrespawn);
  dropstruct.var_30daf66a65a215e7 = 1;
  var_22d14235b5749883 = getdvarint(@ "hash_6e2a7271b0aaecd4", 8000);
  dropstruct.var_81986b2d8e843970 = var_22d14235b5749883 * var_22d14235b5749883;
  game["dialog"]["dropbag_incoming"] = "drpb_grav_gmst";
}

function deactivate() {
  foreach(crate in level.var_2a89743460772ea0) {
    if(!isDefined(crate)) {
      continue;
    }

    playFX(level.conf_fx["vanish"], crate.origin);

    if(isDefined(crate.smokesignal)) {
      crate.smokesignal setscriptablepartstate("smoke_signal", "off", 0);
      crate.smokesignal delete();
    }

    crate scripts\cp_mp\killstreaks\airdrop::deletecrateimmediate();
    level.var_2a89743460772ea0 = array_remove(level.var_2a89743460772ea0, crate);
  }
}

function function_a7b6924c27b24419(safecircles) {
  weightedsum = 0;

  foreach(circle in safecircles) {
    weightedsum += circle.radius;
  }

  return weightedsum;
}

function function_33edfefab8f13307(safecircles, chosenweight) {
  weightedsum = 0;

  foreach(circle in safecircles) {
    weightedsum += circle.radius;

    if(chosenweight <= weightedsum) {
      return circle;
    }
  }

  return undefined;
}

function function_24d2f715eea2a268(dangercircleorigin, var_1062ad70c2ee0fd1, var_5cae8dadbf316a7d) {
  var_dcb13e0878fb0dd4 = function_fcc289142135e1a4(dangercircleorigin, var_1062ad70c2ee0fd1, var_5cae8dadbf316a7d);
  droppoint = scripts\mp\gametypes\br_circle::getrandompointinboundscircle(var_dcb13e0878fb0dd4.origin, var_dcb13e0878fb0dd4.radius, 0, 0.85, 1, 1);
  return droppoint;
}

function function_fcc289142135e1a4(dangercircleorigin, var_1062ad70c2ee0fd1, var_5cae8dadbf316a7d) {
  var_a372a079062548cc = distance2d(dangercircleorigin, var_1062ad70c2ee0fd1);
  var_bbe4c8002c4744ea = int(var_5cae8dadbf316a7d / 2);

  if(var_a372a079062548cc != 0) {
    var_b7f1626973b3920b = int(var_1062ad70c2ee0fd1[0] - var_bbe4c8002c4744ea / var_a372a079062548cc * (var_1062ad70c2ee0fd1[0] - dangercircleorigin[0]));
    var_b7f1616973b38fd8 = int(var_1062ad70c2ee0fd1[1] - var_bbe4c8002c4744ea / var_a372a079062548cc * (var_1062ad70c2ee0fd1[1] - dangercircleorigin[1]));
  } else {
    var_b7f1626973b3920b = int(dangercircleorigin[0]);
    var_b7f1616973b38fd8 = int(dangercircleorigin[1]);
  }

  var_b7f1646973b39671 = 0;
  var_dcb13e0878fb0dd4 = spawnStruct();
  var_dcb13e0878fb0dd4.origin = (var_b7f1626973b3920b, var_b7f1616973b38fd8, var_b7f1646973b39671);
  var_dcb13e0878fb0dd4.radius = var_bbe4c8002c4744ea;
  return var_dcb13e0878fb0dd4;
}

function function_ae1a3e74689d656a() {
  if(!isDefined(self) || !isDefined(level.var_2a89743460772ea0)) {
    return;
  }

  foreach(crate in level.var_2a89743460772ea0) {
    if(!isDefined(crate) || !isDefined(crate.scriptedobjid)) {
      continue;
    }

    scripts\mp\objidpoolmanager::objective_playermask_hidefrom(crate.scriptedobjid, self);
  }
}

function onplayerrespawn() {
  if(!isDefined(self) || !isDefined(level.var_2a89743460772ea0)) {
    return;
  }

  foreach(crate in level.var_2a89743460772ea0) {
    if(!isDefined(crate) || !isDefined(crate.scriptedobjid)) {
      continue;
    }

    scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(crate.scriptedobjid, self);
  }
}