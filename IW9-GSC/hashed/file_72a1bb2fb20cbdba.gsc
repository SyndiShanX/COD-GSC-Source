/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_72a1bb2fb20cbdba.gsc
***********************************************/

_id_D5724A0F0CD63D12() {
  _id_A3DB364A0CCC4FD8();
  _id_23A85A6F3340BF6F::_id_A44B57CF475CF6C1(1);
  _id_3FB16506404E5493::_id_237759A1F240D382();
  level._id_80C1E8E18146024F = ::_id_BC9BC92F91FB076D;
}

_id_422C480D1E41BFF2() {
  level.forcedend = 1;
  thread scripts\mp\gamelogic::endgame(level.player.team, game["end_reason"]["objective_completed"], game["end_reason"]["br_eliminated"]);
}

_id_BC9BC92F91FB076D(_id_7B6D5DB8CB3C5782) {
  _id_2695A20D4011076D::_id_64AEDA8C8A4179C5(1);
  level.br_circle.safecircleent = spawn("script_model", (level.br_level.br_circlecenters[1][0], level.br_level.br_circlecenters[1][1], level.br_level.br_circleradii[1]));
  level.br_circle.safecircleent.hidden = 0;
  level.br_circle.safecircleui = spawn("script_model", level.br_circle.safecircleent.origin);
  level.br_circle.safecircleui.hidden = 0;
  level.br_circle.dangercircleent = spawnbrcircle(level.br_level.br_circlecenters[0][0], level.br_level.br_circlecenters[0][1], level.br_level.br_circleradii[0]);
  level.br_circle.dangercircleent.hidden = 0;
  level.br_circle.dangercircleent thread _id_2695A20D4011076D::dangercircleenthidefromplayers();
  level.br_circle.dangercircleui = spawn("script_model", level.br_circle.dangercircleent.origin);
  level.br_circle.dangercircleui.hidden = 0;
  _id_2695A20D4011076D::_id_2F4FB0777EBB4CC0();
  waitframe();
  _id_2695A20D4011076D::hidedangercircle();
  _id_2695A20D4011076D::setpreviewuicircle(level.br_circle.safecircleent);

  if(istrue(level.usegulag))
    _id_67708F418B1FAC79::setupgulagtimer();

  _id_2695A20D4011076D::showdangercircle();
  level.br_circle thread _id_2695A20D4011076D::circledamagetick();
  level thread _id_2695A20D4011076D::stopcirclesatgameend();
  level.br_circle._id_5B8569581E64D55A = gettime();

  if(isDefined(level.br_level.br_circledelaytimes)) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.br_level.br_circledelaytimes.size; _id_AC0E594AC96AA3A8++)
      _id_2695A20D4011076D::circletimer(_id_AC0E594AC96AA3A8);
  }

  _id_4384ABBF498DF6A7::disableallarmorykiosks();
}

_id_A3DB364A0CCC4FD8() {
  level.disableannouncer = 1;
  level.br_infils_disabled = 0;
  level.br_prematchspawnlocations = [_id_1E4A61DB11011446::createspawnlocation(scripts\engine\utility::drop_to_ground((20980, -7872, -365)), 0, 0)];
  setDvar("dvar_047D8674C992E098", 1);
  setDvar("dvar_192990FC79B06600", 1);
  setDvar("dvar_90A3DFD557408611", 0);
  setDvar("dvar_56D4C1121BFFCDF1", 0);
  setDvar("dvar_82BDE055B11E6698", 0);
  setDvar("dvar_18AFE7A288A4B1E4", 1);
  setDvar("dvar_EB038CA43332E718", 1);
  setDvar("dvar_F87A2E52E37010C1", 0);
  setDvar("dvar_54481201F477F78F", 0);
  _id_362C58E8BB39BCDA::disablefeature("gulag");
  _id_362C58E8BB39BCDA::disablefeature("teamSpectate");
  _id_362C58E8BB39BCDA::disablefeature("drogBagLoadout");
  _func_6F9B54CEA87F1C9E();
}