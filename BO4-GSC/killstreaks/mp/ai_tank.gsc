/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: killstreaks\mp\ai_tank.gsc
***********************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\player\player_stats;
#include scripts\core_common\scoreevents_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\killstreaks\ai\patrol;
#include scripts\killstreaks\ai_tank_shared;
#include scripts\killstreaks\killstreaks_shared;
#include scripts\killstreaks\mp\killstreak_vehicle;
#include scripts\killstreaks\mp\supplydrop;

#namespace ai_tank;

autoexec __init__system__() {
  system::register(#"ai_tank", &__init__, undefined, #"killstreaks");
}

__init__() {
  init_shared();
  level.var_1dd2fbe1 = &function_c44c9bde;
  level.aitank_explode = &function_1e11d939;
  level.var_2e0b35c2 = &function_103d8f6;
  level.var_daa33d93 = &function_23e43434;
  level.var_cffcf4da = &function_577150fd;
  level.var_7f17a53e = &function_dd1ad60e;
  level.var_4b38c02b = &function_47a8e7a8;
}

function_c44c9bde(drone) {
  drone = self;
  bundle = struct::get_script_bundle("killstreak", "killstreak_" + "tank_robot");
  drone ai_patrol::function_d091ff45(bundle);
  drone.goalradius = bundle.var_a562774d;
  drone thread killstreaks::waitfortimecheck(90000 * 0.5, &ontimecheck, "delete", "death", "crashing");
}

ontimecheck() {
  self killstreaks::play_pilot_dialog_on_owner("timecheck", "tank_robot", self.killstreak_id);
}

function_577150fd(drone) {
  if(!isDefined(self.currentkillstreakdialog) && isDefined(level.heroplaydialog)) {
    self thread[[level.heroplaydialog]]("controlAiTank");
  }

  self.var_5f28922a = 1;
  drone clientfield::set("ai_tank_change_control", 1);
}

function_dd1ad60e(drone) {
  if(isDefined(self)) {
    self.var_5f28922a = 0;
  }

  drone clientfield::set("ai_tank_change_control", 0);
}

function_103d8f6(killstreaktype) {
  return supplydrop::issupplydropgrenadeallowed(killstreaktype);
}

function_23e43434(killstreak_id, context, team) {
  result = self supplydrop::usesupplydropmarker(killstreak_id, context);
  self notify(#"supply_drop_marker_done");

  if(!(isDefined(result) && result)) {
    return false;
  }

  self killstreaks::play_killstreak_start_dialog("tank_robot", team, killstreak_id);
  return true;
}

function_1e11d939(attacker, weapon) {
  if(self.exploding === 1) {
    return;
  }

  profilestart();
  self.exploding = 1;
  destroyedbyenemy = killstreak_vehicle::explode(attacker, weapon);

  if(isDefined(level.figure_out_attacker)) {
    attacker = self[[level.figure_out_attacker]](attacker);
  }

  if(destroyedbyenemy && isplayer(attacker)) {
    scoreevents::function_f40d64cc(attacker, self, weapon);

    if(isDefined(attacker)) {
      attacker stats::function_e24eec31(weapon, #"hash_3f3d8a93c372c67d", 1);
    }
  }

  profilestop();
  return destroyedbyenemy;
}

function_47a8e7a8() {
  profilestart();
  self thread function_22528515();
  profilestop();
}

function_22528515() {
  vehicle = self;
  vehicle endon(#"death");

  if(isDefined(self.owner)) {
    self.owner endon(#"disconnect");
  }

  while(true) {
    waitresult = vehicle waittill(#"touch");
    ent = waitresult.entity;

    if(isDefined(ent.classname) && ent.classname == "trigger_hurt_new") {
      if(isDefined(level.var_14ae1879) && vehicle.origin[2] >= level.var_14ae1879) {
        continue;
      }

      vehicle notify(#"death");
    }
  }
}