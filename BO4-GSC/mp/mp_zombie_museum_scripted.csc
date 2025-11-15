/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\mp_zombie_museum_scripted.csc
***********************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;

#namespace mp_zombie_museum_scripted;

autoexec __init__system__() {
  system::register(#"mp_zombie_museum_scripted", &__init__, undefined, undefined);
}

__init__() {
  clientfield::register("scriptmover", "zombie_has_eyes", 1, 1, "int", &zombie_eyes_clientfield_cb, 0, 0);
  clientfield::register("scriptmover", "exhibit_vo", 1, 4, "int", &exhibit_vo, 0, 0);
  level._effect[#"hash_61fce653578d7f82"] = #"zm_ai/fx8_zombie_eye_glow_orange";
}

zombie_eyes_clientfield_cb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(isDefined(self.eye_rob)) {
    self stoprenderoverridebundle(self.eye_rob, "j_head");
  }

  if(isDefined(self.var_3231a850)) {
    stopfx(localclientnum, self.var_3231a850);
    self.var_3231a850 = undefined;
  }

  if(newval) {
    self.eye_rob = "rob_zm_eyes_red";
    var_d40cd873 = "eye_glow";
    self playrenderoverridebundle(self.eye_rob, "j_head");
    self.var_3231a850 = util::playFXOnTag(localclientnum, level._effect[#"hash_61fce653578d7f82"], self, "j_eyeball_le");
  }
}

exhibit_vo(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval === 0 || oldval === newval) {
    return;
  }

  var_da2f311e = [];
  var_da2f311e[1] = [];
  var_da2f311e[2] = [];
  var_da2f311e[3] = [];
  var_da2f311e[4] = [];
  var_da2f311e[1][0] = "vox_muse_exhibit_asylum_0";
  var_da2f311e[1][1] = "vox_muse_exhibit_asylum_1";
  var_da2f311e[1][2] = "vox_muse_exhibit_asylum_2";
  var_da2f311e[1][3] = "vox_muse_exhibit_asylum_3";
  var_da2f311e[1][4] = "vox_muse_exhibit_asylum_4";
  var_da2f311e[1][5] = "vox_muse_exhibit_asylum_5";
  var_da2f311e[2][0] = "vox_muse_exhibit_moon_0";
  var_da2f311e[2][1] = "vox_muse_exhibit_moon_1";
  var_da2f311e[2][2] = "vox_muse_exhibit_moon_2";
  var_da2f311e[2][3] = "vox_muse_exhibit_moon_3";
  var_da2f311e[2][4] = "vox_muse_exhibit_moon_4";
  var_da2f311e[2][5] = "vox_muse_exhibit_moon_5";
  var_da2f311e[2][5] = "vox_muse_exhibit_moon_6";
  var_da2f311e[2][5] = "vox_muse_exhibit_moon_7";
  var_da2f311e[3][0] = "vox_muse_exhibit_titanic_0";
  var_da2f311e[3][1] = "vox_muse_exhibit_titanic_1";
  var_da2f311e[3][2] = "vox_muse_exhibit_titanic_2";
  var_da2f311e[3][3] = "vox_muse_exhibit_titanic_3";
  var_da2f311e[3][4] = "vox_muse_exhibit_titanic_4";
  var_da2f311e[3][5] = "vox_muse_exhibit_titanic_5";
  var_da2f311e[3][6] = "vox_muse_exhibit_titanic_6";
  var_da2f311e[3][7] = "vox_muse_exhibit_titanic_7";
  var_da2f311e[3][8] = "vox_muse_exhibit_titanic_8";
  var_da2f311e[3][9] = "vox_muse_exhibit_titanic_9";
  var_da2f311e[4][0] = "vox_muse_exhibit_tranzit_0";
  var_da2f311e[4][1] = "vox_muse_exhibit_tranzit_1";
  var_da2f311e[4][2] = "vox_muse_exhibit_tranzit_2";
  var_da2f311e[4][3] = "vox_muse_exhibit_tranzit_3";
  var_da2f311e[4][4] = "vox_muse_exhibit_tranzit_4";
  var_da2f311e[4][5] = "vox_muse_exhibit_tranzit_5";
  var_da2f311e[4][6] = "vox_muse_exhibit_tranzit_6";
  var_da2f311e[4][7] = "vox_muse_exhibit_tranzit_7";
  var_da2f311e[4][8] = "vox_muse_exhibit_tranzit_8";
  var_da2f311e[4][9] = "vox_muse_exhibit_tranzit_9";

  if(!isDefined(var_da2f311e[newval])) {
    return;
  }

  foreach(alias in var_da2f311e[newval]) {
    if(isDefined(alias) && isDefined(self) && isDefined(self.origin)) {
      id = playSound(localclientnum, alias, self.origin);

      while(isDefined(id) && soundplaying(id)) {
        waitframe(1);
      }
    }

    wait 0.2;
  }
}