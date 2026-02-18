/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: weapons\nightingale.csc
***********************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace nightingale;

function private autoexec __init__system__() {
  system::register(#"nightingale", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  clientfield::register("scriptmover", "" + # "nightingale_deployed", 1, 1, "int", &nightingale_deployed, 0, 0);
  clientfield::register("scriptmover", "" + # "hash_7c2ee5bfa7cad803", 1, 1, "int", &function_52240d18, 0, 0);

  if(!isDefined(level.var_17d9f80)) {
    level.var_17d9f80 = [];
  }

  callback::add_weapon_type(#"nightingale", &function_85f37224);
  level.var_4977c64a = getweapon(#"nightingale");
  level.nightingale_custom_settings = getscriptbundle(level.var_4977c64a.customsettings);
}

function private function_85f37224(localclientnum) {
  arrayremovevalue(level.var_17d9f80, undefined, 1);
  level.var_17d9f80[self getentitynumber()] = self;
}

function nightingale_deployed(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump) {
    team = function_73f4b33(fieldname);
    self.identifier_weapon = level.var_4977c64a;

    if(team === self.team) {
      self function_1f0c7136(1);
    } else {
      self function_525db0b1(1);
    }

    level.var_17d9f80[self getentitynumber()] = self;
  }
}

function function_52240d18(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump) {
    fx = level.nightingale_custom_settings.activefx;

    if(isDefined(fx)) {
      tag = isDefined(level.nightingale_custom_settings.var_8751c5bd) ? level.nightingale_custom_settings.var_8751c5bd : "tag_origin";
      self.activefx = util::playFXOnTag(fieldname, fx, self, tag);
    }

    return;
  }

  if(isDefined(self.activefx)) {
    stopfx(fieldname, self.activefx);
    self.activefx = undefined;
  }
}