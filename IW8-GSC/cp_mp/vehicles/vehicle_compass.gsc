/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp_mp\vehicles\vehicle_compass.gsc
***********************************************/

calloutmarkerping_init() {
  scripts\cp\vehicles\little_bird_mg_cp::fulton_actors_players();
  scripts\mp\utility\disconnect_event_aggregator::registerondisconnecteventcallback(scripts\cp\vehicles\little_bird_mg_cp::calloutmarkerping_onplayerdisconnect);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_870D05C1969BB3", "_encstr_8BDA3096612824B285D107AFC5A25A7271C84D1F5E38E12BD7990BB7CBDD82CA89D106E6F0888B323883F38B77FECA11E0B9", ::fulton_initrepository);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_870D05C1969BB3", "_encstr_876231B12CC663DEBAA36A85C9DA95E414B4B9ECF56EB8D5C29198B22C46AC4E90B22CC6DECDA5A5B1638C7B390A8D58CBACE4", ::fulton_init);
  level._effect["_encstr_88071554F7EBD72912274060C75BC0FDE1DE43DE0E027B"] = loadfx("_encstr_AA192F67660F79EBE456175D599BE89BE5319CBE3B16DACA38B12CF27967990FAF9893D726CAC2D8F6CDD76CA5278D8DCA");
}

fulton_initrepository(var_0, var_1, var_2) {
  if(!getdvarint("_encstr_B465281B30CDF1AF31217C67457B5F863598E2831053F5C7AE966975574103CFBB786A3BE813EE1F8070", 0)) {
    return;
  }
  if(var_0 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::updatedragonsbreath() && istrue(var_0.delay_give_tactical_grenade) && var_1 == scripts\cp\vehicles\little_bird_mg_cp::calloutmarkerping_getpoolidnavigation() || getdvarint("_encstr_A1273460CA62BF698F7C21A85DE3908BCAD2581093FC65219F8BB79D21CBF85BF68AC0980A17B3F9078EA81C374BC1135E02C0D8A3AF", 0))
    fulton_hostageent(var_2);
}

fulton_hostageent(var_0) {
  var_1 = self;
  var_2 = scripts\engine\utility::getfx("_encstr_88071554F7EBD72912274060C75BC0FDE1DE43DE0E027B");
  var_3 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B472054FE12550", "_encstr_85881311AA2BD460B48D3D11BC9839992703293B53")]](var_1.team, 1);

  foreach(var_5 in var_3) {
    if(isDefined(var_5._id_1373E))
      var_5._id_1373E delete();

    var_5._id_1373E = spawnfxforclient(var_2, var_0, var_5);
    triggerfx(var_5._id_1373E);
    var_5._id_1373E setfxkilldefondelete();
    var_5._id_1373C = var_0;
    var_5._id_1373D = 892.5;
    var_5._id_1373F = 1;
  }
}

fulton_initanims() {
  var_0 = self;

  if(!getdvarint("_encstr_B465281B30CDF1AF31217C67457B5F863598E2831053F5C7AE966975574103CFBB786A3BE813EE1F8070", 0)) {
    return;
  }
  if(!istrue(var_0._id_1373F)) {
    return;
  }
  if(scripts\engine\utility::updatescrapassistdata(var_0.origin, var_0._id_1373C, var_0._id_1373D)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_A51F05CB11A052", "_encstr_A71810F05AB595D96FF635B8ECE340599BD3"))
      var_0 thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_A51F05CB11A052", "_encstr_A71810F05AB595D96FF635B8ECE340599BD3")]]("_encstr_9563109839EB4C95166CF673AF31DEE6EAB9");
  }

  var_0._id_1373E delete();
  var_0._id_1373C = undefined;
  var_0._id_1373D = undefined;
  var_0._id_1373F = undefined;
}

fulton_init(var_0) {
  if(!getdvarint("_encstr_B465281B30CDF1AF31217C67457B5F863598E2831053F5C7AE966975574103CFBB786A3BE813EE1F8070", 0)) {
    return;
  }
  if(isDefined(var_0._id_1373E)) {
    var_0._id_1373E delete();
    var_0._id_1373C = undefined;
    var_0._id_1373D = undefined;
    var_0._id_1373F = undefined;
  }
}