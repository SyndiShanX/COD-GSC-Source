/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\common.gsc
*********************************************/

setupcommoncallbacks() {
  level.onnormaldeath = ::onnormaldeath;
  level.onsuicidedeath = ::onsuicidedeath;
  level.onteamscore = ::onteamscore;
  scripts\mp\utility::registerdogtagsenableddvar(level.gametype, 0);
  level._effect["protection_cameraFX"] = loadfx("vfx\iw7\_requests\mp\vfx_adrenaline_drip_heal_scrn.vfx");
}

updategametypedvars() {
  level.dogtagsenabled = scripts\mp\utility::istrue(scripts\mp\utility::getwatcheddvar("dogtags"));
  if(level.dogtagsenabled) {
    scripts\mp\gametypes\obj_dogtag::init();
  }
}

onnormaldeath(var_0, var_1, var_2, var_3, var_4) {
  var_5 = level.scoremod["death"] * -1;
  if(var_5 != 0) {
    if(level.teambased) {
      level scripts\mp\gamescore::giveteamscoreforobjective(var_0.pers["team"], var_5, 0);
    } else {
      var_1 scripts\mp\gamescore::giveplayerscore("kill", var_5);
    }
  }

  var_6 = level.scoremod["kill"];
  if(var_3 == "MOD_HEAD_SHOT") {
    var_6 = var_6 + level.scoremod["headshot"];
  }

  if(scripts\mp\utility::istrue(level.supportcranked)) {
    if(scripts\mp\utility::matchmakinggame() && isDefined(var_1.cranked)) {
      var_6 = var_6 + 1;
      var_1 thread scripts\mp\rank::scoreeventpopup("teamscore_notify_" + var_6);
    }

    var_1 scripts\mp\utility::oncranked(var_0, var_1, var_2);
  }

  if(var_6 != 0) {
    if(level.teambased) {
      level scripts\mp\gamescore::giveteamscoreforobjective(var_1.pers["team"], var_6, 0);
    } else {
      var_1 scripts\mp\gamescore::giveplayerscore("kill", var_6);
    }
  }

  if(level.dogtagsenabled && scripts\mp\utility::gameflag("prematch_done")) {
    level thread scripts\mp\gametypes\obj_dogtag::spawndogtags(var_0, var_1, "new_tag_spawned");
  }
}

onsuicidedeath(var_0) {
  if(scripts\mp\utility::istrue(level.supportcranked)) {
    var_0 scripts\mp\utility::cleanupcrankedplayertimer();
  }

  if(isDefined(level.scoremod)) {
    var_1 = level.scoremod["death"] * -1;
    if(var_1 != 0) {
      if(level.teambased) {
        level scripts\mp\gamescore::giveteamscoreforobjective(var_0.pers["team"], var_1, 0);
        return;
      }
    }
  }
}

onteamscore(var_0) {
  if(scripts\mp\utility::istrue(level.supportcranked)) {
    var_0 scripts\mp\utility::cleanupcrankedplayertimer();
  }
}

dogtagallyonusecb(var_0) {}

dogtagenemyonusecb(var_0) {}

onspawnplayer() {
  if(scripts\mp\utility::istrue(level.spawnprotectiontimer) && !scripts\mp\spawnlogic::shoulduseteamstartspawn()) {
    thread managespawnprotection();
  }
}

managespawnprotection() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("remove_spawn_protection");
  thread applyspawnprotection();
  wait(level.spawnprotectiontimer);
  removespawnprotection();
}

applyspawnprotection() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  self endon("remove_spawn_protection");
  self waittill("spawned_player");
  self setclientomnvar("ui_uplink_carrier_hud", 1);
  self.spawnprotection = 1;
  scripts\mp\lightarmor::setlightarmorvalue(self, 1000, undefined, 1);
  self setclientomnvar("ui_uplink_carrier_armor", 100);
  self setclientomnvar("ui_uplink_carrier_armor_max", 100);
}

removespawnprotection() {
  if(isDefined(self)) {
    self setclientomnvar("ui_uplink_carrier_hud", 0);
    self.spawnprotection = 0;
  }

  scripts\mp\lightarmor::lightarmor_unset(self);
  self setclientomnvar("ui_uplink_carrier_armor", -1);
  self notify("remove_spawn_protection");
}