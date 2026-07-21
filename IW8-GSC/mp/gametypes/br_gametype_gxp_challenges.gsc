/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\br_gametype_gxp_challenges.gsc
*******************************************************/

_id_11FEF(var_0) {
  _id_12C3A(var_0, "_encstr_84C12BDD61016BF2595EF0397938DB2F1321C2F7EF6E1973793388C9C52555E5B9AFFEEB5F65E35170647509E4");
}

_id_11FF1(var_0) {
  var_1 = var_0.victim;
  var_2 = var_0.attacker;

  if(!isDefined(var_1) || !isDefined(var_2)) {
    return;
  }
  if(!isPlayer(var_2)) {
    return;
  }
  if(var_1.team == var_2.team) {
    return;
  }
  var_3 = var_1 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_125EC();
  var_4 = var_2 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_125EC();

  if(!var_4 && !var_3)
    _id_12C3A(var_2, "_encstr_85C12BDBC72FFE089123E7EB45C560A837BAF1A34A133832B92FB597756BF0887371094832B3E9900D17839FCC");
  else if(!var_4 && var_3)
    _id_12C3A(var_2, "_encstr_ADC12B141399BECBC0198A5220201B792003B99B2778C9EAE8B3D37909844F6DB08F331853D0CD6F28A93A61DB");
  else if(var_4 && !var_3)
    _id_12C3A(var_2, "_encstr_8AC12BAB6877301BC1B79F93E7AA5089F3D7B1C365BE19ECF9FFCDEFFFE32DC8AC2179380E14F80D0297FBE756");
}

_id_11FF0(var_0, var_1) {
  var_2 = level.disable_super_in_turret.setsuperisinuse[0]._id_13DB4;
  var_3 = var_0 _encstr_AC0D253F1BCB213B094F2208F01837D7FD19A3FB8377AAF0DA25FFEC53E8594728B82BB55486EA::remove_flag_trig();

  if(var_3 < var_2) {
    return;
  }
  _id_12C3A(var_0, "_encstr_BEC12B4071B96EE85FE26A5DB8F7DDA7126926BB1095DFDFA8135BE95D3553A05997373BEF5BB9EF5632705F69");
}

_id_11FEE(var_0, var_1) {
  if(!isDefined(var_1.id)) {
    return;
  }
  if(!isDefined(var_0._id_12E77))
    var_0._id_12E77 = [];

  foreach(var_3 in var_0._id_12E77) {
    if(var_3 == var_1.id)
      return;
  }

  var_0._id_12E77[var_0._id_12E77.size] = var_1.id;
  _id_12C3A(var_0, "_encstr_B2C12B70368FA1193166B719FD6A4D6E0BFF50D08746FE6D190B8208D71393F0547FF88027ECD0F3F2377530BB");
}

_id_11FD2(var_0) {
  _id_12C3A(var_0, "_encstr_8EC12B43E320BAE07911AD35C8203EB18EE39FC727D021F6517BE0B1E1807D1AE57F2F23A309DA9DA041DF8932");
}

_id_12C3A(var_0, var_1) {
  if(!isDefined(level.getallactivequestsforteam) || level.getallactivequestsforteam < 12) {
    return;
  }
  if(!var_0 scripts\cp\vehicles\vehicle_compass_cp::challengesenabledforplayer()) {
    return;
  }
  if(!isDefined(var_1)) {
    return;
  }
  if(!isDefined(level.disable_super_in_turret.name) || level.disable_super_in_turret.name != "_encstr_A11804CEC338") {
    return;
  }
  var_0 scripts\cp\vehicles\vehicle_compass_cp::_id_12C3F(var_1, 1);
}