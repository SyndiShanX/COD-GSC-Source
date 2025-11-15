/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: behaviortree\jackal.gsc
***************************************/

func_A3C3(var_00) {
  return func_0A0D::func_F711(var_00, "fly");
}

func_A3C4(var_00) {
  return func_0A0D::func_F711(var_00, "hover");
}

func_A3C5(var_00) {
  return func_0A0D::func_F706(var_00, "shoot_at_will");
}

func_A3C6(var_00) {
  return func_0A0D::func_F7C9(var_00, "face enemy");
}

func_A3C7(var_00) {
  return func_0A0D::func_6CAB(var_00, "spline");
}

func_A3C8(var_00) {
  return func_0A0D::func_F85B(var_00, "escape");
}

func_A3C9(var_00) {
  return func_0A0D::func_E7B8(var_00, 1.3);
}

func_A3CA(var_00) {
  return func_0A0D::func_6CAB(var_00, "escape");
}

func_A3CB(var_00) {
  return func_0A0D::func_F72A(var_00, 2048);
}

func_A3CC(var_00) {
  return func_0A0D::func_F7C9(var_00, "face motion");
}

func_A3CD(var_00) {
  return func_0A0D::func_6CAB(var_00, "attack");
}

func_A3CE(var_00) {
  return func_0A0D::func_F672(var_00, "face motion");
}

func_A3CF(var_00) {
  return func_0A0D::func_F85B(var_00, "combat");
}

func_A3D0(var_00) {
  return func_0A0D::func_F85B(var_00, "patrol");
}

func_A3D1(var_00) {
  return func_0A0D::func_E7B8(var_00, 0.7);
}

func_2AD0() {
  if(isDefined(level.func_119E["jackal"])) {
    return;
  }
  var_00 = spawnStruct();
  var_0.func_1581 = [];
  var_0.func_1581[0] = func_0A0D::func_9D44;
  var_0.func_1581[1] = func_0A0D::func_593B;
  var_0.func_1581[2] = func_0A0D::func_41E4;
  var_0.func_1581[3] = func_0A0D::func_10015;
  var_0.func_1581[4] = func_0A0D::func_9E76;
  var_0.func_1581[5] = func_0A0D::func_9E00;
  var_0.func_1581[6] = func_0A0D::func_61C4;
  var_0.func_1581[7] = func_0A0D::func_10016;
  var_0.func_1581[8] = ::func_A3C3;
  var_0.func_1581[9] = func_0A0D::func_7232;
  var_0.func_1581[10] = func_0A0D::func_7234;
  var_0.func_1581[11] = func_0A0D::func_9E77;
  var_0.func_1581[12] = ::func_A3C4;
  var_0.func_1581[13] = func_0A0D::follow;
  var_0.func_1581[14] = func_0A0D::func_7221;
  var_0.func_1581[15] = func_0A0D::func_7231;
  var_0.func_1581[16] = func_0A0D::func_10027;
  var_0.func_1581[17] = func_0A0D::func_10028;
  var_0.func_1581[18] = func_0A0D::func_10075;
  var_0.func_1581[19] = func_0A0D::func_F748;
  var_0.func_1581[20] = func_0A0D::func_136C0;
  var_0.func_1581[21] = func_0A0D::func_98E0;
  var_0.func_1581[22] = func_0A0D::func_11704;
  var_0.func_1581[23] = func_0A0D::func_41B6;
  var_0.func_1581[24] = ::func_A3C5;
  var_0.func_1581[25] = ::func_A3C6;
  var_0.func_1581[26] = func_0A0D::func_1002B;
  var_0.func_1581[27] = func_0A0D::func_90F2;
  var_0.func_1581[28] = func_0A09::func_E475;
  var_0.func_1581[29] = func_0A0D::func_1003F;
  var_0.func_1581[30] = func_0A0D::func_9DE3;
  var_0.func_1581[31] = func_0A0D::func_8C2C;
  var_0.func_1581[32] = func_0A0D::func_10017;
  var_0.func_1581[33] = func_0A0D::func_B4DB;
  var_0.func_1581[34] = func_0A0D::func_7248;
  var_0.func_1581[35] = func_0A0D::func_724A;
  var_0.func_1581[36] = func_0A0D::func_724B;
  var_0.func_1581[37] = ::func_A3C7;
  var_0.func_1581[38] = func_0A0D::func_1000C;
  var_0.func_1581[39] = ::func_A3C8;
  var_0.func_1581[40] = func_0A0D::func_F6EC;
  var_0.func_1581[41] = func_0A0D::validatehighpriorityflag;
  var_0.func_1581[42] = ::func_A3C9;
  var_0.func_1581[43] = func_0A0D::func_1289A;
  var_0.func_1581[44] = ::func_A3CA;
  var_0.func_1581[45] = ::func_A3CB;
  var_0.func_1581[46] = ::func_A3CC;
  var_0.func_1581[47] = func_0A0D::func_8C3A;
  var_0.func_1581[48] = func_0A0D::func_FFBE;
  var_0.func_1581[49] = func_0A0D::func_FFD6;
  var_0.func_1581[50] = func_0A0D::func_10E66;
  var_0.func_1581[51] = ::func_A3CD;
  var_0.func_1581[52] = ::func_A3CE;
  var_0.func_1581[53] = func_0A0D::func_98DF;
  var_0.func_1581[54] = func_0A0D::func_11703;
  var_0.func_1581[55] = func_0A0D::func_1003E;
  var_0.func_1581[56] = func_0A0D::func_C936;
  var_0.func_1581[57] = func_0A0D::func_1006C;
  var_0.func_1581[58] = ::func_A3CF;
  var_0.func_1581[59] = ::func_A3D0;
  var_0.func_1581[60] = func_0A0D::func_FFD8;
  var_0.func_1581[61] = ::func_A3D1;
  level.func_119E["jackal"] = var_00;
}

func_DEE8() {
  func_2AD0();
  _btregistertree("jackal");
}