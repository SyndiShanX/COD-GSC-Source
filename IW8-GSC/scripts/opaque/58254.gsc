/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\opaque\58254.gsc
***********************************************/

function emp_init() {
  scripts\mp\utility\sound::besttime("br_emp_gadget");
}

function morsenumber(var0) {
  self endon("disconnect");
  var0 endon("explode_end");
  var0 thread scripts\mp\utility\script::notifyafterframeend("death", "explode_end");
  var0 waittill("explode", var1);
  var2 = scripts\cp_mp\emp_debuff::get_emp_ents();
  var3 = getcompleteweaponname("emp_gadget_mp");

  foreach(var5 in var2) {
    var6 = var5.owner;

    if(isDefined(var6)) {
      if(var6 != self && !scripts\cp_mp\utility\player_utility::playersareenemies(self, var6)) {
        continue;
      }
    }

    var7 = distancesquared(var1, var5.origin);

    if(var7 > 262144) {
      continue;
    }

    var8 = scripts\cp_mp\utility\damage_utility::packdamagedata(self, var5, 1, var3, "MOD_EXPLOSIVE", var0, var1);
    thread calchelicoptertrailpoint(var8);
  }

  var10 = scripts\mp\utility\player::getplayersinradius(var1, 512);

  foreach(var12 in var10) {
    if(!var12 scripts\cp_mp\emp_debuff::can_emp_player()) {
      continue;
    }

    if(var12 != self && !scripts\cp_mp\utility\player_utility::playersareenemies(self, var12)) {
      continue;
    }

    var8 = scripts\cp_mp\utility\damage_utility::packdamagedata(self, var12, 1, var3, "MOD_EXPLOSIVE", var0, var1);
    thread calchelicoptertrailpoint(var8);
  }
}

function _findempvehiclevfxtags(var0) {
  if(isDefined(var0.classname) && var0.classname == "script_vehicle") {
    if(var0 tagexists("tag_engine_fx_left")) {
      return ["tag_engine_fx_left"];
    } else if(var0 tagexists("main_rotor_shaft")) {
      return ["main_rotor_shaft"];
    } else if(var0 tagexists("left_prop_shaft") && var0 tagexists("right_prop_shaft")) {
      return ["left_prop_shaft", "right_prop_shaft"];
    } else if(var0 tagexists("tag_body")) {
      return ["tag_body"];
    } else if(var0 tagexists("tag_origin")) {
      return ["tag_origin"];
    }
  }

  return [];
}

function calchelicoptertrailpoint(var0) {
  scripts\cp_mp\emp_debuff::apply_emp_struct(var0);

  if(!isDefined(var0.attacker)) {
    return;
  }

  if(!isDefined(var0.victim)) {
    return;
  }

  var1 = 6;

  if(isPlayer(var0.victim)) {
    if(var0.attacker == var0.victim) {
      var1 = 2;
    }

    if(var0.victim scripts\mp\utility\perk::_hasperk("specialty_emp_resist") && var0.attacker != var0.victim) {
      var1 = 3.6;
      var0.attacker scripts\mp\damagefeedback::updatedamagefeedback("hittacresist", undefined, undefined, undefined, 1);
    }

    var0.victim playlocalsound("emp_gadget_expl_field_of_impact");
    var0.victim setsoundsubmix("mp_emp_gadget", 0.1);
    playFXOnTag(scripts\engine\utility::getfx("emp_person_stun"), var0.victim, "J_SpineUpper");
    thread scripts\mp\gamescore::trackdebuffassistfortime(var0.attacker, var0.victim, var0.objweapon.basename, var1, "emp_cleared");
  } else if(isDefined(var0.victim.classname) && var0.victim.classname == "script_vehicle") {
    var1 = 10;
    var0.victim thread scripts\engine\utility::play_loop_sound_on_entity("emp_gadget_vehicle_disabled_lp");
    var2 = _findempvehiclevfxtags(var0.victim);

    foreach(var4 in var2) {
      playFXOnTag(scripts\engine\utility::getfx("emp_vehicle_stun"), var0.victim, var4);
    }
  }

  playerzombiesetupkeybindings(var0, var1);

  if(isDefined(var0.victim)) {
    var0.victim scripts\cp_mp\emp_debuff::remove_emp();

    if(isPlayer(var0.victim)) {
      var0.victim stoplocalsound("emp_gadget_expl_field_of_impact");
      var0.victim playlocalsound("emp_gadget_expl_field_of_impact_end");
      var0.victim clearsoundsubmix("mp_emp_gadget", 1);
      stopFXOnTag(scripts\engine\utility::getfx("emp_person_stun"), var0.victim, "J_SpineUpper");
      return;
    }

    if(isDefined(var0.victim.classname) && var0.victim.classname == "script_vehicle") {
      var0.victim scripts\engine\utility::stop_loop_sound_on_entity("emp_gadget_vehicle_disabled_lp");
      var0.victim playsoundonmovingent("emp_gadget_vehicle_disabled_end");
      var2 = _findempvehiclevfxtags(var0.victim);

      foreach(var4 in var2) {
        stopFXOnTag(scripts\engine\utility::getfx("emp_vehicle_stun"), var0.victim, var4);
      }

      return;
    }

    return;
  }
}

function playerzombiesetupkeybindings(var0, var1) {
  var0.victim endon("death_or_disconnect");
  level endon("game_ended");
  var2 = var0.victim scripts\engine\utility::waittill_notify_or_timeout_return("emp_cleared", var1);
}