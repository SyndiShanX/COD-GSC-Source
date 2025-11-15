/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3101.gsc
***************************************/

bt_registerprefabtaskids(var_00, var_01, var_02) {
  var_0.func_11591[var_01] = var_02 + 0;
  bt_registertaskargs(var_00, var_02);
  return var_02 + 7;
}

func_707F(var_00, var_01, var_02, var_03) {
  while(var_2.func_4B1B < var_2.func_C21E) {
    if(!isDefined(var_03)) {
      switch (var_2.func_4B1B) {
        case 0:
          var_04 = var_00;
          var_03 = func_0A0D::func_8C2C(var_04);

          if(var_03 == anim.running)
            var_1.func_E87F[var_04] = -1;

          break;
        case 1:
          var_04 = var_00 + 1;
          var_03 = func_0A0D::func_6CAB(var_04, scripts\aitypes\bt_util::func_0076(var_04));

          if(var_03 == anim.running)
            var_1.func_E87F[var_04] = -1;

          break;
        case 2:
          var_04 = var_00 + 2;
          var_03 = func_0A0D::func_F672(var_04, scripts\aitypes\bt_util::func_0076(var_04));

          if(var_03 == anim.running)
            var_1.func_E87F[var_04] = -1;

          break;
        case 3:
          var_04 = var_00 + 3;
          var_03 = func_0A0D::func_F72A(var_04, scripts\aitypes\bt_util::func_0076(var_04));

          if(var_03 == anim.running)
            var_1.func_E87F[var_04] = -1;

          break;
        case 4:
          var_04 = var_00 + 4;
          var_03 = func_0A0D::func_F706(var_04, scripts\aitypes\bt_util::func_0076(var_04));

          if(var_03 == anim.running)
            var_1.func_E87F[var_04] = -1;

          break;
        case 5:
          var_04 = var_00 + 5;

          if(!isDefined(var_1.func_D8BE[var_04]))
            func_0A0D::func_98E0(var_04);

          var_03 = func_0A0D::func_136C0(var_04);

          if(var_03 == anim.running)
            var_1.func_E87F[var_04] = -1;
          else
            func_0A0D::func_11704(var_04);

          break;
        case 6:
          var_04 = var_00 + 6;
          var_03 = func_0A0D::func_F7C9(var_04, scripts\aitypes\bt_util::func_0076(var_04));

          if(var_03 == anim.running)
            var_1.func_E87F[var_04] = -1;

          break;
      }
    }

    if(var_2.func_4B1B == 0)
      var_03 = scripts\aitypes\bt_util::bt_negateresult(var_03);

    if(var_03 != anim.success)
      return var_03;

    var_2.func_4B1B++;
    var_03 = undefined;
  }

  return anim.success;
}

func_710A(var_00, var_01, var_02) {
  var_03 = var_0.func_D8BE[var_01];

  if(isDefined(var_03) && var_03 != -1) {
    if(var_03 == 5)
      func_0A0D::func_11704(scripts\aitypes\bt_util::bt_getchildtaskid(var_01, var_03));
  }

  var_2.func_71D2 = undefined;
}

bt_registertaskargs(var_00, var_01) {
  var_0.func_1158E[var_01 + 1] = ::func_7171;
  var_0.func_1158E[var_01 + 2] = ::func_7172;
  var_0.func_1158E[var_01 + 3] = ::func_7173;
  var_0.func_1158E[var_01 + 4] = ::func_7174;
  var_0.func_1158E[var_01 + 6] = ::func_7172;
}

func_7171() {
  var_00 = [];
  var_0[0] = "escape";
  return var_00;
}

func_7172() {
  var_00 = [];
  var_0[0] = "face motion";
  return var_00;
}

func_7173() {
  var_00 = [];
  var_0[0] = 2048;
  return var_00;
}

func_7174() {
  var_00 = [];
  var_0[0] = "shoot_at_will";
  return var_00;
}