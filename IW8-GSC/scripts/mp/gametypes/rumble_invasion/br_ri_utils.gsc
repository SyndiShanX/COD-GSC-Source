/****************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\rumble_invasion\br_ri_utils.gsc
****************************************************************/

function assignclientmatchdataid() {
  if(getdvarint("scr_ri_boost_enable", 1) == 1) {
    var0 = "incursion_boost";
    var1 = accesscardsspawned_red::preinfilstreamfunc();
    var2 = getdvarint("scr_ri_boost_duration", 30);

    if(!isDefined(var1) || var1 != var0) {
      thread apc_rus_postmoddamagecallback();
      thread ammobox_updateheadicononjointeam();
      thread _watch_incursion_timer(var2);
      thread _watch_incursion_boost_deactivate();
    }

    var3 = getdvarfloat("scr_ri_boost_scale", 1.5);
    var4 = "actionhero_mp";
    var5 = "zombiedefault";
    var6 = 1;
    thread accesscardsspawned_red::ref_1380c(var0, var2, var3, var4, var5, var6);
    return;
  }
}

function isdragonsbreath() {
  var0 = accesscardsspawned_red::preinfilstreamfunc();

  if(isDefined(var0) && var0 == "incursion_boost") {
    accesscardsspawned_red::ref_138c8();
    return;
  }
}

function apc_rus_postmoddamagecallback() {
  level endon("game_ended");
  self endon("disconnect");
  self waittill("start_speed_boost_incursion_boost");
  self setclientomnvar("ui_privateevent_timer_type", 4);
  self notify("force_regeneration");
}

function _watch_incursion_timer(var0) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("stop_speed_boost_incursion_boost");

  for(;;) {
    var1 = gettime() + var0 * 1000;
    self setclientomnvar("ui_privateevent_timer", var1);
    self waittill("speed_boost_incursion_boost_timer_reset", var0);
  }
}

function _watch_incursion_boost_deactivate() {
  level endon("game_ended");
  self endon("disconnect");
  self waittill("stop_speed_boost_incursion_boost");
  self setclientomnvar("ui_privateevent_timer_type", 0);
}

function ammobox_updateheadicononjointeam() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("stop_speed_boost_incursion_boost");
  scripts\engine\utility::waittill_all_in_array(["begin_firing", "start_speed_boost_incursion_boost"]);
  isdragonsbreath();
}