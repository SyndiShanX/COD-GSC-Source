/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\agents\soldier_agent_spec.gsc
***********************************************/

soldier_agent_specialize_init() {
  level.soldier_specialization = 1;
  level.soldier_agent_specialize_func["_encstr_8EF60E63FBE3D70440A312175B98CF6B"] = ::blank;
  level.soldier_agent_specialize_func["_encstr_8BFC0BC2CBD4F737E0A5E1FD79"] = ::setup_jugg;
  level.soldier_agent_specialize_func["_encstr_842408C29CB6DB392B32"] = ::setup_armored;
  level.soldier_agent_specialize_func["_encstr_8C710F56607DE7252963A0BB2BC85F5AB8"] = ::setup_armored_helmet;
  level.soldier_agent_specialize_func["_encstr_8BBA05185F8B99"] = ::blank;
  level.soldier_agent_specialize_func["_encstr_958C08CDDBD8325A959C"] = ::blank;
  level.soldier_agent_specialize_func["_encstr_850707F7E5833355B8"] = ::blank;
  level.soldier_agent_specialize_func["_encstr_A65B084B38A76BEFC350"] = ::blank;
  level.soldier_agent_specialize_func["_encstr_AD07034A38"] = ::blank;
  level.soldier_agent_specialize_func["_encstr_9A190463ADB3"] = ::blank;
  level.soldier_agent_specialize_func["_encstr_BE1904DCDA9D"] = ::blank;
  level.soldier_agent_specialize_func["_encstr_A11904E483B3"] = ::blank;
  loadvfx();
}

loadvfx() {}

blank() {}

setup_jugg() {
  var_0 = "_encstr_95361801488D295FE801BB887261B81EF0CBF797711BF20B0BA1";
  var_1 = undefined;
  setcharmodels(var_0, var_1);
  self.maxhealth = 2500;
  self.health = 2500;
  self.spec = "_encstr_8BFC0BC2CBD4F737E0A5E1FD79";
  self.wearing_helmet = 1;
  self.allowpain = 0;
  self.walkdist = 3000;
  self.cautiousnavigation = 1;
  self.runcooldown = 30000;
  self.goalradius = 256;
}

give_shoulder_launchers() {
  var_0 = self gettagorigin("_encstr_ABE81598984749D26362E8E54EA1078BCF9B928506EE83");
  var_1 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0);
  var_2 = self gettagorigin("_encstr_93E815744F11876A3BD8228AC821657B4E27FA15C8D8D7");
  var_3 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_2);
  thread delete_launchers_on_death(var_1, var_3);
}

delete_launchers_on_death(var_0, var_1) {
  var_0 setModel("_encstr_B16D1926F3D819425BB3F7E3B9E84B5DD9BB9E214898ABFA8EE1A6");
  var_1 setModel("_encstr_B16D1926F3D819425BB3F7E3B9E84B5DD9BB9E214898ABFA8EE1A6");
  var_0 linkTo(self, "_encstr_ABE81598984749D26362E8E54EA1078BCF9B928506EE83", (0, 0, 0), (270, 0, 0));
  var_1 linkTo(self, "_encstr_93E815744F11876A3BD8228AC821657B4E27FA15C8D8D7", (0, 0, 0), (270, 0, 0));
  self waittill("_encstr_AD75063D571AE108");
  var_0 delete();
  var_1 delete();
}

setup_armored() {
  var_0 = "_encstr_8AB51636B83C016FB30E91F5902C9A0BD96B59DE9BBF66C8";
  var_1 = "_encstr_A5BD14D40D6FE44102C4F7DB13594FCD818F5A7162DB";
  setcharmodels(var_0, var_1);
  self.spec = "_encstr_842408C29CB6DB392B32";
}

setup_armored_helmet() {
  var_0 = "_encstr_8AB51636B83C016FB30E91F5902C9A0BD96B59DE9BBF66C8";
  var_1 = "_encstr_A5B0234CF95834B9F1A147A7EBA6536D682009579038FDC3DD9BF757DB47EBB459A9FA9103";
  setcharmodels(var_0, var_1);
  self.spec = "_encstr_8C710F56607DE7252963A0BB2BC85F5AB8";
  self.wearing_helmet = 1;
}

setcharmodels(var_0, var_1, var_2) {
  if(isDefined(self.headmodel))
    self detach(self.headmodel);

  self setModel(var_0);

  if(isDefined(var_1)) {
    self attach(var_1, "_encstr_B40101", 1);
    self.headmodel = var_1;
  }
}