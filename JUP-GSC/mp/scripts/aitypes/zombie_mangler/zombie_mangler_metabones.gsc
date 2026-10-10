/**************************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\aitypes\zombie_mangler\zombie_mangler_metabones.gsc
**************************************************************************/

#using script_16ea1b94f0f381b3;
#using script_35ccbf5e9962bcaa;
#using scripts\asm\asm;
#using scripts\common\callbacks;
#using scripts\common\metabone;
#using scripts\engine\utility;
#namespace zombie_mangler_metabones;

function autoexec main() {
  var_601bcee5d276f46d = "zombie_mangler";
  metabone::function_d6736c5ef5ac2990(var_601bcee5d276f46d, &function_b9f4b7206d76e7ce);
}

function private function_b9f4b7206d76e7ce(params) {
  var_c02b1f6c1721c844 = params.var_c02b1f6c1721c844;
  metabone::function_3d2728c0e2252a1d(var_c02b1f6c1721c844, "destroyed");
  metabone::function_7380ccd6f2c49392(var_c02b1f6c1721c844, 1);
  var_36a1e9c4ae94fe26 = "destroyed";

  if(var_c02b1f6c1721c844 == "armored_torso" || var_c02b1f6c1721c844 == "armored_head") {
    namespace_277ce153e9305d9d::function_d04d397bd793d2a3(15, 1);
  } else if(var_c02b1f6c1721c844 == "j_weapon_spin") {
    self function_3e89eb3d8e3f1811("can_ranged_attack", 0);
    self function_3e89eb3d8e3f1811("torpedo_attack_interrupted", 1);
    self setscriptablepartstate("cannon_charge", "default");
    self.var_f719fcdc90b79bb8 = 1;
    destroy_damage = self.maxhealth * self.var_48a12f8371457fbb;

    if(self.zombieaisettings.var_e58a65b7a8f5973c.var_c7869dfe1aa33f55 && isDefined(self.zombieaisettings.var_e58a65b7a8f5973c.var_8ccd14d6a1cff2bf)) {
      pos = self gettagorigin("j_weapon_spin");
      function_38e113a4c30f6c0d(self.zombieaisettings.var_e58a65b7a8f5973c.var_8ccd14d6a1cff2bf, pos);
      var_36a1e9c4ae94fe26 += "_loot";
    }

    if(isPlayer(params.eattacker)) {
      params.eattacker function_e800498086e36c29(#"mangler_mangled");
    }

    self dodamage(destroy_damage, self.origin, params.eattacker, params.einflictor, "MOD_EXPLOSIVE", undefined, "right_arm_upper", undefined, 65536);

    if(isalive(self)) {
      namespace_277ce153e9305d9d::function_d04d397bd793d2a3(0, 1);
    }
  }

  if(!istrue(self function_11e2d4051ea44b35("in_torpedo_attack"))) {
    if(isalive(self)) {
      self notify("vox_pain");
      asm::function_ac90fa5cc0a80298("special_pain_in");
    }
  }

  if(isalive(self)) {
    self setscriptablepartstate(var_c02b1f6c1721c844, var_36a1e9c4ae94fe26);
  }
}