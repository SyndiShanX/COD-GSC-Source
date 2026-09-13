/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_6172179f6bd0769e.gsc
***********************************************/

_id_4C60C607A6E7B9AE() {
  _id_AED74300DAF62896 = spawnStruct();
  _id_AED74300DAF62896._id_B586C70B173DD02B = [];
  _id_AED74300DAF62896.name = "mi8jugg";
  _id_AED74300DAF62896._id_C8CDA7EEE067D67C = "MP_DMZ_MISSIONS/DMZ_BOSS_JUGG_NAME";
  _id_AED74300DAF62896._id_EC2EC5F083DF61CD = ::_id_D05835744FF53415;
  _id_AED74300DAF62896.spawnfunc = ::_id_7F6818BE5068DD4E;
  _id_AED74300DAF62896._id_E68429B39C75B6EE = ::_id_7F6818BE5068DD4E;
  _id_AED74300DAF62896._id_4EA49A8926593523 = ::_id_B97F2C6555713007;
  _id_2636152C566D6C64::_id_613E13E7416BFAA5(_id_AED74300DAF62896);
}

_id_D05835744FF53415(_id_AED74300DAF62896) {
  level._id_7D967B9B6BB9F893 = getdvarint("dvar_6FED3B4AAB176FE6", 2);
  level._id_E533AB5AC1BA434B = 0;
  level._id_01AB6CF2D7F3A688 = getdvarfloat("dvar_1099EBA3FC541217", 0);
  level._id_01AB6CF2D7F3A688 = level._id_01AB6CF2D7F3A688 * level._id_01AB6CF2D7F3A688;
  level._id_5463147F04A33D36 = getdvarfloat("dvar_86E760E453E4B70B", 2500);
  level._id_A4123E1A53DEA557 = getdvarint("dvar_86C85CFC843C0B68", 1);
  level._id_D49C99AD85354BD6 = getdvarint("dvar_A433661E4F79E427", 100);
}

_id_7F6818BE5068DD4E(node, category) {
  if(!isDefined(category))
    category = "elites";

  aitype = undefined;
  _id_BDAB149BA0058E5A = level._id_13819795C6EE9FF8;

  if(category == "gulag") {
    aitype = "enemy_mp_jugg_gulag";
    _id_BDAB149BA0058E5A = ["neckguard", "backpack", "shoulderpad_l", "shoulderpad_r", "qamis", "thighpad_l", "thighpad_r"];
  } else
    aitype = _id_48814951E916AF89::_id_7F1A2E2EBE0C1693("jugg");

  _id_E21279FA90BDF012 = _id_48814951E916AF89::_id_EA94A8BF24D3C5EF(aitype, node.origin, node.angles, "absolute", category, "jugg", undefined, undefined, undefined, node._id_B205D90302DA2F07, 1, 0, 0);
  weapon = undefined;
  _id_371B4C2AB5861E62::_id_E43F4000CAC35BA2(_id_E21279FA90BDF012, weapon);
  _id_E21279FA90BDF012 _id_371B4C2AB5861E62::_id_1C3709E864D4E8D5(1);
  juggcontext = spawnStruct();
  juggcontext._id_46AD94F231CD4EF3 = [];
  juggcontext._id_46AD94F231CD4EF3["head_health"] = 100;
  juggcontext._id_46AD94F231CD4EF3["damaged_helmet_health"] = 100;
  juggcontext._id_46AD94F231CD4EF3["torso_upper_health"] = 100;
  juggcontext._id_46AD94F231CD4EF3["torso_lower_health"] = 100;
  juggcontext._id_46AD94F231CD4EF3["right_upper_arm_health"] = 100;
  juggcontext._id_46AD94F231CD4EF3["right_lower_arm_health"] = 100;
  juggcontext._id_46AD94F231CD4EF3["left_upper_arm_health"] = 100;
  juggcontext._id_46AD94F231CD4EF3["left_lower_arm_health"] = 100;
  juggcontext._id_46AD94F231CD4EF3["right_leg_health"] = 100;
  juggcontext._id_46AD94F231CD4EF3["left_leg_health"] = 100;
  juggcontext._id_5F03CAD2B199E1BC = ::_id_504B9FFB4562C0BC;
  juggcontext.lastpaintime = 0;
  juggcontext.paindamage = 0;
  juggcontext._id_1BEA7C00EB868A40 = 6000;
  juggcontext._id_3D1BBEF280EA37B4 = 20000;
  juggcontext._id_A35692B629483499 = 10;
  juggcontext._id_F8236448EB258010 = 0.1;
  juggcontext.lastdamagedtime = 0;
  juggcontext._id_A4DCEEAB66EC6A3C = 250;
  _id_E21279FA90BDF012.juggcontext = juggcontext;
  _id_E21279FA90BDF012 scripts\mp\juggernaut::_id_8E6B2DE818370BAA(_id_BDAB149BA0058E5A, "pristine");
  _id_E21279FA90BDF012._id_9329E0D3CE1D5CA8 = "mi8jugg";
  _id_E21279FA90BDF012 _id_2636152C566D6C64::_id_720C3B7ABF4BAAC8("mi8jugg");
  return _id_E21279FA90BDF012;
}

_id_B97F2C6555713007() {
  level endon("game_ended");
  _id_2636152C566D6C64::_id_C0D4FDA4400B5A08("mi8jugg");
}

_id_9188F360F73C894A(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon) {
  if(level._id_A4123E1A53DEA557 == 1) {
    _id_80A8390CD1D9716F = idamage - level._id_D49C99AD85354BD6;

    if(_id_80A8390CD1D9716F > 0)
      idamage = level._id_D49C99AD85354BD6 + sqrt(_id_80A8390CD1D9716F);
  } else
    idamage = min(idamage, level._id_D49C99AD85354BD6);

  _id_CFABC0D1AB1AB2E9 = self.health - idamage;

  if(_id_CFABC0D1AB1AB2E9 <= 0)
    self notify("mi8jugg_fatal_damage");

  scripts\mp\juggernaut::_id_4217F11FFB352425(idamage, shitloc, smeansofdeath, eattacker);
  _id_24FBEDBA9A7A1EF4::_id_DFFAC413ED66BCD0(einflictor, eattacker, int(idamage), idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon);
}

_id_504B9FFB4562C0BC(part, damage) {
  if(isDefined(part) && part == "head_health" && !isDefined(self.juggcontext._id_46AD94F231CD4EF3[part])) {
    if(isDefined(self.juggcontext._id_46AD94F231CD4EF3["damaged_helmet_health"])) {
      self.juggcontext._id_46AD94F231CD4EF3["damaged_helmet_health"] = self.juggcontext._id_46AD94F231CD4EF3["damaged_helmet_health"] - damage;

      if(self.juggcontext._id_46AD94F231CD4EF3["damaged_helmet_health"] <= 0) {
        self.juggcontext._id_46AD94F231CD4EF3["damaged_helmet_health"] = undefined;
        scripts\mp\juggernaut::_id_8E6B2DE818370BAA("head_health", "destroyed");
      }
    }
  }
}