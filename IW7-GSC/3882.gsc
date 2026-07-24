/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3882.gsc
**************************************/

main(var_0, var_1, var_2) {
  _id_0F28::_id_31C5(var_1, var_2);
  _id_0F28::_id_31A6(::init_location);
  _id_0F28::_id_3195(_id_6D18());
  _id_0F28::_id_3180(_id_4CE7());
  _id_0F28::_id_3199(_id_86D2());
  _id_0F28::_id_96F9();
}

_id_6D18() {
  var_0 = spawnStruct();
  var_0._id_6D6E = ::_id_6CF8;
  var_0._id_32B1 = 2;
  var_0._id_32B0 = 4;
  var_0._id_32B4 = 2;
  var_0._id_32B3 = 3;
  var_0._id_E31C = 5;
  var_0._id_E31B = 8;
  var_0._id_C4BA = 10;
  var_0._id_B744 = 10000;
  var_0._id_B436 = 0;
  var_0._id_10AA2 = 0;
  var_0._id_6D7E = 0.8;
  var_0._id_6D86 = ["TAG_FLASH"];
  return var_0;
}

_id_4CE7() {
  var_0 = spawnStruct();
  var_0.maxhealth = 3000;
  var_0._id_4E48 = "vfx/iw7/core/vehicle/ground_turret/vfx_ground_turret_death_lrg.vfx";
  var_0._id_4E63 = "ground_turret_med_cannon_death";
  var_0._id_4E66 = "vfx/iw7/core/vehicle/turret/vfx_ground_turret_smolder_sm.vfx";
  var_0._id_4E56 = 0.27;
  var_0._id_4E57 = 15000;
  return var_0;
}

_id_86D2() {
  var_0 = spawnStruct();
  var_0._id_BDFE = undefined;
  var_0._id_11A8B = undefined;
  var_0._id_6D80 = "ground_turret_med_cannon_fire";
  var_0._id_3D52 = "vfx/iw7/core/muzflash/cannon/vfx_un_turret_small_cheap.vfx";
  return var_0;
}

init_location() {
  self setturretteam(self.script_team);
  self makeunusable();
  self setmode("manual");
  self enableaimassist();
  self setleftarc(180);
  self setrightarc(180);
  self settoparc(90);
  self setbottomarc(15);
  self setdefaultdroppitch(0);
  self _meth_82C9(2, "yaw");
  self _meth_82C9(2, "pitch");
  self._id_C013 = 1;
}

_id_6CF8(var_0) {
  self playSound(level._id_864B[self.classname]._id_6D80);

  if(scripts\engine\utility::is_true(level._id_12FB7)) {
    var_1 = self gettagorigin(var_0);
    var_2 = self gettagangles(var_0);
    playFX(level._id_864B[self.classname]._id_3D52, var_1, anglesToForward(var_2), anglestoup(var_2));
  } else
    self shootturret();
}