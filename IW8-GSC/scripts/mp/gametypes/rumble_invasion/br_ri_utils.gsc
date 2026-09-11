/****************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\rumble_invasion\br_ri_utils.gsc
****************************************************************/

function assignclientmatchdataid() {
  if(getdvarint("scr_ri_boost_enable", 1) == 1) {
    var_0 = "incursion_boost";
    var_1 = accesscardsspawned_red::preinfilstreamfunc();
    var_2 = getdvarint("scr_ri_boost_duration", 30);

    if(!isDefined(var_1) || var_1 != var_0) {
      thread apc_rus_postmoddamagecallback();
      thread ammobox_updateheadicononjointeam();
      thread _watch_incursion_timer(var_2);
      thread _watch_incursion_boost_deactivate();
    }

    var_3 = getdvarfloat("scr_ri_boost_scale", 1.5);
    var_4 = "actionhero_mp";
    var_5 = "zombiedefault";
    var_6 = 1;
    thread accesscardsspawned_red::ref_1380c(var_0, var_2, var_3, var_4, var_5, var_6);
    return;
  }
}

function isdragonsbreath() {
  var_0 = accesscardsspawned_red::preinfilstreamfunc();

  if(isDefined(var_0) && var_0 == "incursion_boost") {
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

function _watch_incursion_timer(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("stop_speed_boost_incursion_boost");

  for(;;) {
    var_1 = gettime() + var_0 * 1000;
    self setclientomnvar("ui_privateevent_timer", var_1);
    self waittill("speed_boost_incursion_boost_timer_reset", var_0);
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