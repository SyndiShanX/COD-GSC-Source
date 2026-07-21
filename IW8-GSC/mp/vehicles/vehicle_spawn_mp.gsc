/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\vehicles\vehicle_spawn_mp.gsc
***********************************************/

vehicle_spawn_mp_init() {
  var_0 = getdvarint("_encstr_A301114F278BAFD8D9A02E038F88A046C287C7", 128);
  var_1 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldata();
  var_1.maxinstancecount = var_0;
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8ECE0E33605963F754AB679E9A3B8B6D", "_encstr_960110D858376A07B077CD952B0D2DB1C6B2", ::vehicle_spawn_mp_canspawnvehicle);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8ECE0E33605963F754AB679E9A3B8B6D", "_encstr_8E1318E912B74D912D942347ADD240B763DBE3373A977F38C366", ::vehicle_spawn_mp_gamemodesupportsrespawn);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8ECE0E33605963F754AB679E9A3B8B6D", "_encstr_97842141BA1F15C945FC5B2FF56AE8E89B035B0D3287D8F81DDE53493C1458A5478B33", ::_id_14217);
  vehicle_spawn_mp_codetesthackinit();
}

vehicle_spawn_mp_canspawnVehicle(var_0, var_1, var_2) {
  if(getdvarint("_encstr_87EF136FB8EBF7BA6981651B6035B298D010ABBFA0", 1) == 0)
    return 0;

  if(getdvarint("_encstr_BDEF13D2BEF5E179904097EFC18B35DABBC69DCF08" + var_0, 1) == 0)
    return 0;

  return 1;
}

vehicle_spawn_mp_gamemodesupportsrespawn() {
  if(getdvarint("_encstr_8F6426208A227F89038FE4689A7F51B78B727008627DB3666FCDF7DF6FD3BBB7B9AB8050EB56DF98", 0))
    return 1;

  if(scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB") {
    if(getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") == "_encstr_BE180419DAE9" || getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") == "_encstr_8AE1099A0B999F2D28AF15" || getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") == "_encstr_9B1F05BE4B9B52" || getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") == "_encstr_866209ECEDB1197DEE0B4E") {
      if(getdvarint("_encstr_95E41E6ED8E47D266BDBEB3B56344BB18DAC2995DCC1B0EEDC2AE60B31632BC8", 1) > 0)
        return 1;
    }

    return 0;
  }

  return 1;
}

_id_14217() {
  if(scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB")
    return 0;

  return 1;
}

vehicle_spawn_mp_codetesthackinit() {
  if(scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_iscodevehicletest())
    scripts\mp\utility\spawn_event_aggregator::registeronplayerspawncallback(::vehicle_spawn_mp_codetesthackspawncallback);
}

vehicle_spawn_mp_codetesthackspawncallback() {
  var_0 = scripts\cp_mp\utility\game_utility::getmapname();

  if(var_0 == "_encstr_BD920F0D81997FD7D4B83B7263A0DF77BB") {
    self setOrigin((22314, -13059, -128), 1, 1);
    self setplayerangles((0, 36, 0));
  } else if(var_0 == "_encstr_93D20D28714743B99070632BAF3944") {
    self setOrigin((45073, -11307, 18), 1, 1);
    self setplayerangles((0, 315, 0));
  } else if(var_0 == "_encstr_8B240B70C2BF685DFA3B1DF3C2") {
    self setOrigin((29048, 35035, 560), 1, 1);
    self setplayerangles((0, 0, 0));
  }

  thread vehicle_spawn_mp_codetesthackwatchrespawn();
}

vehicle_spawn_mp_codetesthackwatchrespawn() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self notify("_encstr_A5DB2B67591A96D863B27D9BC158EECDAF6B387DC6F69156A82B6EA324C2C6DA6A0716BBCDD02CD88D89856CB6");
  self endon("_encstr_A5DB2B67591A96D863B27D9BC158EECDAF6B387DC6F69156A82B6EA324C2C6DA6A0716BBCDD02CD88D89856CB6");
  self notifyonplayercommand("_encstr_AFA41A09500311395B374A97DEE443B9938BCF8366133D529BC9C3FE", "_encstr_AF5C0E59B08DA32D7B7337D8ED3A1098");
  self notifyonplayercommand("_encstr_AFA41A09500311395B374A97DEE443B9938BCF8366133D529BC9C3FE", "_encstr_9A5C0E7471AFC0EA624018717863626F");

  for(;;) {
    self waittill("_encstr_AFA41A09500311395B374A97DEE443B9938BCF8366133D529BC9C3FE");

    if(!scripts\cp_mp\utility\player_utility::_isalive()) {
      continue;
    }
    var_0 = scripts\cp_mp\utility\player_utility::getvehicle();

    if(isDefined(var_0)) {
      var_1 = scripts\cp_mp\vehicles\vehicle::vehicle_getleveldataforvehicle(var_0.vehiclename);

      if(isDefined(var_1.destroycallback)) {
        var_0 thread[[var_1.destroycallback]]();
        return;
      } else
        continue;
    }

    thread vehicle_spawn_mp_codetesthackspawncallback();
    break;
  }
}