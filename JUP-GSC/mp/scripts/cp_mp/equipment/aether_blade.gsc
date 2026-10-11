/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\cp_mp\equipment\aether_blade.gsc
*******************************************************/

#using script_16ea1b94f0f381b3;
#using script_7edf952f8921aa6b;
#using scripts\common\ai;
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\cp_mp\agents\agent_utils;
#using scripts\cp_mp\equipment;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\cp_mp\weapon;
#using scripts\engine\utility;
#using scripts\mp\utility\debug;
#using scripts\mp\utility\perk;
#using scripts\mp\utility\player;
#using scripts\mp\weapons;
#namespace aether_blade;

function private autoexec __init__system__() {
  system::register(#"aether_blade", undefined, undefined, &post_main);
}

function private post_main() {
  utility::registersharedfunc("aether_blade", "on_grenade_used", &function_cf74876710a7b4db);
  level._effect["aether_blade_trail"] = loadfx("vfx/jup/ob/gameplay/zm_weapons/vfx_dark_aether_blade_trail.vfx");
  level._effect["aether_blade_impact"] = loadfx("vfx/jup/ob/gameplay/zm_weapons/vfx_dark_aether_blade_impact.vfx");
  level._effect["aether_blade_ambient"] = loadfx("vfx/jup/ob/gameplay/zm_weapons/vfx_dark_aether_blade_ambient.vfx");
  function_b5e57408c7878df7(&function_22b8784cdb8fd331);
  function_9a024cd909d6e0a3(&function_22b8784cdb8fd331);
  level thread function_a8702248c4c1759f();
}

function function_a8702248c4c1759f() {
  level endon("game_ended");

  while(true) {
    if(!isDefined(level.equipment) || !isDefined(level.equipment.callbacks)) {
      wait 5;
      continue;
    }

    break;
  }

  level.equipment.callbacks["equip_aether_blade"]["onGive"] = &function_a68e5603c7546cba;
  level.equipment.callbacks["equip_aether_blade"]["onTake"] = &function_e108b8d3ebf02f60;
}

function function_a68e5603c7546cba(equipmentref, equipmentslot, variantid) {
  if(_hasperk("specialty_equip_throwingKnife")) {
    scripts\mp\weapons::function_ec132c173d4532ee("specialty_equip_throwingKnife");
  }

  self.throwingknifemelee = scripts\cp_mp\weapon::buildweapon_blueprint("iw9_knifestab_mp", "none", "none", 3);
  scripts\mp\weapons::weapon_giveperk("specialty_equip_throwingKnife");
}

function function_e108b8d3ebf02f60(equipmentref, equipmentslot) {
  if(_hasperk("specialty_equip_throwingKnife")) {
    scripts\mp\weapons::function_ec132c173d4532ee("specialty_equip_throwingKnife");
  }

  self.throwingknifemelee = undefined;
}

function private function_cf74876710a7b4db(grenade) {
  grenade endon("death");

  if(false) {
    grenade waittill("missile_stuck");
  } else {
    grenade waittill_notify_or_timeout("missile_stuck", 0.2);
  }

  self radiusdamage(grenade.origin, 10, 10, 10, self, "MOD_UNKNOWN", grenade.weapon_name);

  if(getdvarint(@ "hash_621db215d72a8a8b", 0)) {
    level thread scripts\mp\utility\debug::drawsphere(grenade.origin, 10, 5, (0, 1, 0));
  }

  grenade hide();
  grenade delaycallendon(3, "death", &delete);
  var_dc9f68978ae89177 = spawn("script_model", grenade.origin);
  var_dc9f68978ae89177 setModel("jup_2h_zmb_aether_knife");
  var_dc9f68978ae89177 show();
  var_dc9f68978ae89177.owner = self;
  var_dc9f68978ae89177.equipmentref = grenade.equipmentref;
  var_dc9f68978ae89177.weaponobj = grenade.weapon_object;
  var_dc9f68978ae89177 thread function_4c4fcfe9c8aa6aa8();
  fx = playFXOnTag(level._effect["aether_blade_trail"], var_dc9f68978ae89177, "tag_origin");
  fx_ambient = playFXOnTag(level._effect["aether_blade_ambient"], var_dc9f68978ae89177, "tag_origin");
  var_dc9f68978ae89177 playLoopSound("eqp_aether_blade_travel_lp");
  var_dc9f68978ae89177 thread function_24766c1e016e99e7(3, undefined, self.team);
}

function private function_4c4fcfe9c8aa6aa8() {
  self endon("death");

  while(true) {
    self rotatepitch(self.angles[0] + 180, 0.25);
    wait 0.25;
  }
}

function private function_a089a977a3191071(is_melee) {
  if(isPlayer(self)) {
    return getdvarint(@ "hash_cbebae73e53fc3c1", 40);
  }

  pct_value = 0;
  max_health = ter_op(isDefined(self.maxhealth), self.maxhealth, 100);

  if(ai::function_f6347c9c410226d3()) {
    if(isDefined(self.aicategory) && self.aicategory == "boss") {
      pct_value = ter_op(is_melee, 0.01, 0.05);
    } else {
      pct_value = ter_op(is_melee, 0.05, 0.1);
    }
  } else {
    pct_value = ter_op(is_melee, 0.5, 1);
  }

  return max_health * pct_value;
}

function private function_24766c1e016e99e7(target_num, last_target, player_team) {
  if(target_num == 0) {
    thread function_9e47843c258164df();
    return;
  }

  ai_targets = getaiarrayinradius(self.origin, 300);
  var_4e83f2f535a21158 = [];

  foreach(ai in ai_targets) {
    if(is_equal(ai.team, player_team) || isDefined(last_target) && ai == last_target) {
      continue;
    }

    var_4e83f2f535a21158 = array_add(var_4e83f2f535a21158, ai);
  }

  if(istrue(level.var_e29a4ad5667a5bd9)) {
    var_4e83f2f535a21158 = function_d01f4c5bbf6a97ed(self, var_4e83f2f535a21158, player_team, last_target);
  }

  var_4e83f2f535a21158 = sortbydistance(var_4e83f2f535a21158, self.origin);
  final_target = var_4e83f2f535a21158[0];

  if(isDefined(final_target)) {
    end_point = function_549b33edb429d231(final_target);
    fly_distance = distance(self.origin, end_point);
    self moveTo(end_point, fly_distance / 1500);
    self waittill("movedone");
    playFXOnTag(level._effect["aether_blade_impact"], self, "tag_origin");
    var_f5c2f3b667f81c15 = final_target function_a089a977a3191071(0);
    final_target thread scripts\engine\utility::callsharedfunc("relics", "blade_throw_hit", self.owner);
    final_target dodamage(var_f5c2f3b667f81c15, self.origin, self.owner, self, "MOD_ELEMENTAL_ELEC", self.weaponobj, "none");
  } else {
    thread function_9e47843c258164df();
    return;
  }

  thread function_24766c1e016e99e7(target_num - 1, final_target, player_team);
}

function private function_9e47843c258164df() {
  thread scripts\engine\utility::callsharedfunc("relics", "blade_throw_end", self.owner);
  end_point = function_45040fcdfcd2c447();

  if(!isDefined(end_point)) {
    self delete();
  }

  fly_distance = distance(self.origin, end_point);
  fly_time = fly_distance / 1500;
  self moveTo(end_point, fly_time);
  thread function_772ad3dc1621c404(fly_time);
  self waittill("movedone");

  if(isDefined(self.owner)) {
    self.owner playsoundtoplayer("eqp_aether_blade_plr_return", self.owner);
    self.owner function_2f62cf4de7c24634();
    self.owner thread function_faa63a4f3bcf6d02(self.equipmentref);
  }

  self delete();
}

function private function_2f62cf4de7c24634() {
  utility::function_3677f2be30fdd581("aether_blade_fx", "on");
  thread function_4301f1a5fdb9c675();
}

function private function_4301f1a5fdb9c675() {
  msg = waittill_any_timeout_1(1, "death");

  if(isDefined(self)) {
    utility::function_3677f2be30fdd581("aether_blade_fx", "off");
  }
}

function private function_772ad3dc1621c404(fly_time) {
  self endon("death");
  self endon("movedone");
  frame_duration = utility::default_to(level.framedurationseconds, 0.05);
  var_5d3e12763f61bd3e = fly_time - frame_duration;

  while(var_5d3e12763f61bd3e > 0) {
    waitframe();
    end_point = function_45040fcdfcd2c447();

    if(!isDefined(end_point)) {
      self delete();
    }

    self moveTo(end_point, var_5d3e12763f61bd3e);
    var_5d3e12763f61bd3e -= frame_duration;
  }
}

function private function_45040fcdfcd2c447() {
  if(!isalive(self.owner)) {
    return undefined;
  }

  player_center = self.owner gettagorigin("j_spine4");
  player_center = utility::default_to(player_center, self.owner getcentroid());
  return player_center;
}

function private function_1d982537b9dcb924(player) {
  if(!isPlayer(player)) {
    return false;
  }

  if(issharedfuncdefined("game", "isCommonItemEnabled")) {
    if(!callsharedfunc("game", "isCommonItemEnabled")) {
      return false;
    }

    if(!(issharedfuncdefined("game", "obtainItemEquip") && issharedfuncdefined("game", "getItemBundleNameFromRef"))) {
      return false;
    }

    return true;
  }

  return false;
}

function private function_d87312a81b75742d(equipmentref) {
  if(!isDefined(equipmentref) || !isalive(self)) {
    return;
  }

  if(function_1d982537b9dcb924(self)) {
    itembundlename = callsharedfunc("game", "getItemBundleNameFromRef", equipmentref);

    if(!isDefined(itembundlename)) {
      return;
    }

    itembundle = getscriptbundle("itemspawnentry:" + itembundlename);
    fakeitem = spawnStruct();
    fakeitem.count = 1;
    fakeitem.type = itembundle.scriptable;
    self playsoundtoplayer("eqp_aether_blade_plr_cooldown_end", self);
    callsharedfunc("game", "obtainItemEquip", fakeitem, 0, 1);
  }
}

function private function_549b33edb429d231(ai_target) {
  end_point = ai_target gettagorigin("J_SpineUpper", 1);

  if(!isDefined(end_point)) {
    end_point = ai_target.origin;
  }

  return end_point;
}

function private function_faa63a4f3bcf6d02(equipmentref) {
  self endon("death");
  wait 3;

  while(istrue(self.isjuggernaut)) {
    wait 1;
  }

  function_d87312a81b75742d(equipmentref);
}

function private function_22b8784cdb8fd331(params) {
  if(isPlayer(params.eattacker) && isDefined(params.objweapon) && params.objweapon.basename == "iw9_knifestab_mp" && isDefined(params.objweapon.variantid) && params.objweapon.variantid == 3) {
    return function_a089a977a3191071(1);
  }

  return -1;
}

function private function_d01f4c5bbf6a97ed(blade_model, var_4e83f2f535a21158, player_team, last_target) {
  player_targets = getplayersinradius(blade_model.origin, 300, 1000);

  foreach(target in player_targets) {
    if(is_equal(target.team, player_team) || !scripts\mp\utility\player::isreallyalive(target)) {
      continue;
    }

    if(isDefined(last_target) && target == last_target) {
      continue;
    }

    var_4e83f2f535a21158 = array_add(var_4e83f2f535a21158, target);
  }

  return var_4e83f2f535a21158;
}