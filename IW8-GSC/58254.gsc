/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: 58254.gsc
***********************************************/

function emp_init() {
  scripts\mp\utility\sound::besttime("br_emp_gadget");
}

function morsenumber(var_0) {
  self endon("disconnect");
  var_0 endon("explode_end");
  var_0 thread scripts\mp\utility\script::notifyafterframeend("death", "explode_end");
  var_0 waittill("explode", var_1);
  var_2 = scripts\cp_mp\emp_debuff::get_emp_ents();
  var_3 = getcompleteweaponname("emp_gadget_mp");

  foreach(var_5 in var_2) {
    var_6 = var_5.owner;

    if(isDefined(var_6)) {
      if(var_6 != self && !scripts\cp_mp\utility\player_utility::playersareenemies(self, var_6)) {
        continue;
      }
    }

    var_7 = distancesquared(var_1, var_5.origin);

    if(var_7 > 262144) {
      continue;
    }

    var_8 = scripts\cp_mp\utility\damage_utility::packdamagedata(self, var_5, 1, var_3, "MOD_EXPLOSIVE", var_0, var_1);
    thread calchelicoptertrailpoint(var_8);
  }

  var_10 = scripts\mp\utility\player::getplayersinradius(var_1, 512);

  foreach(var_12 in var_10) {
    if(!var_12 scripts\cp_mp\emp_debuff::can_emp_player()) {
      continue;
    }

    if(var_12 != self && !scripts\cp_mp\utility\player_utility::playersareenemies(self, var_12)) {
      continue;
    }

    var_8 = scripts\cp_mp\utility\damage_utility::packdamagedata(self, var_12, 1, var_3, "MOD_EXPLOSIVE", var_0, var_1);
    thread calchelicoptertrailpoint(var_8);
  }
}

function _findempvehiclevfxtags(var_0) {
  if(isDefined(var_0.classname) && var_0.classname == "script_vehicle") {
    if(var_0 tagexists("tag_engine_fx_left")) {
      return ["tag_engine_fx_left"];
    } else if(var_0 tagexists("main_rotor_shaft")) {
      return ["main_rotor_shaft"];
    } else if(var_0 tagexists("left_prop_shaft") && var_0 tagexists("right_prop_shaft")) {
      return ["left_prop_shaft", "right_prop_shaft"];
    } else if(var_0 tagexists("tag_body")) {
      return ["tag_body"];
    } else if(var_0 tagexists("tag_origin")) {
      return ["tag_origin"];
    }
  }

  return [];
}

function calchelicoptertrailpoint(var_0) {
  scripts\cp_mp\emp_debuff::apply_emp_struct(var_0);

  if(!isDefined(var_0.attacker)) {
    return;
  }

  if(!isDefined(var_0.victim)) {
    return;
  }

  var_1 = 6;

  if(isPlayer(var_0.victim)) {
    if(var_0.attacker == var_0.victim) {
      var_1 = 2;
    }

    if(var_0.victim scripts\mp\utility\perk::_hasperk("specialty_emp_resist") && var_0.attacker != var_0.victim) {
      var_1 = 3.6;
      var_0.attacker scripts\mp\damagefeedback::updatedamagefeedback("hittacresist", undefined, undefined, undefined, 1);
    }

    var_0.victim playlocalsound("emp_gadget_expl_field_of_impact");
    var_0.victim setsoundsubmix("mp_emp_gadget", 0.1);
    playFXOnTag(scripts\engine\utility::getfx("emp_person_stun"), var_0.victim, "J_SpineUpper");
    thread scripts\mp\gamescore::trackdebuffassistfortime(var_0.attacker, var_0.victim, var_0.objweapon.basename, var_1, "emp_cleared");
  } else if(isDefined(var_0.victim.classname) && var_0.victim.classname == "script_vehicle") {
    var_1 = 10;
    var_0.victim thread scripts\engine\utility::play_loop_sound_on_entity("emp_gadget_vehicle_disabled_lp");
    var_2 = _findempvehiclevfxtags(var_0.victim);

    foreach(var_4 in var_2) {
      playFXOnTag(scripts\engine\utility::getfx("emp_vehicle_stun"), var_0.victim, var_4);
    }
  }

  playerzombiesetupkeybindings(var_0, var_1);

  if(isDefined(var_0.victim)) {
    var_0.victim scripts\cp_mp\emp_debuff::remove_emp();

    if(isPlayer(var_0.victim)) {
      var_0.victim stoplocalsound("emp_gadget_expl_field_of_impact");
      var_0.victim playlocalsound("emp_gadget_expl_field_of_impact_end");
      var_0.victim clearsoundsubmix("mp_emp_gadget", 1);
      stopFXOnTag(scripts\engine\utility::getfx("emp_person_stun"), var_0.victim, "J_SpineUpper");
      return;
    }

    if(isDefined(var_0.victim.classname) && var_0.victim.classname == "script_vehicle") {
      var_0.victim scripts\engine\utility::stop_loop_sound_on_entity("emp_gadget_vehicle_disabled_lp");
      var_0.victim playsoundonmovingent("emp_gadget_vehicle_disabled_end");
      var_2 = _findempvehiclevfxtags(var_0.victim);

      foreach(var_4 in var_2) {
        stopFXOnTag(scripts\engine\utility::getfx("emp_vehicle_stun"), var_0.victim, var_4);
      }

      return;
    }

    return;
  }
}

function playerzombiesetupkeybindings(var_0, var_1) {
  var_0.victim endon("death_or_disconnect");
  level endon("game_ended");
  var_2 = var_0.victim scripts\engine\utility::waittill_notify_or_timeout_return("emp_cleared", var_1);
}