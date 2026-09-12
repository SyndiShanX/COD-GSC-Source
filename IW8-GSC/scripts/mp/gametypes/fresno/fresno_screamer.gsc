/***********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\fresno\fresno_screamer.gsc
***********************************************************/

function spawnmalfunctioningscreamerdevice(var_0, var_1) {
  var_2 = _dropscreamercrate(var_1 + (0, 0, 2500), var_1);
  var_3 = scripts\cp_mp\killstreaks\airdrop::gettriggerobject(var_2);
  var_3.ref_140A0 = 4;
  level.ref_11E18.screamercrate = var_2;
  level.ref_11E18.screamerareaorigin = var_0;
}

function endevent_malfunctioningscreamerdevice() {
  if(isDefined(level.ref_11E18.ref_12F3F) && isDefined(level.ref_11E18.ref_12F3F.owner)) {
    level.ref_11E18.ref_12F3F.owner scripts\mp\killstreaks\killstreaks::awardkillstreak("greenbay_strike", "other", undefined, undefined, undefined, 1);
    return;
  }
}

function destroyscreamer() {
  level.ref_11E18 notify("screamer_dropped");
  level.ref_11E18 notify("screamer_destroyed");

  if(isDefined(level.ref_11E18.screamercrate)) {
    level.ref_11E18.screamercrate thread scripts\cp_mp\killstreaks\airdrop::destroycrate();
    level.ref_11E18.screamercrate = undefined;
  }

  level.ref_11E18.screamerareaorigin = undefined;

  if(isDefined(level.ref_11E18.ref_12F3F)) {
    _worldiconhide(level.ref_11E18.ref_12F3F);

    if(isDefined(level.ref_11E18.ref_12F3F.owner)) {
      var_0 = scripts\mp\gametypes\br_pickups::test_ai_anim();
      _dropscreamerinternal(level.ref_11E18.ref_12F3F.owner, var_0);
      level.ref_11E18.ref_12F3F setscriptablepartstate("brloot_mendota_screamer", "disabled");
      wait 1.6;
    }

    thread _explodescreamer(level.ref_11E18.ref_12F3F.origin);

    if(isent(level.ref_11E18.ref_12F3F)) {
      level.ref_11E18.ref_12F3F delete();
    } else {
      level.ref_11E18.ref_12F3F freescriptable();
    }

    level.ref_11E18.ref_12F3F = undefined;
    return;
  }
}

function initcratedata(var_0) {
  var_1 = scripts\cp_mp\killstreaks\airdrop::getleveldata("fresno_screamer");
  var_1.capturestring = &"MP/GENERIC_LOOT_CRATE_CAPTURE";
  var_1.dummymodel = "military_carepackage_02_br";
  var_1.friendlymodel = undefined;
  var_1.enemymodel = undefined;
  var_1.mountmantlemodel = undefined;
  var_1.supportsownercapture = 0;
  var_1.headicon = undefined;
  var_1.usepriority = -1;
  var_1.usefov = 180;
  var_1.timeout = undefined;
  var_1.friendlyuseonly = 1;
  var_1.ownerusetime = 0.5;
  var_1.otherusetime = 0.5;
  var_1.capturecallback = &_cratecapturecallback;
  var_1.destroycallback = &_cratedestroycallback;
  var_1.activatecallback = &_crateactivatecallback;
  var_1.ingame = &_cratephysicsoncallback;
  var_1.ref_127FD = &_cratepostcreatecallback;
  var_1.destroyoncapture = 1;
}

function pickupscreamer(var_0) {
  var_1 = self.tracknonoobplayerlocation;
  level endon("game_ended");
  var_1 endon("death");

  foreach(var_3 in level.players) {
    if(var_3.team == var_0.team) {
      if(var_3 == var_0) {
        var_3 scripts\mp\hud_message::showsplash("br_pe_fresno_screamer_stay_close");
      }
    }
  }

  _worldiconhide(var_1);
  _worldiconshow(var_1, "picked_up", var_0);
  _hidescreamer(var_1);
  var_1.owner = var_0;
  var_0.iscarryingscreamer = 1;
  thread _carryscreamergesture(var_0);
}

function dropscreamer(var_0, var_1) {
  level.ref_11E18 notify("screamer_dropped");
  _dropscreamerinternal(var_0, var_1);
  _worldiconshow(level.ref_11E18.ref_12F3F, "on_ground");
  scripts\mp\gametypes\br_publicevents::ref_13371("br_pe_fresno_screamer_recover");

  if(istrue(var_1)) {
    thread _trackscreameroob();
    return;
  }
}

function choosescreamertitan() {
  var_0 = isDefined(level.ref_11E18.setincomingremovedcallback.ref_12930);
  var_1 = isDefined(level.ref_11E18.wait_for_next_hack_complete.ref_12930);
  level.ref_11E18.screamergg = undefined;
  level.ref_11E18.screamerkk = undefined;

  if(var_0) {
    if(!var_1 || randomintrange(0, 2) == 0) {
      level.ref_11E18.screamergg = 1;
    }
  }

  if(var_1 && !isDefined(level.ref_11E18.screamergg)) {
    level.ref_11E18.screamerkk = 1;
    return;
  }
}

function _dropscreamerinternal(var_0, var_1) {
  if(isDefined(level.ref_11E18.ref_12F3F)) {
    var_2 = scripts\engine\utility::ter_op(isPlayer(self), self, level.ref_11E18.ref_12F3F.owner);

    if(isDefined(var_2)) {
      var_2.iscarryingscreamer = 0;
    }

    if(isent(level.ref_11E18.ref_12F3F) == 0) {
      _worldiconhide(level.ref_11E18.ref_12F3F);
      level.ref_11E18.ref_12F3F freescriptable();
      level.ref_11E18.ref_12F3F = undefined;
    }
  }

  if(isDefined(level.ref_11E18.ref_12F3F) == 0) {
    if(istrue(var_1)) {
      var_3 = scripts\mp\gametypes\br_pickups::getitemdroporiginandangles(var_0, self.origin, self.angles, self, 0, 0, 10, 1);
    } else {
      var_3 = scripts\mp\gametypes\br_pickups::getitemdroporiginandangles(var_1, self.origin, self.angles, self);
    }

    level.ref_11E18.ref_12F3F = scripts\mp\gametypes\br_pickups::spawnpickup("brloot_mendota_screamer", var_3, 0, 1);
    level.ref_11E18.ref_12F3F.keepinmap = 1;
    level.ref_11E18.ref_12F3F.hidden = 0;
    return;
  }
}

function _explodescreamer(var_0) {
  var_1 = var_0 + (0, 0, -96);
  var_2 = physicstrace(var_0, var_1);
  var_3 = var_2 == var_1;
  var_4 = "detonateGround";

  if(var_3) {
    var_4 = "detonateAir";
  }

  waitframe();
  var_5 = easepower("br_carriable_explosion_base", var_2, (0, 0, 0));
  var_5 setscriptablepartstate("carrible_explode_base", var_4);
  var_5 thread scripts\mp\equipment\binoculars::hanging_crate_think(5);
}

function _trackscreameroob() {
  var_0 = self;
  level.ref_11E18 endon("screamer_destroyed");
  level endon("game_ended");
  var_0 endon("death");
  var_1 = 10;
  var_2 = 0.1;
  var_3 = -1;
  var_4 = float(level.ref_11E18.playerredeploy * level.ref_11E18.playerredeploy);

  for(;;) {
    wait var_2;

    if(isDefined(level.ref_11E18.ref_12F3F) && isDefined(level.ref_11E18.screamerareaorigin)) {
      var_5 = level.ref_11E18.ref_12F3F.origin;

      if(isDefined(level.ref_11E18.ref_12F3F.owner) && isDefined(level.ref_11E18.ref_12F3F.owner.origin)) {
        var_5 = level.ref_11E18.ref_12F3F.owner.origin;
      }

      var_6 = distance2dsquared(var_5, level.ref_11E18.screamerareaorigin);

      if(var_6 <= var_4) {
        if(var_3 >= 0) {
          level.ref_11E18.ref_12F3F notify("screamer_in_bounds");
          var_3 = -1;
        }
      } else if(var_3 <= -1) {
        var_3 = var_1;
        thread _playscreameroobalarm(level.ref_11E18.ref_12F3F);
      } else if(var_3 >= 0) {
        var_7 = int(var_3);
        var_3 -= var_2;

        if(var_3 <= 0) {
          thread destroyscreamer();
          break;
        }
      }

      continue;
    }

    break;
  }
}

function _waitscreameroobalarm(var_0) {
  var_1 = self;
  level endon("game_ended");
  level.ref_11E18 endon("screamer_destroyed");
  level.ref_11E18 endon("screamer_dropped");
  var_1 endon("death");
  var_1 scripts\engine\utility::waittill_notify_or_timeout("screamer_in_bounds", var_0);
}

function _playscreameroobalarm(var_0) {
  var_1 = self;
  var_1 notify("screamer_in_bounds");

  if(isDefined(var_1.owner)) {
    var_2 = var_1.owner;
    var_2 setclientomnvar("ui_out_of_bounds_type", 4);
    var_2 setclientomnvar("ui_out_of_bounds_countdown", int(gettime() + var_0 * 1000));
    _waitscreameroobalarm(var_1, var_0);
    var_2 setclientomnvar("ui_out_of_bounds_type", 0);
    var_2 setclientomnvar("ui_out_of_bounds_countdown", 0);
    return;
  }
}

function _hidescreamer() {
  var_0 = self;
  var_0.hidden = 1;
  var_0 setscriptablepartstate("brloot_mendota_screamer", "hidden");
}

function _worldiconshow(var_0, var_1) {
  var_2 = self;

  if(var_0 == "picked_up") {
    _setscreamericonspickedup(var_2, var_1, "ui_mp_br_mapmenu_icon_orca_objective_friendly", "ui_mp_br_mapmenu_icon_orca_objective_enemy");
    return;
  }

  if(var_0 == "on_ground") {
    var_3 = scripts\mp\objidpoolmanager::requestobjectiveid(1);

    if(var_3 != -1) {
      scripts\mp\objidpoolmanager::objective_add_objective(var_3, "current", var_2.origin + (0, 0, 50), "ui_mp_br_mapmenu_icon_orca_objective_dropped");
      scripts\mp\objidpoolmanager::update_objective_setbackground(var_3, 1);

      foreach(var_5 in level.players) {
        if(!var_5 scripts\mp\gametypes\br_public::updateinstantclassswapallowedinternal()) {
          objective_addclienttomask(var_3, var_5);
        }
      }

      objective_showtoplayersinmask(var_3);
      var_2.icon = var_3;
      thread _screamerupdateiconposition();
      return;
    }

    return;
  }
}

function _worldiconhide() {
  var_0 = self;
  var_0 notify("screamer_icon_hide");

  if(isDefined(var_0.icon)) {
    scripts\mp\objidpoolmanager::returnobjectiveid(var_0.icon);
    var_0.icon = undefined;
  }

  if(isDefined(var_0.playersetattractionstateindex)) {
    scripts\mp\objidpoolmanager::returnobjectiveid(var_0.playersetattractionstateindex);
    var_0.playersetattractionstateindex = undefined;
  }

  if(isDefined(var_0.nuke_cancel)) {
    scripts\mp\objidpoolmanager::returnobjectiveid(var_0.nuke_cancel);
    var_0.nuke_cancel = undefined;
    return;
  }
}

function _setscreamericonspickedup(var_0, var_1, var_2) {
  var_3 = self;
  var_4 = scripts\mp\objidpoolmanager::requestobjectiveid(1);

  if(var_4 != -1) {
    scripts\mp\objidpoolmanager::objective_add_objective(var_4, "current", var_3.origin, var_1);
    scripts\mp\objidpoolmanager::update_objective_setbackground(var_4, 1);
    var_5 = 0;
    thread _updatescreamericon(var_3, var_0, var_4);
    objective_removeallfrommask(var_4);
    var_6 = scripts\mp\utility\teams::getteamdata(var_0.team, "players");

    foreach(var_8 in var_6) {
      if(!var_8 scripts\mp\gametypes\br_public::updateinstantclassswapallowedinternal()) {
        objective_addclienttomask(var_4, var_8);
      }
    }

    objective_showtoplayersinmask(var_4);
    var_3.playersetattractionstateindex = var_4;
  }

  var_10 = scripts\mp\objidpoolmanager::requestobjectiveid(1);

  if(var_10 != -1) {
    scripts\mp\objidpoolmanager::objective_add_objective(var_10, "current", var_3.origin, var_2);
    scripts\mp\objidpoolmanager::update_objective_setbackground(var_10, 1);
    var_5 = 0;
    thread _updatescreamericon(var_3, var_0, var_10);
    objective_removeallfrommask(var_10);

    foreach(var_8 in level.players) {
      if(var_8 scripts\mp\gametypes\br_public::updateinstantclassswapallowedinternal() || var_8.team == var_0.team) {
        objective_addclienttomask(var_10, var_8);
      }
    }

    objective_hidefromplayersinmask(var_10);
    var_3.nuke_cancel = var_10;
    return;
  }
}

function _updatescreamericon(var_0, var_1, var_2) {
  var_3 = self;
  level.ref_11E18 endon("screamer_dropped");
  level.ref_11E18 endon("screamer_destroyed");

  if(var_2 <= 0) {
    scripts\mp\objidpoolmanager::update_objective_setzoffset(var_1, 50);
    scripts\mp\objidpoolmanager::update_objective_onentity(var_1, var_0);
    return;
  }

  for(;;) {
    if(isDefined(var_0)) {
      scripts\mp\objidpoolmanager::update_objective_position(var_1, var_0.origin + (0, 0, 50));

      if(var_0 scripts\cp_mp\utility\player_utility::isinvehicle()) {
        wait 0.1;
        continue;
      }

      wait var_2;
    }
  }
}

function _screamerupdateiconposition() {
  self notify("_screamerUpdateIconPosition");
  self endon("_screamerUpdateIconPosition");
  self endon("screamer_icon_hide");
  self endon("death");

  for(;;) {
    scripts\mp\objidpoolmanager::update_objective_position(self.icon, self.origin + (0, 0, 50));
    waitframe();
  }
}

function _carryscreamergesture(var_0) {
  var_1 = self;
  level endon("game_ended");
  var_1 endon("death_or_disconnect");
  var_1 giveweapon(var_0);
  var_1 setweaponammostock(var_0, 0);
  var_1 setweaponammoclip(var_0, 0);
  var_1 scripts\mp\supers::allowsuperweaponstow();
  var_2 = var_1 scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(var_0, 0, 1);

  if(!istrue(var_2)) {
    var_1 scripts\mp\supers::unstowsuperweapon();

    if(var_1 scripts\cp_mp\utility\inventory_utility::isswitchingtoweaponwithmonitoring(var_0)) {
      var_1 scripts\cp_mp\utility\inventory_utility::abortmonitoredweaponswitch(var_0);
    } else {
      var_1 takeweapon(var_0);
    }
  }

  var_1 scripts\common\utility::allow_killstreaks(0);
  var_1 scripts\common\utility::allow_supers(0);

  while(istrue(var_1.iscarryingscreamer)) {
    waitframe();

    if(!var_1 scripts\cp_mp\utility\inventory_utility::iscurrentweapon(var_0) || _playercanholdscreamer(var_1) == 0) {
      if(!istrue(var_1.iscarryingscreamer)) {
        var_1 thread scripts\mp\utility\inventory::switchtolastweapon();
        wait 0.5;
      }

      var_1 takeweapon(var_0);

      if(istrue(var_1.iscarryingscreamer)) {
        var_3 = scripts\mp\gametypes\br_pickups::test_ai_anim();
        dropscreamer(var_1, var_3);
      }
    }
  }

  var_1 scripts\common\utility::allow_killstreaks(1);
  var_1 scripts\common\utility::allow_supers(1);
}

function _playercanholdscreamer(var_0) {
  if(istrue(var_0.iscarryingscreamer) == 0) {
    return false;
  }

  if(var_0 isinexecutionvictim()) {
    return false;
  }

  if(istrue(var_0.inlaststand)) {
    return false;
  }

  if(var_0 scripts\cp_mp\utility\player_utility::isinvehicle()) {
    return false;
  }

  if(istrue(var_0.isreviving)) {
    return false;
  }

  if(istrue(var_0.isjuggernaut)) {
    return false;
  }

  if(var_0 ismantling()) {
    return false;
  }

  return true;
}

function _dropscreamercrate(var_0, var_1) {
  var_2 = scripts\cp_mp\killstreaks\airdrop::dropcrate(undefined, undefined, "fresno_screamer", var_0, (0, randomfloat(360), 0), var_1);

  if(isDefined(var_2)) {
    var_2.skipminimapicon = 0;
    var_2 setscriptablepartstate("objective_map", "pe_chopper_crate", 0);
    var_2.ref_13428 = spawn("script_model", var_1);
    var_2.ref_13428 setModel("ks_airdrop_crate_br");
    var_2.ref_13428 setscriptablepartstate("smoke_signal", "pe_chopper_on", 0);
  }

  return var_2;
}

function _crateactivatecallback(var_0) {}

function _cratecapturecallback(var_0) {
  if(isDefined(self.ref_13428)) {
    self.ref_13428 setscriptablepartstate("smoke_signal", "off", 0);
    self.ref_13428 delete();
  }

  level.ref_11E18.screamercrate = undefined;
  var_1 = scripts\mp\gametypes\br_pickups::test_ai_anim();
  dropscreamer(var_1, 1);
}

function _cratedestroycallback(var_0) {
  self setscriptablepartstate("objective_map", "inactive", 0);

  if(isDefined(self.ref_13428)) {
    self.ref_13428 setscriptablepartstate("smoke_signal", "off", 0);
    self.ref_13428 delete();
  }

  level.ref_11E18.screamercrate = undefined;
}

function _cratephysicsoncallback(var_0, var_1) {
  self setscriptablepartstate("crate_audio", "detach", 0);
}

function _cratepostcreatecallback() {
  self setscriptablepartstate("model", "friendly", 0);
}