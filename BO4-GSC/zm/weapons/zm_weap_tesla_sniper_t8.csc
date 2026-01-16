/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\weapons\zm_weap_tesla_sniper_t8.csc
**************************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\system_shared;

#namespace zm_weap_tesla_sniper_t8;

autoexec __init__system__() {
  system::register(#"tesla_sniper", &__init__, undefined, undefined);
}

__init__() {
  level.w_tesla_sniper_t8 = getweapon(#"ww_tesla_sniper_t8");
  level.w_tesla_sniper_upgraded_t8 = getweapon(#"ww_tesla_sniper_upgraded_t8");
  level.var_490afdb9 = array(undefined, "zm_weapons/fx8_ww_tesla_sniper_bulb_d", "zm_weapons/fx8_ww_tesla_sniper_bulb_c", "zm_weapons/fx8_ww_tesla_sniper_bulb_b", "zm_weapons/fx8_ww_tesla_sniper_bulb_a");
  clientfield::register("toplayer", "" + #"hash_3aad9502fc3b54f2", 24000, 1, "int", &function_87dc06ae, 0, 0);
  clientfield::register("actor", "zm_weapons/fx8_ww_tesla_sniper_impact_lg", 24000, 1, "counter", &function_190ae9a1, 0, 0);
}

private function_190ae9a1(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  origin = self gettagorigin("j_spine4");

  if(isDefined(self) && newval && isDefined(origin)) {
    playFX(localclientnum, "zm_weapons/fx8_ww_tesla_sniper_impact_lg", self gettagorigin("j_spine4"));
  }
}

function_87dc06ae(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(newval) {
    self thread function_2d6416dc(localclientnum);
    return;
  }

  self notify(#"hash_319d2bba47dac2c4");
  self function_a6907b54(localclientnum);
}

function_2d6416dc(localclientnum) {
  self endon(#"death", #"hash_319d2bba47dac2c4");
  w_current = getcurrentweapon(localclientnum);
  n_clip_size = w_current.clipsize;

  if(!isDefined(n_clip_size) || n_clip_size == 0) {
    if(w_current === level.w_tesla_sniper_upgraded_t8) {
      n_clip_size = 16;
    } else {
      n_clip_size = 8;
    }
  }

  if(!isDefined(self.var_7ad5becf)) {
    self.var_7ad5becf = [];
  }

  while(true) {
    wait 0.1;

    if(viewmodelhastag(localclientnum, "tag_flash")) {
      n_ammo = getweaponammoclip(localclientnum, w_current);
      var_b59ce28 = n_ammo / n_clip_size;
      var_7ec33855 = int(ceil(var_b59ce28 * 4));

      for(i = 1; i <= 4; i++) {
        if(i <= var_7ec33855 && !isDefined(self.var_7ad5becf[i])) {
          self.var_7ad5becf[i] = playviewmodelfx(localclientnum, level.var_490afdb9[i], "tag_flash");
        }

        if(i > var_7ec33855 && isDefined(self.var_7ad5becf[i])) {
          deletefx(localclientnum, self.var_7ad5becf[i], 1);
          self.var_7ad5becf[i] = undefined;
        }
      }
    }
  }
}

function_a6907b54(localclientnum) {
  for(i = 1; i <= 4; i++) {
    if(isDefined(self.var_7ad5becf[i])) {
      deletefx(localclientnum, self.var_7ad5becf[i], 1);
      self.var_7ad5becf[i] = undefined;
    }
  }
}