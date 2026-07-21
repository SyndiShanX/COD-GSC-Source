/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\br_sudden_death.gsc
***********************************************/

init() {
  level.disable_super_in_turret._id_1395E = [];
  level.disable_super_in_turret._id_13962 = getdvarint("_encstr_B29714D8CF32D6FD13F99E2DC13ADF5B860BE8C077F6", 15);
  level.disable_super_in_turret._id_13960 = getdvarint("_encstr_BABF17E68D9CFA4C27FADC91AF1BD2E4C663ACEB19953685F2", 0);
  level.disable_super_in_turret._id_13961 = getdvarint("_encstr_842E17F3D61046061607FA8597B09FE3CA39378902A64525C8", 3);
  level.disable_super_in_turret._id_1395F = getdvarint("_encstr_99E7170E896AD972B21FAEDD97F83ABB22E111F70863E28303", 1);
  scripts\mp\flags::gameflaginit("_encstr_8201151FD310A9EF20E12D4531630B3F6BD96FAA990A3C", 0);
  scripts\mp\flags::gameflaginit("_encstr_A13116CE25EA45AAD3C1BBB051A5FC612EA017EB40A39037", 0);
}

start(var_0) {
  addthrowingknifecharge();
  scripts\mp\flags::gameflagset("_encstr_8201151FD310A9EF20E12D4531630B3F6BD96FAA990A3C");
  ambusher_spawn_func();
  adsoff(var_0);
  thread ampeddelta(var_0);
  level waittill("_encstr_AC901D8F2377882118300BA7A1758047BF70A17B184F58F7FAE8CA2BB060CA");
  thread anim_guy_keep_hidden(var_0);
  wait(level.disable_super_in_turret._id_13960 + level.disable_super_in_turret._id_1395F);
  ai_operate_turret();
  adrenaline_crate_use();
  ally_manager();
  level.disablespawning = 1;
  scripts\mp\flags::gameflagwait("_encstr_A13116CE25EA45AAD3C1BBB051A5FC612EA017EB40A39037");
  return level.disable_super_in_turret._id_1395E["_encstr_A6B10C81E0BF04A050FFEC5A3983"];
}

addthrowingknifecharge() {
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_13F25("_encstr_8106123B24BF78D3DBDC083511D5719BA1AE6345");

  if(_encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::unset_relic_aggressive_melee("_encstr_BA32084FFD08358F1C99")) {
    level.disablespawning = 1;
    setdynamicdvar("_encstr_AF1805EFE726E9" + scripts\mp\utility\game::getgametype() + "_encstr_A5B70A7E58D31199826EB896", 1);
  }

  level.ondeadevent = ::allowed_gametypes;
}

ambusher_spawn_func() {
  foreach(var_1 in level.players)
  var_1 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_1264C();
}

adsoff(var_0) {
  if(isDefined(var_0.has_ammo_drain_passive))
    [[var_0.has_ammo_drain_passive]](var_0._id_1367F);
}

ampeddelta(var_0) {
  foreach(var_2 in level.players) {
    var_2 notify("_encstr_8201151FD310A9EF20E12D4531630B3F6BD96FAA990A3C");
    var_3 = var_2[[var_0._id_13688]](var_0._id_1367F);
    var_2 thread amped_wid(var_3);
  }

  wait 2;
  level notify("_encstr_AC901D8F2377882118300BA7A1758047BF70A17B184F58F7FAE8CA2BB060CA");
}

amped_wid(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self._id_12CA8 = 1;
  self.plotarmor = 1;
  self.forcespawnorigin = var_0.origin;
  self.forcespawnangles = var_0.angles;
  scripts\mp\playerlogic::spawnplayer(0);

  if(istrue(self.delay_enter_combat_after_investigating_grenade))
    _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::_id_13F21(self);

  waitframe();
  scripts\mp\outofbounds::clearoob(self);
  _encstr_B89622B91BE42DE0E8DC976B0779EC0BB695E8973856B9CBC427FA2CE4DADB93173B9B1B::searchcirclesize(1);
  _encstr_97D524A791FAFBB85348207081058F9E8D173930515956F05175FF83A22FCF97B870E5B7FBB7::debug_spawncover_badnodetest();
  self._id_12CA8 = undefined;
}

ai_operate_turret() {
  foreach(var_1 in level.players)
  var_1 scripts\mp\playerlogic::playerprematchallow(0);
}

ally_manager() {
  foreach(var_1 in level.players) {
    var_1 thread _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::defend_wave_2();
    var_1 scripts\mp\playerlogic::playerprematchallow(1);
    var_1.plotarmor = undefined;
    var_1 setclientomnvar("_encstr_96A91957B4AF6B853A36A1FACD8EB0E4A3F56CBDBAB9E891ED77E6", 0);
    var_1 setclientomnvar("_encstr_82231507E01F6D82E3468271C14A010815DFEFFDB550B7", 1);
    var_1 thread _id_12696();
  }
}

adrenaline_crate_use() {
  level scripts\mp\gamelogic::livelobbymatchstarttimer("_encstr_84C0125139B36BF2595A283FF65BC7EB916642CD", level.disable_super_in_turret._id_13962);
}

_id_12696() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self setclientomnvar("_encstr_BAE912ED0CA18F0122D720908F56B9B7BBB7E3F5", 0);
  wait 5;
  self setclientomnvar("_encstr_BAE912ED0CA18F0122D720908F56B9B7BBB7E3F5", -1);
}

anim_guy_keep_hidden(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 = var_0.guard_spawners;
  _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::teleport_players_inside_subway_car(var_1, level.disable_super_in_turret._id_13960, level.disable_super_in_turret._id_13961, level.disable_super_in_turret._id_1395F, level.disable_super_in_turret._id_13962);
}

allowed_gametypes(var_0) {
  scripts\mp\gamelogic::default_ondeadevent(var_0);
  ai_ascender_getclosestascender(var_0);
}

ai_ascender_getclosestascender(var_0) {
  level.disable_super_in_turret._id_1395E["_encstr_A6B10C81E0BF04A050FFEC5A3983"] = var_0;
  scripts\mp\flags::gameflagset("_encstr_A13116CE25EA45AAD3C1BBB051A5FC612EA017EB40A39037");
}