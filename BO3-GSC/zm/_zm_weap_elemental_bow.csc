/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_weap_elemental_bow.csc
*************************************************/

#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\system_shared;
#namespace zm_weap_elemental_bow;

function autoexec __init__sytem__() {
  system::register("_zm_weap_elemental_bow", & __init__, undefined, undefined);
}

function __init__() {
  clientfield::register("toplayer", "elemental_bow" + "_ambient_bow_fx", 5000, 1, "int", & function_5b4bf635, 0, 0);
  clientfield::register("missile", "elemental_bow" + "_arrow_impact_fx", 5000, 1, "int", & function_4e8aa99, 0, 0);
  clientfield::register("missile", "elemental_bow4" + "_arrow_impact_fx", 5000, 1, "int", & function_bdaa35c, 0, 0);
  level._effect["elemental_bow_ambient_bow"] = "dlc1/zmb_weapon/fx_bow_default_ambient_1p_zmb";
  level._effect["elemental_bow_arrow_impact"] = "dlc1/zmb_weapon/fx_bow_default_impact_zmb";
  level._effect["elemental_bow_arrow_charged_impact"] = "dlc1/zmb_weapon/fx_bow_default_impact_ug_zmb";
  setdvar("bg_chargeShotUseOneAmmoForMultipleBullets", 0);
  setdvar("bg_zm_dlc1_chargeShotMultipleBulletsForFullCharge", 2);
}

function function_5b4bf635(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self function_3158b481(localclientnum, newval, "elemental_bow_ambient_bow");
}

function function_4e8aa99(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    playFX(localclientnum, level._effect["elemental_bow_arrow_impact"], self.origin);
  }
}

function function_bdaa35c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    playFX(localclientnum, level._effect["elemental_bow_arrow_charged_impact"], self.origin);
  }
}

function function_e5c5e30(localclientnum, str_fx_name) {
  if(isDefined(self.var_505704d9) && isDefined(self.var_505704d9[str_fx_name])) {
    deletefx(localclientnum, self.var_505704d9[str_fx_name], 1);
  }
  if(isDefined(self.var_a96110c3) && isDefined(self.var_a96110c3[str_fx_name])) {
    deletefx(localclientnum, self.var_a96110c3[str_fx_name], 1);
  }
  self notify("hash_74395f6a");
}

function function_3158b481(localclientnum, newval, str_fx_name) {
  function_e5c5e30(localclientnum, str_fx_name);
  if(newval) {
    if(!isspectating(localclientnum)) {
      currentweapon = getcurrentweapon(localclientnum);
      if(issubstr(currentweapon.name, "elemental_bow")) {
        self.var_505704d9[str_fx_name] = playviewmodelfx(localclientnum, level._effect[str_fx_name], "tag_fx_02");
        self.var_a96110c3[str_fx_name] = playviewmodelfx(localclientnum, level._effect[str_fx_name], "tag_fx_03");
      }
    }
    if(isdemoplaying()) {
      self thread function_74395f6a(localclientnum, str_fx_name);
    }
  }
}

function function_74395f6a(localclientnum, str_fx_name) {
  self notify("hash_74395f6a");
  self endon("hash_74395f6a");
  level waittill("demo_plplayer_change", lcn, var_fcf6978f, newplayer);
  var_fcf6978f function_e5c5e30(localclientnum, str_fx_name);
}