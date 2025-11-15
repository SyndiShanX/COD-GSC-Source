/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: weapons\shockrifle.csc
***********************************************/

#include scripts\core_common\blood;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\postfx_shared;
#include scripts\core_common\util_shared;
#include scripts\weapons\weaponobjects;

#namespace shockrifle;

init_shared() {
  clientfield::register("toplayer", "shock_rifle_shocked", 1, 1, "int", &shock_rifle_shocked, 0, 0);
  clientfield::register("toplayer", "shock_rifle_damage", 1, 1, "int", &shock_rifle_damage, 0, 0);
  clientfield::register("allplayers", "shock_rifle_sound", 1, 1, "int", &shock_rifle_sound, 0, 0);
}

shock_rifle_shocked(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "hudItems.playerIsShocked"), 1);
    return;
  }

  setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "hudItems.playerIsShocked"), 0);
}

shock_rifle_damage(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    splatter = blood::getsplatter(localclientnum);
    splatter.shockrifle = 1;
  }
}

shock_rifle_sound(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    self playLoopSound("wpn_shockrifle_electrocution");
    return;
  }

  self stopallloopsounds();
}