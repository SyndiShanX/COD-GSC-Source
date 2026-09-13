/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_1cbf6b45e1087a51.gsc
***********************************************/

init() {
  if(getdvarint("dvar_792ED761E80E01B9", 0) == 0) {
    return;
  }
  _id_7EC7671A1E0C788F = spawnStruct();
  _id_7EC7671A1E0C788F.weight = getdvarfloat("dvar_792ED761E80E01B9", 1);
  _id_7EC7671A1E0C788F.activatefunc = ::activatefunc;
  _id_7EC7671A1E0C788F.validatefunc = ::validatefunc;
  _id_7EC7671A1E0C788F.waitfunc = ::waitfunc;
  _id_7EC7671A1E0C788F._id_C9E871D29702E8CF = ::_id_C9E871D29702E8CF;
  _id_7EC7671A1E0C788F._id_D72A1842C5B57D1D = getdvarint("dvar_5F511D9EBE0BA000", 1);
  _id_337BD370F7C5E6F9::registerpublicevent(17, _id_7EC7671A1E0C788F);
  level._id_3592F67E3F4A6517 = 1;
  level._id_7DBC2BB968D412AE = 5000;
  level._id_428703950599C9E9 = ::_id_428703950599C9E9;
  _id_48814951E916AF89::_id_C8393014DD7F8AB6();
  _id_48814951E916AF89::init();
  jugg_init();
}

_id_428703950599C9E9() {
  _id_48814951E916AF89::_id_B1D1E7E3B23E0DFE(["elites"]);
}

jugg_init() {
  level._id_7D967B9B6BB9F893 = getdvarint("dvar_44F5A24F308CFC24", 2);
  level._id_E533AB5AC1BA434B = 0;
  level._id_01AB6CF2D7F3A688 = getdvarfloat("dvar_4CA0FB9B9E03EE41", 0);
  level._id_5463147F04A33D36 = getdvarfloat("dvar_630260E41CBFDC4D", 2500);
  level._id_A4123E1A53DEA557 = getdvarint("dvar_B46AB23F0795BDDA", 1);
  level._id_D49C99AD85354BD6 = getdvarint("dvar_BBD7E58197FF9761", 100);
}

_id_C9E871D29702E8CF() {}

validatefunc() {
  return 1;
}

waitfunc() {
  level endon("game_ended");
  level endon("cancel_public_event");
  _id_98489428013A0100 = calculateeventstarttime();
  wait(_id_98489428013A0100);
}

activatefunc() {
  _id_76A22C18960F72AF = _id_29C32B7117E01180::showdroplocations(1, 0);
  scripts\mp\hud_util::showsplashtoall("br_champion_jugg_incoming");
  node = spawnStruct();
  node.origin = _id_76A22C18960F72AF[0].origin;
  node.angle = (0, 0, 0);
  _id_E21279FA90BDF012 = _id_455B9A1039522C32("enemy_mp_jugg_mgl", node);
  _id_E21279FA90BDF012 thread _id_120270BD0A747A35::_id_9BBF1713A14FA580(_id_E21279FA90BDF012, 1024, 512);
}

calculateeventstarttime() {
  _id_87940078241E4580 = getdvarfloat("dvar_DC49C56A963EC655", 60);
  _id_07AF9598177DC2DE = getdvarfloat("dvar_DC6CAF6A9664DDAB", 120);

  if(_id_07AF9598177DC2DE > _id_87940078241E4580)
    return randomfloatrange(_id_87940078241E4580, _id_07AF9598177DC2DE);
  else
    return _id_87940078241E4580;
}

_id_455B9A1039522C32(aitype, node) {
  _id_E21279FA90BDF012 = _id_48814951E916AF89::_id_EA94A8BF24D3C5EF(aitype, node.origin, node.angles, "absolute", "elites", "jugg", undefined, undefined, undefined, node._id_B205D90302DA2F07, 1, 0, 0);
  _id_371B4C2AB5861E62::_id_E43F4000CAC35BA2(_id_E21279FA90BDF012);
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
  juggcontext._id_5F03CAD2B199E1BC = ::_id_8F679CA5AB48AE1A;
  juggcontext.lastpaintime = 0;
  juggcontext.paindamage = 0;
  juggcontext._id_1BEA7C00EB868A40 = 6000;
  juggcontext._id_3D1BBEF280EA37B4 = 20000;
  juggcontext._id_A35692B629483499 = 10;
  juggcontext._id_F8236448EB258010 = 0.1;
  juggcontext.lastdamagedtime = 0;
  juggcontext._id_A4DCEEAB66EC6A3C = 250;
  _id_E21279FA90BDF012.juggcontext = juggcontext;
  _id_E21279FA90BDF012 scripts\mp\juggernaut::_id_8E6B2DE818370BAA(level._id_13819795C6EE9FF8, "pristine");
  return _id_E21279FA90BDF012;
}

_id_8F679CA5AB48AE1A(part, damage) {
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