/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_weap_staff_fire.csc
*************************************************/

#using scripts\shared\clientfield_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_weap_staff_common;
#namespace zm_weap_staff_fire;

function autoexec __init__sytem__() {
  system::register("zm_weap_staff_fire", &__init__, undefined, undefined);
}

function __init__() {
  clientfield::register("actor", "fire_char_fx", 21000, 1, "int", &function_657b61e3, 0, 0);
  clientfield::register("toplayer", "fire_muzzle_fx", 21000, 1, "counter", &fire_muzzle_fx, 0, 0);
  level._effect["fire_muzzle"] = "dlc5/zmb_weapon/fx_staff_fire_muz_flash_1p";
  level._effect["fire_muzzle_ug"] = "dlc5/zmb_weapon/fx_staff_fire_muz_flash_1p_ug";
  zm_weap_staff::function_4be5e665(getweapon("staff_fire_upgraded"), "dlc5/zmb_weapon/fx_staff_charge_fire_lv1");
}

function fire_muzzle_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(newval == 1) {
    if(hasweapon(localclientnum, getweapon("staff_fire_upgraded"))) {
      playviewmodelfx(localclientnum, level._effect["fire_muzzle_ug"], "tag_flash");
    } else {
      playviewmodelfx(localclientnum, level._effect["fire_muzzle"], "tag_flash");
    }
    playSound(localclientnum, "wpn_firestaff_fire_plr");
  }
}

function function_657b61e3(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  self endon("entityshutdown");
  rate = randomfloatrange(0.01, 0.015);
  if(isDefined(self.var_a90ff836)) {
    stopfx(localclientnum, self.var_a90ff836);
    self.var_a90ff836 = undefined;
  }
  if(isDefined(self.var_44f239e3)) {
    stopfx(localclientnum, self.var_44f239e3);
    self.var_44f239e3 = undefined;
  }
  if(isDefined(self.sndent)) {
    self.sndent notify("snddeleting");
    self.sndent delete();
    self.sndent = undefined;
  }
  if(newval == 1) {
    self.var_a90ff836 = playFXOnTag(localclientnum, level._effect["character_fire_death_torso"], self, "j_spinelower");
    self.var_44f239e3 = playFXOnTag(localclientnum, level._effect["character_fire_death_sm"], self, "j_head");
    self.sndent = spawn(0, self.origin, "script_origin");
    self.sndent linkto(self);
    self.sndent playLoopSound("zmb_fire_loop", 0.5);
    self.sndent thread snddeleteent(self);
    if(!(isDefined(self.var_ff3ddd5b) && self.var_ff3ddd5b)) {
      self.var_ff3ddd5b = 1;
    }
    var_5e5728a8 = 1;
    var_2094128c = 0.6;
    for(i = 0; i < 2; i++) {
      f = 0.6;
      while(f <= 0.85) {
        util::server_wait(localclientnum, 0.05);
        self setshaderconstant(localclientnum, 0, f, 0, 0, 0);
        f = f + rate;
      }
      f = 0.85;
      while(f >= 0.6) {
        util::server_wait(localclientnum, 0.05);
        self setshaderconstant(localclientnum, 0, f, 0, 0, 0);
        f = f - rate;
      }
    }
    f = 0.6;
    while(f <= 1) {
      util::server_wait(localclientnum, 0.05);
      self setshaderconstant(localclientnum, 0, f, 0, 0, 0);
      f = f + rate;
    }
  }
}

function snddeleteent(zomb) {
  self endon("snddeleting");
  zomb waittill("entityshutdown");
  self delete();
}