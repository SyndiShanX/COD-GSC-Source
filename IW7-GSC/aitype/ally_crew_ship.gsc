/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\ally_crew_ship.gsc
**************************************/

main() {
  self._id_17DB = "";
  self.team = "allies";
  self.type = "human";
  self.unittype = "soldier";
  self.subclass = "crew";
  self.accuracy = 0.2;
  self.health = 150;
  self.grenadeweapon = "";
  self.grenadeammo = 0;
  self.secondaryweapon = "";
  self._id_101B4 = "";
  self.behaviortreeasset = "enemy_combatant";
  self._id_1FA9 = "soldier";

  if(isai(self)) {
    self _meth_82DC(256.0, 0.0);
    self _meth_82DB(768.0, 1024.0);
  }

  self.weapon = "none";
  var_0 = [0.014, 0.017, 0.021, 0.024, 0.027, 0.034, 0.041, 0.048, 0.055, 0.062, 0.068, 0.075, 0.082, 0.089, 0.096, 0.11, 0.113, 0.116, 0.12, 0.123, 0.13, 0.137, 0.144, 0.151, 0.158, 0.164, 0.171, 0.178, 0.185, 0.192, 0.199, 0.205, 0.212, 0.219, 0.226, 0.233, 0.24, 0.247, 0.253, 0.26, 0.267, 0.274, 0.288, 0.295, 0.301, 0.315, 0.329, 0.342, 0.349, 0.356, 0.36, 0.363, 0.366, 0.37, 0.377, 0.384, 0.39, 0.397, 0.411, 0.418, 0.425, 0.432, 0.438, 0.445, 0.452, 0.459, 0.466, 0.473, 0.479, 0.493, 0.5, 0.507, 0.514, 0.521, 0.534, 0.541, 0.548, 0.555, 0.562, 0.568, 0.575, 0.582, 0.589, 0.596, 0.603, 0.616, 0.623, 0.63, 0.637, 0.644, 0.651, 0.658, 0.664, 0.671, 0.678, 0.685, 0.699, 0.712, 0.726, 0.74, 0.753, 0.767, 0.781, 0.795, 0.808, 0.822, 0.836, 0.849, 0.863, 0.877, 0.89, 0.904, 0.918, 0.932, 0.945, 0.959, 0.973, 0.986, 1.0];
  var_1 = ["character_un_crew_ship_male_bc_01_male_bc_03", "character_un_crew_ship_male_bc_01_male_bc_04", "character_un_crew_ship_male_bc_01_male_bc_04_cap", "character_un_crew_ship_male_bc_01_male_bc_04_beard", "character_un_crew_ship_male_bc_01_male_bc_04_beard_cap", "character_un_crew_ship_male_bc_01_male_bc_05", "character_un_crew_ship_male_bc_01_male_bc_05_cap", "character_un_crew_ship_male_bc_01_engineering_mate", "character_un_crew_ship_male_bc_01_engineering_mate_cap", "character_un_crew_ship_male_bc_01_male_15", "character_un_crew_ship_male_bc_01_male_15_cap", "character_un_crew_ship_male_bc_01_male_20", "character_un_crew_ship_male_bc_01_male_20_cap", "character_un_crew_ship_male_bc_02_male_bc_01", "character_un_crew_ship_male_bc_02_male_bc_01_cap", "character_un_crew_ship_male_bc_02_male_bc_03", "character_un_crew_ship_male_bc_02_male_bc_04", "character_un_crew_ship_male_bc_02_male_bc_04_cap", "character_un_crew_ship_male_bc_02_male_bc_04_beard", "character_un_crew_ship_male_bc_02_male_bc_04_beard_cap", "character_un_crew_ship_male_bc_02_male_bc_05", "character_un_crew_ship_male_bc_02_male_bc_05_cap", "character_un_crew_ship_male_bc_02_engineering_mate", "character_un_crew_ship_male_bc_02_engineering_mate_cap", "character_un_crew_ship_male_bc_02_male_20", "character_un_crew_ship_male_bc_02_male_20_cap", "character_un_crew_ship_male_bc_03_male_bc_01", "character_un_crew_ship_male_bc_03_male_bc_01_cap", "character_un_crew_ship_male_bc_03_male_bc_04_beard", "character_un_crew_ship_male_bc_03_male_bc_04_beard_cap", "character_un_crew_ship_male_bc_03_male_bc_05", "character_un_crew_ship_male_bc_03_male_bc_05_cap", "character_un_crew_ship_male_bc_03_engineering_mate", "character_un_crew_ship_male_bc_03_engineering_mate_cap", "character_un_crew_ship_male_bc_04_male_bc_01", "character_un_crew_ship_male_bc_04_male_bc_01_cap", "character_un_crew_ship_male_bc_04_male_bc_05", "character_un_crew_ship_male_bc_04_male_bc_05_cap", "character_un_crew_ship_male_bc_04_engineering_mate", "character_un_crew_ship_male_bc_04_engineering_mate_cap", "character_un_crew_ship_male_bc_05_male_bc_01", "character_un_crew_ship_male_bc_05_male_bc_01_cap", "character_un_crew_ship_male_bc_05_male_bc_03", "character_un_crew_ship_male_bc_05_engineering_mate", "character_un_crew_ship_male_bc_05_engineering_mate_cap", "character_un_crew_ship_male_bc_05_male_12", "character_un_crew_ship_male_bc_05_male_15", "character_un_crew_ship_male_bc_05_male_20", "character_un_crew_ship_engineering_mate_male_bc_01", "character_un_crew_ship_engineering_mate_male_bc_01_cap", "character_un_crew_ship_engineering_mate_male_bc_04", "character_un_crew_ship_engineering_mate_male_bc_04_cap", "character_un_crew_ship_engineering_mate_male_bc_04_beard", "character_un_crew_ship_engineering_mate_male_bc_04_beard_cap", "character_un_crew_ship_engineering_mate_male_bc_05", "character_un_crew_ship_engineering_mate_male_bc_05_cap", "character_un_crew_ship_engineering_mate", "character_un_crew_ship_engineering_mate_cap", "character_un_crew_ship_engineering_mate_male_12", "character_un_crew_ship_engineering_mate_male_15", "character_un_crew_ship_engineering_mate_male_15_cap", "character_un_crew_ship_engineering_mate_male_20", "character_un_crew_ship_engineering_mate_male_20_cap", "character_un_crew_ship_male_12_male_bc_01", "character_un_crew_ship_male_12_male_bc_01_cap", "character_un_crew_ship_male_12_male_bc_05", "character_un_crew_ship_male_12_male_bc_05_cap", "character_un_crew_ship_male_12_engineering_mate", "character_un_crew_ship_male_12_engineering_mate_cap", "character_un_crew_ship_male_12", "character_un_crew_ship_male_12_male_15", "character_un_crew_ship_male_12_male_15_cap", "character_un_crew_ship_male_12_male_20", "character_un_crew_ship_male_12_male_20_cap", "character_un_crew_ship_male_18_male_bc_03", "character_un_crew_ship_male_18_male_bc_05", "character_un_crew_ship_male_18_male_bc_05_cap", "character_un_crew_ship_male_18_engineering_mate", "character_un_crew_ship_male_18_engineering_mate_cap", "character_un_crew_ship_male_18_male_15", "character_un_crew_ship_male_18_male_15_cap", "character_un_crew_ship_male_18_male_20", "character_un_crew_ship_male_18_male_20_cap", "character_un_crew_ship_male_15_male_bc_01", "character_un_crew_ship_male_15_male_bc_01_cap", "character_un_crew_ship_male_15_male_bc_03", "character_un_crew_ship_male_15_male_bc_04_beard", "character_un_crew_ship_male_15_male_bc_04_beard_cap", "character_un_crew_ship_male_15_male_bc_05", "character_un_crew_ship_male_15_male_bc_05_cap", "character_un_crew_ship_male_20_male_bc_01", "character_un_crew_ship_male_20_male_bc_01_cap", "character_un_crew_ship_male_20_male_15", "character_un_crew_ship_male_20_male_15_cap", "character_un_crew_ship_male_20", "character_un_crew_ship_male_20_cap", "character_un_crew_ship_female_bc_02_hero_xo_cap", "character_un_crew_ship_female_bc_02_comms_officer_cap", "character_un_crew_ship_female_bc_02_female_14_cap", "character_un_crew_ship_female_bc_02_female_05_cap", "character_un_crew_ship_comms_officer_female_bc_02", "character_un_crew_ship_comms_officer_female_04", "character_un_crew_ship_comms_officer_female_05", "character_un_crew_ship_comms_officer_female_11", "character_un_crew_ship_female_14_hero_xo", "character_un_crew_ship_female_14", "character_un_crew_ship_female_14_female_04", "character_un_crew_ship_female_14_female_05", "character_un_crew_ship_female_14_female_11", "character_un_crew_ship_female_04_comms_officer", "character_un_crew_ship_female_04_female_14", "character_un_crew_ship_female_04", "character_un_crew_ship_female_04_female_05", "character_un_crew_ship_female_05_female_bc_02", "character_un_crew_ship_female_05_comms_officer", "character_un_crew_ship_female_05_female_marine", "character_un_crew_ship_female_05", "character_un_crew_ship_female_05_female_11", "character_un_crew_ship_female_11"];

  switch (scripts\code\character::get_random_character(119, var_0, var_1)) {
    case 0:
      _id_0799::main();
      break;
    case 1:
      _id_079A::main();
      break;
    case 2:
      _id_079D::main();
      break;
    case 3:
      _id_079B::main();
      break;
    case 4:
      _id_079C::main();
      break;
    case 5:
      _id_079E::main();
      break;
    case 6:
      _id_079F::main();
      break;
    case 7:
      _id_0793::main();
      break;
    case 8:
      _id_0794::main();
      break;
    case 9:
      _id_0795::main();
      break;
    case 10:
      _id_0796::main();
      break;
    case 11:
      _id_0797::main();
      break;
    case 12:
      _id_0798::main();
      break;
    case 13:
      _id_07A4::main();
      break;
    case 14:
      _id_07A5::main();
      break;
    case 15:
      _id_07A6::main();
      break;
    case 16:
      _id_07A7::main();
      break;
    case 17:
      _id_07AA::main();
      break;
    case 18:
      _id_07A8::main();
      break;
    case 19:
      _id_07A9::main();
      break;
    case 20:
      _id_07AB::main();
      break;
    case 21:
      _id_07AC::main();
      break;
    case 22:
      _id_07A0::main();
      break;
    case 23:
      _id_07A1::main();
      break;
    case 24:
      _id_07A2::main();
      break;
    case 25:
      _id_07A3::main();
      break;
    case 26:
      _id_07AF::main();
      break;
    case 27:
      _id_07B0::main();
      break;
    case 28:
      _id_07B1::main();
      break;
    case 29:
      _id_07B2::main();
      break;
    case 30:
      _id_07B3::main();
      break;
    case 31:
      _id_07B4::main();
      break;
    case 32:
      _id_07AD::main();
      break;
    case 33:
      _id_07AE::main();
      break;
    case 34:
      _id_07B7::main();
      break;
    case 35:
      _id_07B8::main();
      break;
    case 36:
      _id_07B9::main();
      break;
    case 37:
      _id_07BA::main();
      break;
    case 38:
      _id_07B5::main();
      break;
    case 39:
      _id_07B6::main();
      break;
    case 40:
      _id_07C0::main();
      break;
    case 41:
      _id_07C1::main();
      break;
    case 42:
      _id_07C2::main();
      break;
    case 43:
      _id_07BB::main();
      break;
    case 44:
      _id_07BC::main();
      break;
    case 45:
      _id_07BD::main();
      break;
    case 46:
      _id_07BE::main();
      break;
    case 47:
      _id_07BF::main();
      break;
    case 48:
      _id_0717::main();
      break;
    case 49:
      _id_0718::main();
      break;
    case 50:
      _id_0719::main();
      break;
    case 51:
      _id_071C::main();
      break;
    case 52:
      _id_071A::main();
      break;
    case 53:
      _id_071B::main();
      break;
    case 54:
      _id_071D::main();
      break;
    case 55:
      _id_071E::main();
      break;
    case 56:
      _id_0710::main();
      break;
    case 57:
      _id_0711::main();
      break;
    case 58:
      _id_0712::main();
      break;
    case 59:
      _id_0713::main();
      break;
    case 60:
      _id_0714::main();
      break;
    case 61:
      _id_0715::main();
      break;
    case 62:
      _id_0716::main();
      break;
    case 63:
      _id_0779::main();
      break;
    case 64:
      _id_077A::main();
      break;
    case 65:
      _id_077B::main();
      break;
    case 66:
      _id_077C::main();
      break;
    case 67:
      _id_0773::main();
      break;
    case 68:
      _id_0774::main();
      break;
    case 69:
      _id_0772::main();
      break;
    case 70:
      _id_0775::main();
      break;
    case 71:
      _id_0776::main();
      break;
    case 72:
      _id_0777::main();
      break;
    case 73:
      _id_0778::main();
      break;
    case 74:
      _id_078A::main();
      break;
    case 75:
      _id_078B::main();
      break;
    case 76:
      _id_078C::main();
      break;
    case 77:
      _id_0784::main();
      break;
    case 78:
      _id_0785::main();
      break;
    case 79:
      _id_0786::main();
      break;
    case 80:
      _id_0787::main();
      break;
    case 81:
      _id_0788::main();
      break;
    case 82:
      _id_0789::main();
      break;
    case 83:
      _id_077D::main();
      break;
    case 84:
      _id_077E::main();
      break;
    case 85:
      _id_077F::main();
      break;
    case 86:
      _id_0780::main();
      break;
    case 87:
      _id_0781::main();
      break;
    case 88:
      _id_0782::main();
      break;
    case 89:
      _id_0783::main();
      break;
    case 90:
      _id_0791::main();
      break;
    case 91:
      _id_0792::main();
      break;
    case 92:
      _id_078F::main();
      break;
    case 93:
      _id_0790::main();
      break;
    case 94:
      _id_078D::main();
      break;
    case 95:
      _id_078E::main();
      break;
    case 96:
      _id_0732::main();
      break;
    case 97:
      _id_072F::main();
      break;
    case 98:
      _id_0731::main();
      break;
    case 99:
      _id_0730::main();
      break;
    case 100:
      _id_070D::main();
      break;
    case 101:
      _id_070A::main();
      break;
    case 102:
      _id_070B::main();
      break;
    case 103:
      _id_070C::main();
      break;
    case 104:
      _id_072E::main();
      break;
    case 105:
      _id_072A::main();
      break;
    case 106:
      _id_072B::main();
      break;
    case 107:
      _id_072C::main();
      break;
    case 108:
      _id_072D::main();
      break;
    case 109:
      _id_0721::main();
      break;
    case 110:
      _id_0723::main();
      break;
    case 111:
      _id_0720::main();
      break;
    case 112:
      _id_0722::main();
      break;
    case 113:
      _id_0727::main();
      break;
    case 114:
      _id_0725::main();
      break;
    case 115:
      _id_0728::main();
      break;
    case 116:
      _id_0724::main();
      break;
    case 117:
      _id_0726::main();
      break;
    case 118:
      _id_0729::main();
      break;
  }
}

spawner() {
  self setspawnerteam("allies");
}

precache() {
  _id_0799::precache();
  _id_079A::precache();
  _id_079D::precache();
  _id_079B::precache();
  _id_079C::precache();
  _id_079E::precache();
  _id_079F::precache();
  _id_0793::precache();
  _id_0794::precache();
  _id_0795::precache();
  _id_0796::precache();
  _id_0797::precache();
  _id_0798::precache();
  _id_07A4::precache();
  _id_07A5::precache();
  _id_07A6::precache();
  _id_07A7::precache();
  _id_07AA::precache();
  _id_07A8::precache();
  _id_07A9::precache();
  _id_07AB::precache();
  _id_07AC::precache();
  _id_07A0::precache();
  _id_07A1::precache();
  _id_07A2::precache();
  _id_07A3::precache();
  _id_07AF::precache();
  _id_07B0::precache();
  _id_07B1::precache();
  _id_07B2::precache();
  _id_07B3::precache();
  _id_07B4::precache();
  _id_07AD::precache();
  _id_07AE::precache();
  _id_07B7::precache();
  _id_07B8::precache();
  _id_07B9::precache();
  _id_07BA::precache();
  _id_07B5::precache();
  _id_07B6::precache();
  _id_07C0::precache();
  _id_07C1::precache();
  _id_07C2::precache();
  _id_07BB::precache();
  _id_07BC::precache();
  _id_07BD::precache();
  _id_07BE::precache();
  _id_07BF::precache();
  _id_0717::precache();
  _id_0718::precache();
  _id_0719::precache();
  _id_071C::precache();
  _id_071A::precache();
  _id_071B::precache();
  _id_071D::precache();
  _id_071E::precache();
  _id_0710::precache();
  _id_0711::precache();
  _id_0712::precache();
  _id_0713::precache();
  _id_0714::precache();
  _id_0715::precache();
  _id_0716::precache();
  _id_0779::precache();
  _id_077A::precache();
  _id_077B::precache();
  _id_077C::precache();
  _id_0773::precache();
  _id_0774::precache();
  _id_0772::precache();
  _id_0775::precache();
  _id_0776::precache();
  _id_0777::precache();
  _id_0778::precache();
  _id_078A::precache();
  _id_078B::precache();
  _id_078C::precache();
  _id_0784::precache();
  _id_0785::precache();
  _id_0786::precache();
  _id_0787::precache();
  _id_0788::precache();
  _id_0789::precache();
  _id_077D::precache();
  _id_077E::precache();
  _id_077F::precache();
  _id_0780::precache();
  _id_0781::precache();
  _id_0782::precache();
  _id_0783::precache();
  _id_0791::precache();
  _id_0792::precache();
  _id_078F::precache();
  _id_0790::precache();
  _id_078D::precache();
  _id_078E::precache();
  _id_0732::precache();
  _id_072F::precache();
  _id_0731::precache();
  _id_0730::precache();
  _id_070D::precache();
  _id_070A::precache();
  _id_070B::precache();
  _id_070C::precache();
  _id_072E::precache();
  _id_072A::precache();
  _id_072B::precache();
  _id_072C::precache();
  _id_072D::precache();
  _id_0721::precache();
  _id_0723::precache();
  _id_0720::precache();
  _id_0722::precache();
  _id_0727::precache();
  _id_0725::precache();
  _id_0728::precache();
  _id_0724::precache();
  _id_0726::precache();
  _id_0729::precache();
  scripts\aitypes\bt_util::init();
  _id_09FD::soldier();
  _id_03AE::_id_DEE8();
  _id_0C69::_id_2371();
}