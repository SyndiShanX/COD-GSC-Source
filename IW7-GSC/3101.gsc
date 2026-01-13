/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3101.gsc
***************************************/

bt_registerprefabtaskids(var_0, var_1, var_2) {
  var_0.var_11591[var_1] = var_2 + 0;
  bt_registertaskargs(var_0, var_2);
  return var_2 + 7;
}

func_707F(var_0, var_1, var_2, var_3) {
  while(var_2.var_4B1B < var_2.var_C21E) {
    if(!isDefined(var_3)) {
      switch (var_2.var_4B1B) {
        case 0:
          var_4 = var_0;
          var_3 = func_0A0D::func_8C2C(var_4);

          if(var_3 == anim.running) {
            var_1.var_E87F[var_4] = -1;
          }

          break;
        case 1:
          var_4 = var_0 + 1;
          var_3 = func_0A0D::func_6CAB(var_4, scripts\aitypes\bt_util::func_0076(var_4));

          if(var_3 == anim.running) {
            var_1.var_E87F[var_4] = -1;
          }

          break;
        case 2:
          var_4 = var_0 + 2;
          var_3 = func_0A0D::func_F672(var_4, scripts\aitypes\bt_util::func_0076(var_4));

          if(var_3 == anim.running) {
            var_1.var_E87F[var_4] = -1;
          }

          break;
        case 3:
          var_4 = var_0 + 3;
          var_3 = func_0A0D::func_F72A(var_4, scripts\aitypes\bt_util::func_0076(var_4));

          if(var_3 == anim.running) {
            var_1.var_E87F[var_4] = -1;
          }

          break;
        case 4:
          var_4 = var_0 + 4;
          var_3 = func_0A0D::func_F706(var_4, scripts\aitypes\bt_util::func_0076(var_4));

          if(var_3 == anim.running) {
            var_1.var_E87F[var_4] = -1;
          }

          break;
        case 5:
          var_4 = var_0 + 5;

          if(!isDefined(var_1.var_D8BE[var_4])) {
            func_0A0D::func_98E0(var_4);
          }

          var_3 = func_0A0D::func_136C0(var_4);

          if(var_3 == anim.running) {
            var_1.var_E87F[var_4] = -1;
          } else {
            func_0A0D::func_11704(var_4);
          }

          break;
        case 6:
          var_4 = var_0 + 6;
          var_3 = func_0A0D::func_F7C9(var_4, scripts\aitypes\bt_util::func_0076(var_4));

          if(var_3 == anim.running) {
            var_1.var_E87F[var_4] = -1;
          }

          break;
      }
    }

    if(var_2.var_4B1B == 0) {
      var_3 = scripts\aitypes\bt_util::bt_negateresult(var_3);
    }

    if(var_3 != anim.success) {
      return var_3;
    }

    var_2.var_4B1B++;
    var_3 = undefined;
  }

  return anim.success;
}

func_710A(var_0, var_1, var_2) {
  var_3 = var_0.var_D8BE[var_1];

  if(isDefined(var_3) && var_3 != -1) {
    if(var_3 == 5) {
      func_0A0D::func_11704(scripts\aitypes\bt_util::bt_getchildtaskid(var_1, var_3));
    }
  }

  var_2.var_71D2 = undefined;
}

bt_registertaskargs(var_0, var_1) {
  var_0.var_1158E[var_1 + 1] = ::func_7171;
  var_0.var_1158E[var_1 + 2] = ::func_7172;
  var_0.var_1158E[var_1 + 3] = ::func_7173;
  var_0.var_1158E[var_1 + 4] = ::func_7174;
  var_0.var_1158E[var_1 + 6] = ::func_7172;
}

func_7171() {
  var_0 = [];
  var_0[0] = "escape";
  return var_0;
}

func_7172() {
  var_0 = [];
  var_0[0] = "face motion";
  return var_0;
}

func_7173() {
  var_0 = [];
  var_0[0] = 2048;
  return var_0;
}

func_7174() {
  var_0 = [];
  var_0[0] = "shoot_at_will";
  return var_0;
}