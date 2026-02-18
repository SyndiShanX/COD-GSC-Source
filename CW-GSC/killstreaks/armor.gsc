/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: killstreaks\armor.gsc
***********************************************/

#using scripts\core_common\armor;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\system_shared;
#using scripts\killstreaks\killstreakrules_shared;
#using scripts\killstreaks\killstreaks_shared;
#namespace weapon_armor;

function private autoexec __init__system__() {
  system::register(#"weapon_armor", &init_shared, undefined, undefined, undefined);
}

function init_shared() {
  killstreaks::register_killstreak("weapon_armor", &use_armor);
  callback::on_player_killed(&on_player_killed);
}

function use_armor(killstreaktype) {
  if(self killstreakrules::iskillstreakallowed("weapon_armor", self.team) == 0) {
    return false;
  }

  self.var_c79fb13d = self killstreakrules::killstreakstart("weapon_armor", self.team);

  if(self.var_c79fb13d == -1) {
    return false;
  }

  if(isDefined(self.var_f721af54)) {
    self.var_f721af54 delete();
  }

  var_f721af54 = spawn("script_origin", self.origin);
  var_f721af54 linkto(self);
  self.var_f721af54 = var_f721af54;
  var_f721af54 killstreaks::configure_team("weapon_armor", self.var_c79fb13d, self);
  self playlocalsound(#"hash_1e84a47d66834c73");
  self armor::set_armor(150, 150, 2, 0.4, 1, 0.5, 0, 1, 1, 1);
  self.var_67f4fd41 = &function_b299c6ec;
  self waittill(#"weapon_change_complete", #"death", #"disconnect", #"joined_team", #"killstreak_done");
  return true;
}

function function_b299c6ec(eattacker, weapon) {
  if(!isDefined(self.var_c79fb13d)) {
    return;
  }

  if(sessionmodeismultiplayergame()) {
    killstreakrules::killstreakstop("weapon_armor", self.team, self.var_c79fb13d);
  }

  self.var_c79fb13d = undefined;

  if(isDefined(self.var_f721af54)) {
    self.var_f721af54 delete();
  }

  if(isPlayer(eattacker)) {
    scoreevents::processscoreevent(#"hash_7b5132f56f758d9", eattacker, self, weapon);
  }
}

function on_player_killed(params) {
  if(armor::get_armor() > 0 && isDefined(self.var_c79fb13d)) {
    if(sessionmodeismultiplayergame()) {
      killstreakrules::killstreakstop("weapon_armor", self.team, self.var_c79fb13d);
    }

    self.var_c79fb13d = undefined;

    if(isDefined(self.var_f721af54)) {
      self.var_f721af54 delete();
    }

    eattacker = params.eattacker;
    weapon = params.weapon;

    if(isPlayer(eattacker) && eattacker != self) {
      scoreevents::processscoreevent(#"hash_7b5132f56f758d9", eattacker, self, weapon);
    }
  }
}