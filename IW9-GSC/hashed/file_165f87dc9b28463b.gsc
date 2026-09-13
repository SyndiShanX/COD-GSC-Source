/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_165f87dc9b28463b.gsc
***********************************************/

_id_1F763DFECFC35564() {
  _id_BF63FAD4C7DC4E9F();
  level.post_customization_func = ::_id_C682E1F5EB7F451E;
}

_id_BF63FAD4C7DC4E9F() {
  level._id_21F3C3F7EADF3C57 = [];
  level._id_21F3C3F7EADF3C57[level._id_21F3C3F7EADF3C57.size] = 30;
  level._id_21F3C3F7EADF3C57[level._id_21F3C3F7EADF3C57.size] = 20;
  level._id_21F3C3F7EADF3C57[level._id_21F3C3F7EADF3C57.size] = 10;
}

_id_C682E1F5EB7F451E() {
  if(isDefined(self.operatorcustomization) && isDefined(self.operatorcustomization.execution)) {
    scripts\cp_mp\execution::_giveexecution(self.operatorcustomization.execution);
    _id_4FBDB8A4C881D739 = scripts\engine\utility::random(level._id_21F3C3F7EADF3C57);
    level._id_21F3C3F7EADF3C57 = scripts\engine\utility::array_remove(level._id_21F3C3F7EADF3C57, _id_4FBDB8A4C881D739);
    _id_51CEF08D1C77DA29(self, _id_4FBDB8A4C881D739);
  }
}

_id_51CEF08D1C77DA29(player, _id_887D4CB1410C4FFC) {
  player.operatorcustomization.skinref = _id_887D4CB1410C4FFC;
  body = tablelookup("operatorskins.csv", 0, _id_887D4CB1410C4FFC, 4);
  head = tablelookup("operatorskins.csv", 0, _id_887D4CB1410C4FFC, 5);
  operator = tablelookup("operatorskins.csv", 0, _id_887D4CB1410C4FFC, 2);
  suit = tablelookup("operators.csv", 1, operator, 19);
  player.operatorcustomization.suit = suit;

  if(body == "" || head == "") {
    return;
  }
  _id_41BD2EEDA1C033D2 = _id_12E2FB553EC1605E::getplayerviewmodelfrombody(body);
  player setcustomization(body, head);
  bodymodelname = player getcustomizationbody();
  headmodelname = player getcustomizationhead();
  _id_41BD2EEDA1C033D2 = player getcustomizationviewmodel();

  if(player.operatorcustomization.suit == "iw9_defaultsuit_mp")
    player.operatorcustomization.suit = "iw9_suit_cp";

  player scripts\cp\utility\player::_setsuit(player.operatorcustomization.suit);
  player _id_D114326CAC6BADA8(bodymodelname, headmodelname, _id_41BD2EEDA1C033D2);
  _id_E89FD4C2E2E797B9 = player _id_12E2FB553EC1605E::getplayerfoleytype(_id_887D4CB1410C4FFC);

  if(_id_E89FD4C2E2E797B9 == "")
    _id_E89FD4C2E2E797B9 = "vestlight";

  player setclothtype(_id_E89FD4C2E2E797B9);

  if(player.operatorcustomization.gender == "female")
    player _meth_555E2D32E2756625("female");

  player.operatorcustomization.voice = _id_12E2FB553EC1605E::getoperatorvoice(operator);
  player.operatorcustomization.clothtype = _id_12E2FB553EC1605E::getoperatorclothtype(_id_887D4CB1410C4FFC);
  player.operatorcustomization.superfaction = _id_12E2FB553EC1605E::getoperatorsuperfaction(operator);
  player.operatorcustomization.execution = _id_12E2FB553EC1605E::getoperatorexecution(operator);
  player.operatorcustomization.executionquip = _id_12E2FB553EC1605E::getoperatorexecutionquip(operator);
}

_id_D114326CAC6BADA8(bodymodelname, headmodelname, _id_41BD2EEDA1C033D2) {
  if(isDefined(self.headmodel))
    self detach(self.headmodel);

  if(!isagent(self)) {
    bodymodelname = self getcustomizationbody();
    headmodelname = self getcustomizationhead();
    _id_41BD2EEDA1C033D2 = self getcustomizationviewmodel();
  }

  self setModel(bodymodelname);
  self setviewmodel(_id_41BD2EEDA1C033D2);

  if(isDefined(headmodelname)) {
    self attach(headmodelname, "", 1);
    self.headmodel = headmodelname;
  }
}