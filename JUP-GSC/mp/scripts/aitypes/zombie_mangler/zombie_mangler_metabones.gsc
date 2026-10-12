/***********************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\aitypes\zombie_mangler\zombie_mangler_metabones.gsc
***********************************************************************/

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
  metabone_name = params.metabone_name;
  metabone::function_3d2728c0e2252a1d(metabone_name, "destroyed");
  metabone::function_7380ccd6f2c49392(metabone_name, 1);
  var_36a1e9c4ae94fe26 = "destroyed";

  if(metabone_name == "armored_torso" || metabone_name == "armored_head") {
    zombie_mangler_berserk::function_d04d397bd793d2a3(15, 1);
  } else if(metabone_name == "j_weapon_spin") {
    self function_3e89eb3d8e3f1811("can_ranged_attack", 0);
    self function_3e89eb3d8e3f1811("torpedo_attack_interrupted", 1);
    self setscriptablepartstate("cannon_charge", "default");
    self.var_f719fcdc90b79bb8 = 1;
    destroy_damage = self.maxhealth * self.var_48a12f8371457fbb;

    if(self.zombieaisettings.var_e58a65b7a8f5973c.var_c7869dfe1aa33f55 && isDefined(self.zombieaisettings.var_e58a65b7a8f5973c.manglercannonlootname)) {
      pos = self gettagorigin("j_weapon_spin");
      spawnnewitemfromscriptablesharedfunc(self.zombieaisettings.var_e58a65b7a8f5973c.manglercannonlootname, pos);
      var_36a1e9c4ae94fe26 += "_loot";
    }

    if(isPlayer(params.eattacker)) {
      params.eattacker doscoreeventsharedfunc(#"mangler_mangled");
    }

    self dodamage(destroy_damage, self.origin, params.eattacker, params.einflictor, "MOD_EXPLOSIVE", undefined, "right_arm_upper", undefined, 65536);

    if(isalive(self)) {
      zombie_mangler_berserk::function_d04d397bd793d2a3(0, 1);
    }
  }

  if(!istrue(self getaiblackboarddynamic("in_torpedo_attack"))) {
    if(isalive(self)) {
      self notify("vox_pain");
      asm::function_ac90fa5cc0a80298("special_pain_in");
    }
  }

  if(isalive(self)) {
    self setscriptablepartstate(metabone_name, var_36a1e9c4ae94fe26);
  }
}