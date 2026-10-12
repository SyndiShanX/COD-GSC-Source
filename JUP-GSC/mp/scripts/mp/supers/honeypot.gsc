/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\supers\honeypot.gsc
***********************************************/

#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\mp\battlechatter_mp;
#using scripts\mp\hud_message;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\supers;
#using scripts\mp\utility\game;
#using scripts\mp\utility\outline;
#using scripts\mp\utility\points;
#namespace honeypot;

function function_99877ccd9f1a6857() {
  scripts\mp\hud_message::showerrormessage("T10_SPLASHES/HONEYPOT_ACTIVATED");
  thread function_b26e128f86f6c616();
  function_48b5e3c65db5d684();
  self setclientomnvar("ui_player_using_honeypot", 1);
  callback::add("player_disconnect", &onplayerdisconnect);
  level thread scripts\mp\battlechatter_mp::trysaylocalsound(self, #"bc_fieldupgrade_action_honeypot");
  return true;
}

function function_c91188ff5b13a34b(attacker) {
  callback::remove("player_disconnect", &onplayerdisconnect);

  if(isDefined(attacker)) {
    attacker thread doscoreevent(#"hash_31f908e35922e19d");
  }

  function_68972bb1dc676870();
  self setclientomnvar("ui_player_using_honeypot", 0);

  if(istrue(self.ishvt)) {
    scripts\mp\utility\outline::_hudoutlineviewmodelenable("outlinefill_friendly_hvt", 0);
  }

  return false;
}

function onplayerdisconnect(params) {
  function_68972bb1dc676870();
}

function private function_b26e128f86f6c616() {
  self endon("death");
  var_661d5ce8e9d7fe6f = getcurrentsuper();
  wait var_661d5ce8e9d7fe6f.staticdata.usetime;
  thread doscoreevent(#"hash_75aa6e3148836dbe");
}

function function_9bc4debdef524e6a() {
  function_e3e3e81453fd788b(#"hash_a4813385211b092c");
}

function private function_48b5e3c65db5d684() {
  self.var_d8939daf9b3e461b = scripts\mp\objidpoolmanager::requestobjectiveid(1);
  objid = self.var_d8939daf9b3e461b;
  objective_icon(objid, "hud_icon_death_spawn");
  objective_setplayintro(objid, 1);
  objective_setrotateonminimap(objid, 1);
  objective_setbackground(objid, 0);
  objective_state(objid, "active");
  objective_setpings(objid, 1);

  foreach(team in getotherteam(self.team)) {
    objective_addteamtomask(objid, team);
  }

  objective_showtoplayersinmask(objid);
  objective_setownerteam(objid, self.team);
  self.var_2696eb402c159e5d = scripts\mp\objidpoolmanager::requestobjectiveid(1);
  objid = self.var_2696eb402c159e5d;
  objective_icon(objid, "hud_icon_death_spawn");
  objective_setplayintro(objid, 1);
  objective_onentity(objid, self);
  objective_setrotateonminimap(objid, 1);
  objective_setbackground(objid, 0);
  objective_state(objid, "active");
  objective_setpings(objid, 1);
  objective_addclienttomask(objid, self);
  objective_showtoplayersinmask(objid);
  thread function_b1eb5099343d01d7();
}

function private function_68972bb1dc676870() {
  if(isDefined(self.var_d8939daf9b3e461b)) {
    self notify("remove_waypoint");
    scripts\mp\objidpoolmanager::returnobjectiveid(self.var_d8939daf9b3e461b);
    scripts\mp\objidpoolmanager::returnobjectiveid(self.var_2696eb402c159e5d);
    self.var_d8939daf9b3e461b = undefined;
    self.var_2696eb402c159e5d = undefined;
  }
}

function private function_475810e912b4db94() {
  scripts\mp\utility\outline::_hudoutlineviewmodelenable("outlinefill_nodepth_orange", 0);
  wait 0.5;
  scripts\mp\utility\outline::_hudoutlineviewmodeldisable();
}

function private function_b1eb5099343d01d7() {
  self endon("death");
  self endon("remove_waypoint");
  var_661d5ce8e9d7fe6f = getcurrentsuper();
  bundle = var_661d5ce8e9d7fe6f.staticdata.bundle;
  revealinterval = default_to(bundle.var_aeb19026bc6a09fc, 0);
  var_75ffb2278bb6bbae = istrue(bundle.var_61c5cd28d7011c61);

  if(revealinterval == 0) {
    return;
  }

  while(true) {
    scripts\mp\objidpoolmanager::update_objective_position(self.var_d8939daf9b3e461b, self.origin);
    objective_ping(self.var_d8939daf9b3e461b);
    objective_ping(self.var_2696eb402c159e5d);

    if(var_75ffb2278bb6bbae) {
      thread function_475810e912b4db94();
    }

    wait revealinterval;
  }
}