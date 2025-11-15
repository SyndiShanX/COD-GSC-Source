/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 3082.gsc
************************/

func_35A6(param_00) {
  self.var_10264 = 1;
  self.var_3135.var_E5FA = 1;
  lib_0A16::func_98D2();
  lib_0C09::func_97F9();
  lib_0C0B::func_98DD();
  self.var_290A = 0;
  self.objective_team = "c8_grenade";
  self.meleerangesq = 128;
  self.meleechargedist = 128;
  self.meleechargedistvsplayer = 128;
  self.meleechargedistreloadmultiplier = 1;
  self.var_B627 = 36;
  self.meleeactorboundsradius = 60;
  self.acceptablemeleefraction = 0.98;
  self.var_B5DA = 1;
  self.var_B64F = 400;
  self.fnismeleevalid = ::lib_0C08::func_35AD;
  self.closefile = 0;
  func_170A();
  return level.success;
}

func_170A() {
  self.var_3135.var_ACB4 = [];
  self.var_3135.var_ACB4[self.var_3135.var_ACB4.size] = func_4911("j_clavicle_inner_ri");
  self.var_3135.var_ACB4[self.var_3135.var_ACB4.size] = func_4911("j_clavicle_inner_le");
  self.var_3135.var_71C9 = ::func_E138;
}

func_4911(param_00) {
  var_01 = spawn("script_model", self.origin);
  var_01 setModel("tag_origin");
  var_01 linkto(self, param_00, (10, 0, 0), (0, 0, 0));
  if(self.team == "axis") {
    playFXOnTag(level.var_7649["c12_enemy_light"], var_01, "tag_origin");
  } else {
    playFXOnTag(level.var_7649["c12_ally_light"], var_01, "tag_origin");
  }

  return var_01;
}

func_E138() {
  if(isDefined(self.var_3135.var_ACB4)) {
    foreach(var_01 in self.var_3135.var_ACB4) {
      if(isDefined(var_01)) {
        var_01 delete();
      }
    }
  }
}