/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_perk_widows_wine.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\clientfield_shared;
#using scripts\shared\system_shared;
#using scripts\shared\visionset_mgr_shared;
#using scripts\zm\_zm_perks;
#using scripts\zm\_zm_powerup_ww_grenade;
#namespace zm_perk_widows_wine;

function autoexec __init__sytem__() {
  system::register("zm_perk_widows_wine", & __init__, undefined, undefined);
}

function __init__() {
  zm_perks::register_perk_clientfields("specialty_widowswine", & widows_wine_client_field_func, & widows_wine_code_callback_func);
  zm_perks::register_perk_effects("specialty_widowswine", "widow_light");
  zm_perks::register_perk_init_thread("specialty_widowswine", & init_widows_wine);
  clientfield::register("toplayer", "widows_wine_1p_contact_explosion", 1, 1, "counter", & widows_wine_1p_contact_explosion, 0, 0);
}

function init_widows_wine() {
  if(isDefined(level.enable_magic) && level.enable_magic) {
    level._effect["widow_light"] = "zombie/fx_perk_widows_wine_zmb";
    level._effect["widows_wine_wrap"] = "zombie/fx_widows_wrap_torso_zmb";
  }
}

function widows_wine_client_field_func() {
  clientfield::register("clientuimodel", "hudItems.perks.widows_wine", 1, 2, "int", undefined, 0, 1);
  clientfield::register("actor", "widows_wine_wrapping", 1, 1, "int", & widows_wine_wrap_cb, 0, 1);
  clientfield::register("vehicle", "widows_wine_wrapping", 1, 1, "int", & widows_wine_wrap_cb, 0, 0);
}

function widows_wine_code_callback_func() {}

function widows_wine_wrap_cb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    if(isDefined(self) && isalive(self)) {
      if(!isDefined(self.fx_widows_wine_wrap)) {
        self.fx_widows_wine_wrap = playFXOnTag(localclientnum, level._effect["widows_wine_wrap"], self, "j_spineupper");
      }
      if(!isDefined(self.sndwidowswine)) {
        self playSound(0, "wpn_wwgrenade_cocoon_imp");
        self.sndwidowswine = self playLoopSound("wpn_wwgrenade_cocoon_lp", 0.1);
      }
    }
  } else {
    if(isDefined(self.fx_widows_wine_wrap)) {
      stopfx(localclientnum, self.fx_widows_wine_wrap);
      self.fx_widows_wine_wrap = undefined;
    }
    if(isDefined(self.sndwidowswine)) {
      self playSound(0, "wpn_wwgrenade_cocoon_stop");
      self stoploopsound(self.sndwidowswine, 0.1);
    }
  }
}

function widows_wine_1p_contact_explosion(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  owner = self getowner(localclientnum);
  if(isDefined(owner) && owner == getlocalplayer(localclientnum)) {
    thread widows_wine_1p_contact_explosion_play(localclientnum);
  }
}

function widows_wine_1p_contact_explosion_play(localclientnum) {
  tag = "tag_flash";
  if(!viewmodelhastag(localclientnum, tag)) {
    tag = "tag_weapon";
    if(!viewmodelhastag(localclientnum, tag)) {
      return;
    }
  }
  fx_contact_explosion = playviewmodelfx(localclientnum, "zombie/fx_widows_exp_1p_zmb", tag);
  wait(2);
  deletefx(localclientnum, fx_contact_explosion, 1);
}