/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: anim\notetracks_mp.gsc
***********************************************/

registernotetracksifnot() {
  if(isDefined(anim.notetracks)) {
    return;
  }
  anim.notetracks = [];
  registernotetracks();
}

registernotetracks() {
  level._defaultnotetrackhandler = ::handlenotetrack;
  level.fnnotetrackprefixhandler = ::notetrack_prefix_handler_mp;
  _encstr_953E1CDC6CC94B07E89BCB169BD2B65EDC7B3A953A4E168DB56E17CE378D::registernotetracks();
  anim.notetracks["_encstr_B1151599DEBD47CD8E5683D7394B3B1A3AFA63C2E4D956"] = ::notetrackfootstep;
  anim.notetracks["_encstr_96E015CCF262117B3BCFB2B1630A8F63FB57EE2A663440"] = ::notetrackfootstep;
  anim.notetracks["_encstr_8F1D14CE1048734271B88B7118BBFF8BA6095152BC51"] = ::notetrackfootstep;
  anim.notetracks["_encstr_855814135730C3F3D8D972B1D0782E7B80C7A78729E9"] = ::notetrackfootstep;
  anim.notetracks["_encstr_A6411211A52928E84BEFBFABEAA76F10ECFE7849"] = ::notetrackposestand;
  anim.notetracks["_encstr_87AA1369D540556F2FF0137A31A1CA8EF0AFF5F371"] = ::notetrackposecrouch;
  anim.notetracks["_encstr_A54912DF1ED7D8C7627210B89EE9F1B303B7D045"] = ::notetrackposeprone;
  anim.notetracks["_encstr_975F093ACB5540615318CB"] = ::notetrackgundrop;
  anim.notetracks["_encstr_96C60893FDB828DF53E5"] = ::notetrackgundrop;
}

notetrackfootstep(var_0, var_1) {
  var_2 = issubstr(var_0, "_encstr_A5AD056A019C63");
  var_3 = issubstr(var_0, "_encstr_8DEC06B1E943615B");
  var_4 = "_encstr_8253060E2B5FE330";

  if(var_2)
    var_4 = "_encstr_A5AD056A019C63";

  if(var_3)
    self notify("_encstr_9AA60FC6859CEC56EB997BBD8E37E859C1");

  self.asm.footsteps.foot = var_4;
  self.asm.footsteps.time = gettime();
}

handlenotetrack(var_0, var_1, var_2, var_3) {
  if(_encstr_953E1CDC6CC94B07E89BCB169BD2B65EDC7B3A953A4E168DB56E17CE378D::hascustomnotetrackhandler(var_0))
    return _encstr_953E1CDC6CC94B07E89BCB169BD2B65EDC7B3A953A4E168DB56E17CE378D::handlecustomnotetrackhandler(var_0, var_1, var_2, var_3);

  var_4 = _encstr_953E1CDC6CC94B07E89BCB169BD2B65EDC7B3A953A4E168DB56E17CE378D::handlecommonnotetrack(var_0, var_1, var_2, var_3);

  if(isDefined(var_4) && var_4 == "_encstr_88840CFAF55DDC0D2CB98CC65623") {
    var_4 = undefined;

    switch (var_0) {
      case "_encstr_8E0311B3E57371FFC3EFC82120D939900D90C3":
        if(weaponclass(self.weapon) == "_encstr_BA080F126090E3D245A1F7BFBDE6CA25A0")
          notetrackrocketlauncherammoattach();

        break;
      default:
        if(isDefined(var_2)) {
          if(isDefined(var_3))
            return [[var_2]](var_0, var_3);
          else
            return [[var_2]](var_0);
        }

        break;
    }
  }

  return var_4;
}

notetrack_prefix_handler_mp(var_0) {
  return _encstr_953E1CDC6CC94B07E89BCB169BD2B65EDC7B3A953A4E168DB56E17CE378D::notetrack_prefix_handler_common(var_0);
}

notetrackrocketlauncherammoattach() {
  if(!isalive(self)) {
    return;
  }
  if(!_encstr_96322092C72534F043F78E4F98BFBD5F5398875269C3CB893292B5F278682D370F83::usingrocketlauncher()) {
    return;
  }
  if(self tagexists("_encstr_8FD20B6BE0AA87786007DBC1A8"))
    self showpart("_encstr_8FD20B6BE0AA87786007DBC1A8");
}

notetrackgundrop(var_0, var_1) {
  if(isDefined(self.playercleanupentondisconnect))
    self[[self.playercleanupentondisconnect]]();
}

setpose(var_0) {
  self.currentpose = var_0;
  scripts\asm\asm_bb::bb_requeststance(var_0);
  self notify("_encstr_8E4E0DA588332F2A7B88519BE86F27" + var_0);
}

notetrackposestand(var_0, var_1) {
  setpose("_encstr_A5AD069B231F0BAF");
}

notetrackposecrouch(var_0, var_1) {
  setpose("_encstr_B13D076BED70539F23");
}

notetrackposeprone(var_0, var_1) {
  setpose("_encstr_922406F1A6FD5E05");
}