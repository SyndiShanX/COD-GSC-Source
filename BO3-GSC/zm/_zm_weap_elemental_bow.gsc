/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_weap_elemental_bow.gsc
*************************************************/

#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\math_shared;
#using scripts\shared\system_shared;
#using scripts\shared\throttle_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_equipment;
#using scripts\zm\_zm_spawner;
#namespace zm_weap_elemental_bow;

function autoexec __init__sytem__() {
  system::register("_zm_weap_elemental_bow", &__init__, &__main__, undefined);
}

function __init__() {
  level.var_be94cdb = getweapon("elemental_bow");
  level.var_1a828a16 = getweapon("elemental_bow4");
  clientfield::register("toplayer", "elemental_bow" + "_ambient_bow_fx", 5000, 1, "int");
  clientfield::register("missile", "elemental_bow" + "_arrow_impact_fx", 5000, 1, "int");
  clientfield::register("missile", "elemental_bow4" + "_arrow_impact_fx", 5000, 1, "int");
  callback::on_connect(&function_c45ac6ae);
  setdvar("bg_chargeShotUseOneAmmoForMultipleBullets", 0);
  setdvar("bg_zm_dlc1_chargeShotMultipleBulletsForFullCharge", 2);
  level.var_d6de2706 = new throttle();
  [[level.var_d6de2706]] - > initialize(6, 0.1);
}

function __main__() {}

function function_c45ac6ae() {
  self thread function_982419bb("elemental_bow");
  self thread function_ececa597("elemental_bow", "elemental_bow4");
  self thread function_7bc6b9d("elemental_bow", "elemental_bow4", &function_65347b70);
}

function function_65347b70(weapon, v_position, radius, attacker, normal) {
  var_2679aa6b = function_1796e73(weapon.name);
  if(weapon.name == "elemental_bow4") {
    attacker clientfield::set(var_2679aa6b + "_arrow_impact_fx", 1);
    var_852420bf = array::get_all_closest(v_position, getaiteamarray(level.zombie_team), undefined, undefined, 128);
    var_852420bf = array::filter(var_852420bf, 0, &function_83f44f5, v_position);
    array::thread_all(var_852420bf, &function_7fba300, self, v_position);
  } else {
    attacker clientfield::set(var_2679aa6b + "_arrow_impact_fx", 1);
  }
}

function function_83f44f5(ai_enemy, var_289e02fc) {
  return isalive(ai_enemy) && (!(isDefined(ai_enemy.var_98056717) && ai_enemy.var_98056717)) && bullettracepassed(ai_enemy getcentroid(), var_289e02fc + vectorscale((0, 0, 1), 48), 0, undefined);
}

function function_7fba300(e_player, var_289e02fc) {
  self endon("death");
  if(self.archetype === "mechz") {
    return;
  }
  self.var_98056717 = 1;
  n_damage = 2233;
  if(self.health > 2233) {
    self thread function_d1e69389(var_289e02fc);
  } else {
    self startragdoll();
    n_dist = distance2d(self.origin, var_289e02fc);
    var_37f1fb21 = (128 - n_dist) / 128;
    var_9450d281 = vectornormalize(self getcentroid() - var_289e02fc);
    if(var_9450d281[2] < 0.8) {
      var_9450d281 = (var_9450d281[0], var_9450d281[1], 0.8);
    }
    self launchragdoll((var_9450d281 * 96) * var_37f1fb21);
    wait(0.1);
    self zm_spawner::zombie_explodes_intopieces(0);
  }
  if(isDefined(self)) {
    [[level.var_d6de2706]] - > waitinqueue(self);
    if(isDefined(self)) {
      self dodamage(n_damage, self.origin, e_player, e_player, undefined, "MOD_PROJECTILE_SPLASH", 0, level.var_1a828a16);
      self.var_98056717 = 0;
    }
  }
}

function function_982419bb(var_6ab83514) {
  self endon("death");
  var_e1041201 = getweapon(var_6ab83514);
  while(true) {
    self waittill("weapon_change", wpn_new, var_6de65145);
    if(wpn_new === var_e1041201) {
      if(!(isDefined(self.var_8b65be8c) && self.var_8b65be8c)) {
        if(isDefined(self.hintelem)) {
          self.hintelem settext("");
          self.hintelem destroy();
        }
        if(self issplitscreen()) {
          self thread zm_equipment::show_hint_text(&"ZM_CASTLE_BOW_INSTRUCTIONS", 8, 1, 150);
        } else {
          self thread zm_equipment::show_hint_text(&"ZM_CASTLE_BOW_INSTRUCTIONS", 8);
        }
        self.var_8b65be8c = 1;
      }
      if(isDefined(level.var_2edb42da)) {
        self thread[[level.var_2edb42da]]();
      }
      self util::waittill_any_timeout(1, "weapon_change_complete", "death");
      self clientfield::set_to_player(var_6ab83514 + "_ambient_bow_fx", 1);
    } else if(var_6de65145 === var_e1041201) {
      self clientfield::set_to_player(var_6ab83514 + "_ambient_bow_fx", 0);
      self stoprumble("bow_draw_loop");
    }
  }
}

function function_ececa597(var_6ab83514, var_8f9bdf29, var_5759faa5 = undefined) {
  self endon("death");
  if(!isDefined(var_5759faa5)) {
    return;
  }
  while(true) {
    self waittill("missile_fire", projectile, weapon);
    if(issubstr(weapon.name, var_6ab83514)) {
      self thread[[var_5759faa5]](projectile, weapon);
    }
  }
}

function function_67b18bd9(str_weapon_name) {
  if(!isDefined(str_weapon_name)) {
    return false;
  }
  if(str_weapon_name == "elemental_bow" || str_weapon_name == "elemental_bow2" || str_weapon_name == "elemental_bow3" || str_weapon_name == "elemental_bow4" || str_weapon_name == "elemental_bow_demongate" || str_weapon_name == "elemental_bow_demongate2" || str_weapon_name == "elemental_bow_demongate3" || str_weapon_name == "elemental_bow_demongate4" || str_weapon_name == "elemental_bow_rune_prison" || str_weapon_name == "elemental_bow_rune_prison_ricochet" || str_weapon_name == "elemental_bow_rune_prison2" || str_weapon_name == "elemental_bow_rune_prison3" || str_weapon_name == "elemental_bow_rune_prison4" || str_weapon_name == "elemental_bow_rune_prison4_ricochet" || str_weapon_name == "elemental_bow_storm" || str_weapon_name == "elemental_bow_storm_ricochet" || str_weapon_name == "elemental_bow_storm2" || str_weapon_name == "elemental_bow_storm3" || str_weapon_name == "elemental_bow_storm4" || str_weapon_name == "elemental_bow_storm4_ricochet" || str_weapon_name == "elemental_bow_wolf_howl" || str_weapon_name == "elemental_bow_wolf_howl2" || str_weapon_name == "elemental_bow_wolf_howl3" || str_weapon_name == "elemental_bow_wolf_howl4") {
    return true;
  }
  return false;
}

function function_db107e59(str_weapon_name) {
  if(!isDefined(str_weapon_name)) {
    return false;
  }
  if(str_weapon_name == "elemental_bow4" || str_weapon_name == "elemental_bow_demongate4" || str_weapon_name == "elemental_bow_rune_prison4" || str_weapon_name == "elemental_bow_rune_prison4_ricochet" || str_weapon_name == "elemental_bow_storm4" || str_weapon_name == "elemental_bow_storm4_ricochet" || str_weapon_name == "elemental_bow_wolf_howl4") {
    return true;
  }
  return false;
}

function function_b252290e(str_weapon_name, var_93fff756) {
  if(!isDefined(str_weapon_name)) {
    return false;
  }
  switch (var_93fff756) {
    case "elemental_bow": {
      if(str_weapon_name == "elemental_bow" || str_weapon_name == "elemental_bow2" || str_weapon_name == "elemental_bow3" || str_weapon_name == "elemental_bow4") {
        return true;
      }
      break;
    }
    case "elemental_bow_demongate": {
      if(str_weapon_name == "elemental_bow_demongate" || str_weapon_name == "elemental_bow_demongate2" || str_weapon_name == "elemental_bow_demongate3" || str_weapon_name == "elemental_bow_demongate4") {
        return true;
      }
      break;
    }
    case "elemental_bow_rune_prison": {
      if(str_weapon_name == "elemental_bow_rune_prison" || str_weapon_name == "elemental_bow_rune_prison_ricochet" || str_weapon_name == "elemental_bow_rune_prison2" || str_weapon_name == "elemental_bow_rune_prison3" || str_weapon_name == "elemental_bow_rune_prison4" || str_weapon_name == "elemental_bow_rune_prison4_ricochet") {
        return true;
      }
      break;
    }
    case "elemental_bow_storm": {
      if(str_weapon_name == "elemental_bow_storm" || str_weapon_name == "elemental_bow_storm_ricochet" || str_weapon_name == "elemental_bow_storm2" || str_weapon_name == "elemental_bow_storm3" || str_weapon_name == "elemental_bow_storm4" || str_weapon_name == "elemental_bow_storm4_ricochet") {
        return true;
      }
      break;
    }
    case "elemental_bow_wolf_howl": {
      if(str_weapon_name == "elemental_bow_wolf_howl" || str_weapon_name == "elemental_bow_wolf_howl2" || str_weapon_name == "elemental_bow_wolf_howl3" || str_weapon_name == "elemental_bow_wolf_howl4") {
        return true;
      }
      break;
    }
    default: {
      assert(0, "");
      break;
    }
  }
  return false;
}

function function_ea37b2fe(str_weapon_name) {
  if(!isDefined(str_weapon_name)) {
    return false;
  }
  if(str_weapon_name == "elemental_bow_demongate" || str_weapon_name == "elemental_bow_demongate2" || str_weapon_name == "elemental_bow_demongate3" || str_weapon_name == "elemental_bow_demongate4" || str_weapon_name == "elemental_bow_rune_prison" || str_weapon_name == "elemental_bow_rune_prison_ricochet" || str_weapon_name == "elemental_bow_rune_prison2" || str_weapon_name == "elemental_bow_rune_prison3" || str_weapon_name == "elemental_bow_rune_prison4" || str_weapon_name == "elemental_bow_rune_prison4_ricochet" || str_weapon_name == "elemental_bow_storm" || str_weapon_name == "elemental_bow_storm_ricochet" || str_weapon_name == "elemental_bow_storm2" || str_weapon_name == "elemental_bow_storm3" || str_weapon_name == "elemental_bow_storm4" || str_weapon_name == "elemental_bow_storm4_ricochet" || str_weapon_name == "elemental_bow_wolf_howl" || str_weapon_name == "elemental_bow_wolf_howl2" || str_weapon_name == "elemental_bow_wolf_howl3" || str_weapon_name == "elemental_bow_wolf_howl4") {
    return true;
  }
  return false;
}

function function_7bc6b9d(var_6ab83514, var_8f9bdf29, var_332bb697 = undefined) {
  self endon("death");
  while(true) {
    self waittill("projectile_impact", weapon, v_position, radius, e_projectile, normal);
    var_48369d98 = function_1796e73(weapon.name);
    if(var_48369d98 == var_6ab83514 || var_48369d98 == var_8f9bdf29) {
      if(var_48369d98 != "elemental_bow" && var_48369d98 != "elemental_bow_wolf_howl4" && isDefined(e_projectile.birthtime)) {
        if((gettime() - e_projectile.birthtime) <= 150) {
          radiusdamage(v_position, 32, level.zombie_health, level.zombie_health, self, "MOD_UNKNOWN", weapon);
        }
      }
      self thread function_d2e32ed2(var_48369d98, v_position);
      if(isDefined(var_332bb697)) {
        self thread[[var_332bb697]](weapon, v_position, radius, e_projectile, normal);
      }
      self thread function_9c5946ba(weapon, v_position);
    }
  }
}

function function_d2e32ed2(var_48369d98, v_position) {
  if(var_48369d98 === "elemental_bow_wolf_howl4") {
    return;
  }
  array::thread_all(getaiarchetypearray("mechz"), &function_b78fcfc7, self, var_48369d98, v_position);
}

function function_b78fcfc7(e_player, var_48369d98, v_position) {
  var_2017780d = 0;
  var_c36342f3 = 0;
  var_377b9896 = 0;
  if(!issubstr(var_48369d98, "4")) {
    var_377b9896 = 1;
    var_3fa1565a = 9216;
    var_6594cbc3 = 96;
    var_f419b406 = 0.25;
  } else if(var_48369d98 == "elemental_bow4") {
    var_377b9896 = 1;
    var_3fa1565a = 20736;
    var_6594cbc3 = 144;
    var_f419b406 = 0.1;
  }
  var_7486069a = distancesquared(v_position, self.origin);
  var_7d984cf2 = distancesquared(v_position, self gettagorigin("j_neck"));
  if(var_7486069a < 1600 || var_7d984cf2 < 2304) {
    var_2017780d = 1;
    var_c36342f3 = 1;
  } else if(var_377b9896 && (var_7486069a < var_3fa1565a || var_7d984cf2 < var_3fa1565a)) {
    var_2017780d = 1;
    var_c36342f3 = 1 - var_f419b406;
    var_c36342f3 = var_c36342f3 * ((sqrt((var_7486069a < var_7d984cf2 ? var_7486069a : var_7d984cf2))) / var_6594cbc3);
    var_c36342f3 = 1 - var_c36342f3;
  }
  if(var_2017780d) {
    var_3bb42832 = level.mechz_health;
    if(isDefined(level.var_f4dc2834)) {
      var_3bb42832 = math::clamp(var_3bb42832, 0, level.var_f4dc2834);
    }
    if(var_48369d98 == "elemental_bow") {
      var_26680fd5 = function_dc4f8831(0.15, 0.03);
    } else {
      if(var_48369d98 == "elemental_bow4") {
        var_26680fd5 = function_dc4f8831(0.25, 0.12);
      } else {
        if(!issubstr(var_48369d98, "4")) {
          var_26680fd5 = 0.1;
        } else {
          var_26680fd5 = 0.35;
        }
      }
    }
    var_40955aed = (var_3bb42832 * var_26680fd5) / 0.2;
    var_40955aed = var_40955aed * var_c36342f3;
    self dodamage(var_40955aed, self.origin, e_player, e_player, undefined, "MOD_PROJECTILE_SPLASH", 0, level.var_be94cdb);
  }
}

function function_dc4f8831(var_eaae98a2, var_c01c8d5c) {
  if(level.mechz_health < level.var_c1f907b2) {
    var_26680fd5 = var_eaae98a2;
  } else {
    if(level.mechz_health > level.var_42fd61f0) {
      var_26680fd5 = var_c01c8d5c;
    } else {
      var_d82dde4a = level.mechz_health - level.var_c1f907b2;
      var_caabb734 = var_d82dde4a / level.var_42ee1b54;
      var_26680fd5 = var_eaae98a2 - ((var_eaae98a2 - var_c01c8d5c) * var_caabb734);
    }
  }
  return var_26680fd5;
}

function function_9c5946ba(weapon, v_position) {
  util::wait_network_frame();
  radiusdamage(v_position, 24, 1, 1, self, undefined, weapon);
}

function function_5aec3adc(ai_enemy) {
  b_callback_result = 1;
  if(isDefined(level.var_4e84030d)) {
    b_callback_result = [[level.var_4e84030d]](ai_enemy);
  }
  return isDefined(ai_enemy) && isalive(ai_enemy) && !ai_enemy isragdoll() && (!(isDefined(ai_enemy.var_98056717) && ai_enemy.var_98056717)) && (!(isDefined(ai_enemy.var_d3c478a0) && ai_enemy.var_d3c478a0)) && b_callback_result;
}

function function_d1e69389(var_63f884ec) {
  self endon("death");
  if(!(isDefined(self.knockdown) && self.knockdown) && (!(isDefined(self.missinglegs) && self.missinglegs))) {
    self.knockdown = 1;
    self setplayercollision(0);
    var_25cdb267 = var_63f884ec - self.origin;
    var_a87a26a1 = vectornormalize((var_25cdb267[0], var_25cdb267[1], 0));
    v_zombie_forward = vectornormalize((anglesToForward(self.angles)[0], anglesToForward(self.angles)[1], 0));
    v_zombie_right = vectornormalize((anglestoright(self.angles)[0], anglestoright(self.angles)[1], 0));
    v_dot = vectordot(var_a87a26a1, v_zombie_forward);
    if(v_dot >= 0.5) {
      self.knockdown_direction = "front";
      self.getup_direction = "getup_back";
    } else {
      if(v_dot < 0.5 && v_dot > -0.5) {
        v_dot = vectordot(var_a87a26a1, v_zombie_right);
        if(v_dot > 0) {
          self.knockdown_direction = "right";
          if(math::cointoss()) {
            self.getup_direction = "getup_back";
          } else {
            self.getup_direction = "getup_belly";
          }
        } else {
          self.knockdown_direction = "left";
          self.getup_direction = "getup_belly";
        }
      } else {
        self.knockdown_direction = "back";
        self.getup_direction = "getup_belly";
      }
    }
    wait(2.5);
    self setplayercollision(1);
    self.knockdown = 0;
  }
}

function function_866906f(v_hit_origin, str_weapon_name, var_3fee16b8, var_a5018155, var_83c68ee2 = undefined) {
  var_980aeb4e = anglesToForward(var_3fee16b8.angles);
  if(var_980aeb4e[2] != -1) {
    var_3e878400 = vectornormalize(var_980aeb4e * -1);
    var_75181c09 = v_hit_origin + (var_3e878400 * var_a5018155);
  } else {
    var_75181c09 = v_hit_origin + (0, 0, 1);
  }
  var_c6f6381a = bulletTrace(var_75181c09, var_75181c09 - vectorscale((0, 0, 1), 1000), 0, undefined);
  var_58c16abb = var_75181c09[2] - var_c6f6381a["position"][2];
  var_2679aa6b = function_1796e73(str_weapon_name);
  if(!ispointonnavmesh(var_c6f6381a["position"])) {
    var_3fee16b8 clientfield::set(var_2679aa6b + "_arrow_impact_fx", 1);
    return undefined;
  }
  if(var_58c16abb > 72) {
    if(isDefined(var_83c68ee2)) {
      self thread[[var_83c68ee2]](str_weapon_name, var_75181c09, var_c6f6381a["position"]);
    } else {
      self thread function_99de7ff2(str_weapon_name, var_75181c09, var_c6f6381a["position"]);
    }
    return undefined;
  }
  var_3fee16b8 clientfield::set(var_2679aa6b + "_arrow_impact_fx", 1);
  return var_c6f6381a["position"];
}

function function_99de7ff2(str_weapon_name, v_source, v_destination) {
  wait(0.1);
  magicbullet(getweapon(str_weapon_name), v_source, v_destination, self);
}

function function_1796e73(str_weapon_name) {
  var_48369d98 = str_weapon_name;
  if(issubstr(var_48369d98, "ricochet")) {
    var_ae485cc2 = strtok2(var_48369d98, "_ricochet");
    var_48369d98 = var_ae485cc2[0];
  }
  if(issubstr(var_48369d98, "2")) {
    var_48369d98 = strtok(var_48369d98, "2")[0];
  }
  if(issubstr(var_48369d98, "3")) {
    var_48369d98 = strtok(var_48369d98, "3")[0];
  }
  return var_48369d98;
}