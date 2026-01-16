/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\zm_utility.csc
***********************************************/

#include scripts\core_common\activecamo_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\flag_shared;
#include scripts\core_common\postfx_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\zm_common\zm_maptable;
#include scripts\zm_common\zm_powerups;
#include scripts\zm_common\zm_weapons;

#namespace zm_utility;

autoexec __init__system__() {
  system::register(#"zm_utility", &__init__, &__main__, undefined);
}

__init__() {
  level._effect[#"zm_zone_edge_marker"] = #"hash_3002526b7ff53cbf";
  clientfield::register("scriptmover", "zm_zone_edge_marker_count", 1, getminbitcountfornum(15), "int", &zm_zone_edge_marker_count, 0, 0);
  clientfield::register("toplayer", "zm_zone_out_of_bounds", 1, 1, "int", &zm_zone_out_of_bounds, 0, 0);
  clientfield::register("actor", "flame_corpse_fx", 1, 1, "int", &flame_corpse_fx, 0, 0);
  clientfield::register("actor", "zombie_eye_glow", 1, 1, "int", &zombie_eye_glow, 0, 0);
  function_c599ed65();
}

__main__() {}

ignore_triggers(timer) {
  if(!isDefined(self)) {
    return;
  }

  self endon(#"death");
  self.ignoretriggers = 1;

  if(isDefined(timer)) {
    wait timer;
  } else {
    wait 0.5;
  }

  self.ignoretriggers = 0;
}

is_encounter() {
  return false;
}

round_up_to_ten(score) {
  new_score = score - score % 10;

  if(new_score < score) {
    new_score += 10;
  }

  return new_score;
}

round_up_score(score, value) {
  score = int(score);
  new_score = score - score % value;

  if(new_score < score) {
    new_score += value;
  }

  return new_score;
}

halve_score(n_score) {
  n_score /= 2;
  n_score = round_up_score(n_score, 10);
  return n_score;
}

spawn_weapon_model(localclientnum, weapon, model = weapon.worldmodel, origin, angles, options) {
  weapon_model = spawn(localclientnum, origin, "script_model");

  if(isDefined(angles)) {
    weapon_model.angles = angles;
  }

  if(isDefined(options)) {
    weapon_model useweaponmodel(weapon, model, options);
  } else {
    weapon_model useweaponmodel(weapon, model);
  }

  return weapon_model;
}

spawn_buildkit_weapon_model(localclientnum, weapon, camo, origin, angles) {
  weapon_model = spawn(localclientnum, origin, "script_model");

  if(isDefined(angles)) {
    weapon_model.angles = angles;
  }

  weapon_model usebuildkitweaponmodel(localclientnum, weapon, camo);
  weapon_model activecamo::function_e40c785a(localclientnum);
  return weapon_model;
}

is_classic() {
  str_gametype = util::get_game_type();

  if(str_gametype == #"zclassic") {
    return true;
  }

  return false;
}

is_standard() {
  str_gametype = util::get_game_type();

  if(str_gametype == #"zstandard") {
    return true;
  }

  return false;
}

is_trials() {
  str_gametype = util::get_game_type();

  if(str_gametype == #"ztrials" || level flag::exists(#"ztrial")) {
    return true;
  }

  return false;
}

is_tutorial() {
  str_gametype = util::get_game_type();

  if(str_gametype == #"ztutorial") {
    return true;
  }

  return false;
}

is_grief() {
  str_gametype = util::get_game_type();

  if(str_gametype == #"zgrief") {
    return true;
  }

  return false;
}

is_gametype_active(a_gametypes) {
  b_is_gametype_active = 0;

  if(!isarray(a_gametypes)) {
    a_gametypes = array(a_gametypes);
  }

  for(i = 0; i < a_gametypes.size; i++) {
    if(util::get_game_type() == a_gametypes[i]) {
      b_is_gametype_active = 1;
    }
  }

  return b_is_gametype_active;
}

is_ee_enabled() {
  if(!getdvarint(#"zm_ee_enabled", 0)) {
    return false;
  }

  if(level.gamedifficulty == 0) {
    return false;
  }

  return true;
}

setinventoryuimodels(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(function_65b9eb0f(localclientnum)) {
    return;
  }

  setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "zmInventory." + fieldname), newval);
}

setsharedinventoryuimodels(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "zmInventory." + fieldname), newval);
}

zm_ui_infotext(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "zmInventory.infoText"), fieldname);
    return;
  }

  setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "zmInventory.infoText"), "");
}

drawcylinder(pos, rad, height, color) {
  currad = rad;
  curheight = height;
  debugstar(pos, 1, color);

  for(r = 0; r < 20; r++) {
    theta = r / 20 * 360;
    theta2 = (r + 1) / 20 * 360;
    line(pos + (cos(theta) * currad, sin(theta) * currad, 0), pos + (cos(theta2) * currad, sin(theta2) * currad, 0), color, 1, 1, 100);
    line(pos + (cos(theta) * currad, sin(theta) * currad, curheight), pos + (cos(theta2) * currad, sin(theta2) * currad, curheight), color, 1, 1, 100);
    line(pos + (cos(theta) * currad, sin(theta) * currad, 0), pos + (cos(theta) * currad, sin(theta) * currad, curheight), color, 1, 1, 100);
  }
}

  function umbra_fix_logic(localclientnum) {
    self endon(#"disconnect");
    self endon(#"death");
    umbra_settometrigger(localclientnum, "");

    while(true) {
      in_fix_area = 0;

      if(isDefined(level.custom_umbra_hotfix)) {
        in_fix_area = self thread[[level.custom_umbra_hotfix]](localclientnum);
      }

      if(in_fix_area == 0) {
        umbra_settometrigger(localclientnum, "");
      }

      waitframe(1);
    }
  }

umbra_fix_trigger(localclientnum, pos, height, radius, umbra_name) {
  bottomy = pos[2];
  topy = pos[2] + height;

  if(self.origin[2] > bottomy && self.origin[2] < topy) {
    if(distance2dsquared(self.origin, pos) < radius * radius) {
      umbra_settometrigger(localclientnum, umbra_name);

      drawcylinder(pos, radius, height, (0, 1, 0));

        return true;
    }
  }

  drawcylinder(pos, radius, height, (1, 0, 0));

    return false;
}

function_f8796df3(localclientnum) {
  b_first = 0;

  if(isplayer(self) && self function_21c0fa55() && !isdemoplaying()) {
    if(!isDefined(self getlocalclientnumber()) || localclientnum == self getlocalclientnumber()) {
      b_first = 1;
    }
  }

  return b_first;
}

function_5d8fd5f3(localclientnum) {
  b_first = 0;

  if(isplayer(self) && self function_21c0fa55() && !isdemoplaying()) {
    if(!isDefined(self getlocalclientnumber()) || localclientnum == self getlocalclientnumber()) {
      if(!isthirdperson(localclientnum)) {
        b_first = 1;
      }
    }
  }

  return b_first;
}

function_467efa7b(var_9f3fb329 = 0) {
  if(!isDefined(self.archetype)) {
    return "tag_origin";
  }

  switch (self.archetype) {
    case #"stoker":
    case #"catalyst":
    case #"gladiator":
    case #"nova_crawler":
    case #"zombie":
    case #"ghost":
    case #"brutus":
      if(var_9f3fb329) {
        str_tag = "j_spine4";
      } else {
        str_tag = "j_spineupper";
      }

      break;
    case #"blight_father":
    case #"tiger":
    case #"elephant":
      str_tag = "j_head";
      break;
    default:
      str_tag = "tag_origin";
      break;
  }

  return str_tag;
}

function_bb54a31f(localclientnum, var_20804e3b, var_3ab46b9) {
  self endon(var_3ab46b9);
  s_result = level waittill(#"respawn");
  a_e_players = getlocalplayers();

  foreach(e_player in a_e_players) {
    if(e_player postfx::function_556665f2(var_20804e3b)) {
      e_player postfx::exitpostfxbundle(var_20804e3b);
    }
  }
}

function_ae3780f1(localclientnum, n_fx_id, var_3ab46b9) {
  self endon(var_3ab46b9);
  s_result = level waittill(#"respawn");
  a_e_players = getlocalplayers();

  foreach(e_player in a_e_players) {
    if(isDefined(n_fx_id)) {
      deletefx(localclientnum, n_fx_id);
      n_fx_id = undefined;
    }
  }
}

get_cast() {
  return zm_maptable::get_cast();
}

get_story() {
  return zm_maptable::get_story();
}

zm_zone_edge_marker_count(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval > 0) {
    v_forward = anglesToForward(self.angles);
    v_right = anglestoright(self.angles);
    v_spacing = (0, 0, 0);
    self.origin += v_right * 6;

    for(i = 1; i <= newval; i++) {
      var_a05a609b = playFX(localclientnum, level._effect[#"zm_zone_edge_marker"], self.origin + v_spacing, v_forward);

      if(!isDefined(self.var_dd1709dd)) {
        self.var_dd1709dd = [];
      } else if(!isarray(self.var_dd1709dd)) {
        self.var_dd1709dd = array(self.var_dd1709dd);
      }

      self.var_dd1709dd[self.var_dd1709dd.size] = var_a05a609b;
      v_spacing = v_right * 32 * i;
    }

    return;
  }

  if(isarray(self.var_dd1709dd)) {
    foreach(var_a05a609b in self.var_dd1709dd) {
      stopfx(localclientnum, var_a05a609b);
    }
  }
}

zm_zone_out_of_bounds(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!isDefined(level.var_20861007)) {
    level.var_20861007 = [];
  }

  if(!isDefined(level.var_20861007[localclientnum])) {
    level.var_20861007[localclientnum] = util::spawn_model(localclientnum, "tag_origin");
  }

  if(newval) {
    level.var_20861007[localclientnum] playLoopSound(#"hash_6da7ae12f538ef5e", 0.5);
    self postfx::playpostfxbundle(#"hash_798237aa1bad3d7d");
    return;
  }

  level.var_20861007[localclientnum] stopallloopsounds(0.5);
  self postfx::exitpostfxbundle(#"hash_798237aa1bad3d7d");
}

flame_corpse_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(newval == 1) {
    if(isDefined(self.var_71a7fc1c)) {
      stopfx(localclientnum, self.var_71a7fc1c);
    }

    str_tag = "j_spineupper";

    if(!isDefined(self gettagorigin(str_tag))) {
      str_tag = "tag_origin";
    }

    if(isDefined(level._effect) && isDefined(level._effect[#"character_fire_death_torso"])) {
      self.var_71a7fc1c = util::playFXOnTag(localclientnum, level._effect[#"character_fire_death_torso"], self, str_tag);
    }

    return;
  }

  if(isDefined(self.var_71a7fc1c)) {
    stopfx(localclientnum, self.var_71a7fc1c);
    self.var_71a7fc1c = undefined;
  }
}

function_c599ed65() {
  if(get_story() == 1) {
    level.var_12b59dee = "rob_zm_eyes_yellow";
    level._effect[#"eye_glow"] = #"hash_760112479afe6e2";
    return;
  }

  level.var_12b59dee = "rob_zm_eyes_orange";
  level._effect[#"eye_glow"] = #"zm_ai/fx8_zombie_eye_glow_orange";
}

function_beed5764(var_ee6bcd51, str_fx) {
  if(isDefined(var_ee6bcd51)) {
    level.var_12b59dee = var_ee6bcd51;
  }

  if(isDefined(str_fx)) {
    level._effect[#"eye_glow"] = str_fx;
  }
}

function_704f7c0e(localclientnum) {
  self good_barricade_damaged(localclientnum);

  if(isDefined(self.var_3234aaa4)) {
    var_ee6bcd51 = self.var_3234aaa4;
  } else {
    var_ee6bcd51 = level.var_12b59dee;
  }

  if(isDefined(self.var_3ec34470)) {
    str_fx = self.var_3ec34470;
  } else {
    str_fx = level._effect[#"eye_glow"];
  }

  self function_fe127aaf(localclientnum, var_ee6bcd51, str_fx);
}

function_3a020b0f(localclientnum, var_ee6bcd51, str_fx) {
  self good_barricade_damaged(localclientnum);
  self function_fe127aaf(localclientnum, var_ee6bcd51, str_fx);
}

good_barricade_damaged(localclientnum) {
  if(isDefined(self.var_12b59dee)) {
    self stoprenderoverridebundle(self.var_12b59dee, "j_head");
    self.var_12b59dee = undefined;
  }

  if(isDefined(self.var_3231a850)) {
    stopfx(localclientnum, self.var_3231a850);
    self.var_3231a850 = undefined;
  }
}

private function_fe127aaf(localclientnum, var_ee6bcd51, str_fx) {
  if(isDefined(var_ee6bcd51)) {
    self playrenderoverridebundle(var_ee6bcd51, "j_head");
    self.var_12b59dee = var_ee6bcd51;
  }

  if(isDefined(str_fx)) {
    if(isDefined(self.var_f87f8fa0)) {
      self.var_3231a850 = util::playFXOnTag(localclientnum, str_fx, self, self.var_f87f8fa0);
      return;
    }

    self.var_3231a850 = util::playFXOnTag(localclientnum, str_fx, self, "j_eyeball_le");
  }
}

zombie_eye_glow(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    self function_704f7c0e(localclientnum);
    return;
  }

  self good_barricade_damaged(localclientnum);
}