/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\player\playerchatter.gsc
***********************************************/

init_playerchatter() {
  anim.player.battlechatter = spawnStruct();
  anim.player.battlechatter.countryid = _id_85A362E6438F6D7C();
  anim.player.battlechatter.enemyclass = "soldier";
}

_id_85A362E6438F6D7C() {}

player_battlechatter_on_thread() {}

player_update_allowed_callouts() {}

player_battlechatter_off_thread() {}

playerthreadthreader() {}

playerdamagewaiter() {}

playerdogfightwaiter() {}

playervehiclewaiter() {}

playeranimnameswitch() {
  _id_6447507436D93EAA = getEntArray("player", "classname")[0];
  player_update_allowed_callouts();
  anim.player = _id_6447507436D93EAA;

  if(!isDefined(anim.player.team))
    anim.player.team = "allies";

  player_update_allowed_callouts();
  level.bcs_maxthreatdistsqrdfromplayer = squared(5000);
  level.bcs_maxtalkingdistsqrdfromplayer = squared(3000);
  level.bcs_maxstealthdistsqrdfromplayer = squared(1500);
  anim.teamthreatcalloutlimittimeout = 120000;
  init_playerchatter();
}

player_battlechatter_cooldown_control() {
  anim.player.bcscooldown = 1;

  while(isalive(anim.player) && _id_35DE402EFC5ACFB3::bcsenabled() && (isDefined(anim.player.battlechatterallowed) && anim.player.battlechatterallowed)) {
    if(anim.player.bcscooldown == 0)
      _id_6F89268F7DDF91D0 = 10;
    else
      _id_6F89268F7DDF91D0 = anim.player.bcscooldown;

    anim.player.battlechatter.isspeaking = 1;

    for(_id_AC0E594AC96AA3A8 = _id_6F89268F7DDF91D0; _id_AC0E594AC96AA3A8 >= 0; _id_AC0E594AC96AA3A8--) {
      anim.player.bcscooldown = _id_AC0E594AC96AA3A8;
      wait 1.0;
    }

    anim.player.battlechatter.isspeaking = 0;
    level waittill("player_battlechatter_refresh");

    while(anim.player.battlechatter.isspeaking != 0)
      wait 0.5;
  }
}

player_battlechatter_generic_event_check() {
  anim.player endon("death");
  level endon("player_battlechatter_off");
  _id_55857D064315AF9A = "none";
  _id_4C77014045A2A7E4 = ["pc_ammocrate_pickup", "pc_equipcrate_pickup", "pc_weapon_scanned", "pc_armory_door", "pc_clear_last_event"];

  for(;;) {
    event = scripts\engine\utility::waittill_any_in_array_return(_id_4C77014045A2A7E4);

    if(event != _id_55857D064315AF9A && event != "pc_clear_last_event") {
      _id_55857D064315AF9A = event;
      thread player_battlechatter_event_clear();
    } else if(event == "pc_clear_last_event")
      _id_55857D064315AF9A = "none";

    wait 1;
  }
}

player_battlechatter_event_clear() {
  wait 10;
  level notify("pc_clear_last_event");
}

player_battlechatter_check_for_crate_pickups() {
  anim.player endon("death");
  level endon("player_battlechatter_off");
}

isvalidplayerevent(_id_C8E45A76E02E159E) {
  if(!isDefined(self.squad.ismembersaying[_id_C8E45A76E02E159E]) || !isDefined(anim.isteamsaying[self.team][_id_C8E45A76E02E159E]))
    return 1;

  if(!self.squad.ismembersaying[_id_C8E45A76E02E159E] && !anim.isteamsaying[self.team][_id_C8E45A76E02E159E])
    return 1;

  return 0;
}