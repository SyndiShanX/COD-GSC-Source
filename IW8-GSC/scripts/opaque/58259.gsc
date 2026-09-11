/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\opaque\58259.gsc
***********************************************/

function randomoffsetmortar() {
  return getdvarfloat("scr_serum_gadget_damage_scalar", 1.5);
}

function start_serum_gadget(var0, var1) {
  if(self isthrowingbackgrenade()) {
    self method_87a9();

    if(isDefined(var1)) {
      var2 = self getweaponammoclip(var1);
      var3 = int(max(var2 - 1, 0));
      self setweaponammoclip(var1, var3);
    }
  }

  var4 = "serum_gadget";
  var5 = accesscardsspawned_red::preinfilstreamfunc();

  if(!isDefined(var0)) {
    var0 = getdvarint("scr_serum_gadget_duration_seconds", 40);
  }

  if(!isDefined(var5) || var5 != var4) {
    GscBinSkip4(0x35, var0);
  }

  var6 = getdvarfloat("scr_serum_gadget_moverate", 1.08);
  var7 = "adrenalinesuit_mp";
  var8 = "zombiedefault";
  var9 = 1;
  accesscardsspawned_red::ref_1380c(var4, var0, var6, var7, var8, var9);
}

function stop_serum_gadget() {
  var0 = accesscardsspawned_red::preinfilstreamfunc();

  if(isDefined(var0) && var0 == "serum_gadget") {
    accesscardsspawned_red::ref_138c8();
    return;
  }
}

function _watch_serum_vehicle_exit() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("stop_speed_boost_serum_gadget");

  for(;;) {
    self waittill("player_vehicle_exit");
    scripts\cp_mp\utility\game_utility::_visionsetnakedforplayer("rage_serum", 0);
  }
}

function apc_rus_update(var0) {
  level endon("game_ended");
  self endon("disconnect");
  self waittill("start_speed_boost_serum_gadget");
  scripts\mp\utility\perk::giveperk("serum_gadget");
  scripts\cp_mp\utility\game_utility::_visionsetnakedforplayer("rage_serum", 1.5);

  if(self getscriptablehaspart("rageSerumVFX")) {
    self setscriptablepartstate("rageSerumVFX", "active");
  }

  scripts\mp\gamelogic::sethasdonecombat(self, 1);
}

function apc_rus_updatedriverturretammoui() {
  level endon("game_ended");
  self endon("disconnect");
  self waittill("stop_speed_boost_serum_gadget");
  scripts\mp\utility\perk::removeperk("serum_gadget");

  if(self isscriptable() && self getscriptablehaspart("rageSerumVFX") && self getscriptablepartstate("rageSerumVFX") == "active") {
    if(!scripts\mp\utility\player::isreallyalive(self)) {
      self setscriptablepartstate("rageSerumVFX", "neutral");
    } else {
      self setscriptablepartstate("rageSerumVFX", "deactivate");
      self playlocalsound("rage_serum_local_player_end");
    }
  }

  scripts\cp_mp\utility\game_utility::_visionsetnakedforplayer("", 3);
}