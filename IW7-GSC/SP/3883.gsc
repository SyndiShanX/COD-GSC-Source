/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3883.gsc
**************************************/

main(var_0, var_1, var_2) {
  _id_0F28::_id_31C5(var_1, var_2);
  _id_0F28::_id_31A6(::init_location);
  _id_0F28::_id_3195(_id_6D18());
  _id_0F28::_id_3180(_id_4CE7());
  _id_0F28::_id_3199(_id_86D2());
  _id_0F28::_id_96F9();
  precache();
}

_id_6D18() {
  var_0 = spawnStruct();
  var_0._id_6D6E = ::_id_6CF8;
  var_0._id_32B1 = 8;
  var_0._id_32B0 = 15;
  var_0._id_32B4 = 2;
  var_0._id_32B3 = 3;
  var_0._id_E31C = 4;
  var_0._id_E31B = 8;
  var_0._id_C4BA = 10;
  var_0._id_B744 = 1500;
  var_0._id_B436 = 10000;
  var_0._id_10AA2 = 300;
  var_0._id_6D7E = 0.1;
  var_0._id_6D86 = ["TAG_FLASH_1", "TAG_FLASH_2", "TAG_FLASH_3", "TAG_FLASH_4"];
  return var_0;
}

_id_4CE7() {
  var_0 = spawnStruct();
  var_0.maxhealth = 1000;
  var_0._id_4E48 = "vfx/iw7/core/vehicle/ground_turret/vfx_ground_turret_death_sml.vfx";
  var_0._id_4E63 = "ground_turret_small_cannon_death";
  var_0._id_4E66 = "vfx/iw7/core/vehicle/turret/vfx_ground_turret_smolder_sm.vfx";
  var_0._id_4E56 = 0.22;
  var_0._id_4E57 = 15000;
  return var_0;
}

_id_86D2() {
  var_0 = spawnStruct();
  var_0._id_BDFE = "vfx/iw7/core/muzflash/cannon/vfx_muzflash_ground_turret_30mm.vfx";
  var_0._id_11A8B = "vfx/iw7/core/muzflash/cannon/vfx_tracer_ground_turret_30mm.vfx";
  var_0._id_6D80 = "ground_turret_small_cannon_fire";
  var_0._id_3D52 = "vfx/iw7/core/muzflash/cannon/vfx_flack_cannon_cheap_mj.vfx";
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
  self _meth_82C9(0.5, "yaw");
  self _meth_82C9(0.5, "pitch");
  self._id_102A7 = 0.5;
}

precache() {
  precacheitem("magic_ground_turret_30mm_projectile");
}

_id_6CF8(var_0) {
  var_1 = self gettagorigin(var_0);
  var_2 = self gettagangles(var_0);
  var_3 = level._id_864B[self.classname]._id_10AA2;
  var_3 = (_id_0F28::_id_7C9C(var_3), _id_0F28::_id_7C9C(var_3), _id_0F28::_id_7C9C(var_3));
  var_4 = var_1 + anglesToForward(var_2) * level._id_864B[self.classname]._id_B436 + var_3;
  self playSound(level._id_864B[self.classname]._id_6D80);

  if(scripts\engine\utility::is_true(level._id_12FB7)) {
    playFX(level._id_864B[self.classname]._id_3D52, var_1, anglesToForward(var_2), anglestoup(var_2));
  } else {
    playFX(level._id_864B[self.classname]._id_BDFE, var_1, anglesToForward(var_2), anglestoup(var_2));
    var_5 = magicbullet("magic_ground_turret_30mm_projectile", var_1, var_4);
    playFXOnTag(level._id_864B[self.classname]._id_11A8B, var_5, "tag_fx");
  }
}