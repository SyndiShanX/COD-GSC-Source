/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: killstreaks\sparrow.gsc
***********************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\status_effects\status_effect_util;
#using scripts\core_common\system_shared;
#using scripts\killstreaks\killstreaks_shared;
#using scripts\weapons\weapons;
#namespace sparrow;

function private autoexec __init__system__() {
  system::register(#"sparrow", &__init__, undefined, undefined, #"killstreaks");
}

function __init__() {
  killstreaks::register_killstreak("killstreak_sparrow", &killstreaks::function_fc82c544);
  weapon = getweapon("sig_bow_flame");
  inventoryweapon = getweapon("inventory_sig_bow_flame");
  var_2bd3ceea = getstatuseffect(#"dot_sig_bow_flame");

  if(!isDefined(level.var_cc63b5fe)) {
    level.var_cc63b5fe = [];
  }

  level.var_cc63b5fe[weapon] = var_2bd3ceea;
  level.var_cc63b5fe[inventoryweapon] = var_2bd3ceea;
  callback::add_weapon_damage(weapon, &function_8ea68ead);
  callback::add_weapon_damage(inventoryweapon, &function_8ea68ead);
}

function function_8ea68ead(eattacker, einflictor, weapon, meansofdeath, damage) {
  if(!isPlayer(self)) {
    return;
  }

  if(self isplayerswimming()) {
    return;
  }

  if(isDefined(weapon) && is_under_water(weapon.origin)) {
    return;
  }

  if(damage == "MOD_DOT") {
    return;
  }

  var_8d498080 = getstatuseffect(#"dot_sig_bow_flame");
  self status_effect::status_effect_apply(var_8d498080, meansofdeath, einflictor);
}

function event_handler[missile_fire] function_8cd77cf6(eventstruct) {
  if(!isPlayer(self)) {
    return;
  }

  missile = eventstruct.projectile;
  weapon = eventstruct.weapon;
  missile thread function_1bb4a86d();
  missile thread function_be16c377();

  if(function_119a2a90(weapon)) {
    missile.soundmod = "player";
    missile thread weapons::check_stuck_to_player(1, 0, weapon);
    waitresult = missile waittill(#"projectile_impact_explode", #"projectile_impact_player", #"bow_projectile_deleted");

    if(waitresult._notify == "bow_projectile_deleted") {
      return;
    }

    bundle = killstreaks::get_script_bundle(weapon.name);

    if(isDefined(waitresult.normal)) {
      fxforward = waitresult.normal;
    } else {
      fxforward = vectornormalize(missile.var_59ba00f5) * -1;
    }

    position = missile.origin;

    if(is_under_water(position)) {
      if(isDefined(bundle.var_6512abed)) {
        explosionfx = bundle.var_6512abed;
      }
    } else if(waitresult._notify == "projectile_impact_player") {
      if(isDefined(bundle.var_2636f3b9)) {
        explosionfx = bundle.var_2636f3b9;
      }
    } else if(isDefined(bundle.var_b41d3fc0)) {
      explosionfx = bundle.var_b41d3fc0;
    }

    if(isDefined(explosionfx)) {
      angles = vectortoangles(fxforward);
      playFX(explosionfx, position, fxforward, anglestoup(angles));
    }
  }
}

function function_1bb4a86d() {
  self waittill(#"death");
  waittillframeend();
  self notify(#"bow_projectile_deleted");
}

function function_be16c377() {
  self endon(#"projectile_impact_explode", #"death");

  while(true) {
    self.var_59ba00f5 = self getvelocity();
    wait float(function_60d95f53()) / 1000;
  }
}

function is_under_water(position) {
  water_depth = getwaterheight(position) - position[2];
  return water_depth >= 16;
}

function private function_119a2a90(weapon) {
  return weapon.statname == "sig_bow_flame";
}