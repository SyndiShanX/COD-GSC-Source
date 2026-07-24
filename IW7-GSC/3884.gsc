/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3884.gsc
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
  var_0._id_32B1 = 4;
  var_0._id_32B0 = 6;
  var_0._id_32B4 = 5;
  var_0._id_32B3 = 8;
  var_0._id_E31C = 4;
  var_0._id_E31B = 6;
  var_0._id_C4BA = 60;
  var_0._id_B744 = 1500;
  var_0._id_B436 = 25000;
  var_0._id_10AA2 = 0;
  var_0._id_6D7E = 0.5;
  var_0._id_6D86 = ["TAG_LEFT_MISSILE_1", "TAG_LEFT_MISSILE_2", "TAG_LEFT_MISSILE_3", "TAG_LEFT_MISSILE_4", "TAG_LEFT_MISSILE_5", "TAG_LEFT_MISSILE_6", "TAG_LEFT_MISSILE_7", "TAG_LEFT_MISSILE_8", "TAG_LEFT_MISSILE_9", "TAG_LEFT_MISSILE_10", "TAG_LEFT_MISSILE_11", "TAG_LEFT_MISSILE_12", "TAG_RIGHT_MISSILE_1", "TAG_RIGHT_MISSILE_2", "TAG_RIGHT_MISSILE_3", "TAG_RIGHT_MISSILE_4", "TAG_RIGHT_MISSILE_5", "TAG_RIGHT_MISSILE_6", "TAG_RIGHT_MISSILE_7", "TAG_RIGHT_MISSILE_8", "TAG_RIGHT_MISSILE_9", "TAG_RIGHT_MISSILE_10", "TAG_RIGHT_MISSILE_11", "TAG_RIGHT_MISSILE_12"];
  return var_0;
}

_id_4CE7() {
  var_0 = spawnStruct();
  var_0.maxhealth = 1000;
  var_0._id_4E48 = "vfx/iw7/core/vehicle/ground_turret/vfx_ground_turret_death_mid.vfx";
  var_0._id_4E63 = "ground_turret_small_missile_death";
  var_0._id_4E66 = "vfx/iw7/core/vehicle/turret/vfx_ground_turret_smolder_sm.vfx";
  var_0._id_4E56 = 0.22;
  var_0._id_4E57 = 15000;
  return var_0;
}

_id_86D2() {
  var_0 = spawnStruct();
  var_0._id_BDFE = "vfx/iw7/core/muzflash/cannon/vfx_muzflash_ground_turret_30mm.vfx";
  var_0._id_11A8B = "vfx/iw7/core/smktrail/vfx_smktrail_missile_small.vfx";
  var_0._id_6D80 = "ground_turret_small_missile_fire";
  return var_0;
}

init_location() {
  self setturretteam(self.script_team);
  self.health = 3000;
  self makeunusable();
  self setmode("manual");
  self enableaimassist();
  self setleftarc(180);
  self setrightarc(180);
  self settoparc(15);
  self setbottomarc(15);
  self setdefaultdroppitch(0);
  self _meth_82C9(3, "yaw");
  self _meth_82C9(3, "pitch");
  self setCanDamage(1);
  self._id_C013 = 1;
}

_id_6CF8(var_0) {
  if(!isDefined(self._id_4BC7)) {
    return;
  }
  var_1 = self gettagorigin(var_0);
  var_2 = self gettagangles(var_0);
  var_3 = scripts\engine\utility::spawn_tag_origin();
  var_3.origin = var_1;
  var_3.angles = var_2;
  var_4 = randomint(100);
  var_5 = 25;

  if(var_4 < var_5) {
    var_6 = self._id_4BC7;
  } else {
    var_7 = (randomfloatrange(-1, 1), randomfloatrange(-1, 1), randomfloatrange(-1, 1));
    var_8 = var_7 * level._id_864B[self.classname]._id_10AA2;
    var_6 = scripts\engine\utility::spawn_tag_origin();
    var_6 linkTo(self._id_4BC7, "tag_origin", var_8, (0, 0, 0));
    var_6._id_5F27 = 1;
  }

  self playSound(level._id_864B[self.classname]._id_6D80);
  playFX(level._id_864B[self.classname]._id_BDFE, var_1, anglesToForward(var_2), anglestoup(var_2));
  var_3 thread _id_0B76::_id_A332(var_6, 0, undefined, level._id_864B[self.classname]._id_11A8B, 1000, (0, 0, 0), undefined, undefined, 250);
}