/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: opaque\58279.gsc
***********************************************/

activate_laser_trap_parent() {}

init() {
  thread_endon_death();
  var_0 = spawnStruct();
  var_0.weight = getdvarfloat("_encstr_A559206E1B397D83CAD731BDB9AE37EB83ED2DB91DBED8390B3AB2BEDDB2B4B3438E", 1.0);
  var_0.attackerswaittime = ::attackerswaittime;
  var_0._id_140CF = ::_id_140CF;
  var_0._id_14382 = ::_id_14382;
  var_0._id_11B78 = getdvarint("_encstr_8E9D23CDD89CF5832BD713ED9BEA37AFE0DE96CD1D7D1BC90B3AB27DB5163CF5D15AAD59B9", 1);
  var_0.guard_door_clip = _encstr_8BBE299653FB18D9237332385BADBF513FFD9D0BB84F835F8E0BB9D8231671E86F65248D0E53CB95372320::relic_squadlink_init_vfx("_encstr_B67B0A1A2C279107DBB49BA3", "_encstr_83C1202681010104A601104003040180600408101006808040C00180048101801006");
  _encstr_8BBE299653FB18D9237332385BADBF513FFD9D0BB84F835F8E0BB9D8231671E86F65248D0E53CB95372320::_id_12B35(102, var_0);
  subtract_from_spawn_count_from_group();
}

subtract_from_spawn_count_from_group() {
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_B2741B92608527DF769398E1C243E7E7138A08F96F8007A3F1A0B8B159"] = "_encstr_B2741B92608527DF769398E1C243E7E7138A08F96F8007A3F1A0B8B159";
}

thread_endon_death() {
  if(!isDefined(level.current_safehouse_spawn_structs))
    level.current_safehouse_spawn_structs = spawnStruct();

  level.current_safehouse_spawn_structs.spectatenumber = getdvarint("_encstr_99B52F4BFFA8E983F5A672AAA8D5B751107FD9AE39192EC3AFBB1A9150A03F1580DB462FD730F61BC030A21A7E854F4D68", 20);
  level.current_safehouse_spawn_structs.parachute_spawn = getdvarint("_encstr_B24629A3F9AEE7828817D2D71D600A9FD7109AFAA390DFFA7079CD9F3F7015AFFE6871E26BDE8F3318A7CE", 3.0);
  level.current_safehouse_spawn_structs.specialistbr = getdvarint("_encstr_845525AAE743A0206597BA5D8B0D2329CBC8E37AF927D71B79A32B41B1B3D597A6CF58E71DA921", 6);
  level.current_safehouse_spawn_structs.specialdayloadouts = getdvarint("_encstr_99A525CDB1E4AFE056D731ED37ABCD7D38BDA5DCD1FA1BC958E895BE239CF6E0DC7DCC4BE4DC47", 3);
  level.current_safehouse_spawn_structs.spectateprop = getdvarint("_encstr_96DE204632B3474B2A27B2302D7A4B0F5778E5DBE93BB0C95B07AFB6572BAC602A01", 10);
  level.current_safehouse_spawn_structs.parachutecancutautodeploy = getdvarfloat("_encstr_9161210BD64B513B5D37536D0570E340CE7FD32FA551C56E98B30EAB9D375D161F110B", 30.0);
  level.current_safehouse_spawn_structs.spectatableprops = getdvarint("_encstr_AC92248F42F2518340300B25A775C87FBF2FA1F99E17CF7399EDAA4BBA28DAA0C00512F29BD3", 0);
  level.current_safehouse_spawn_structs.spawnzombiedogtags = getdvarfloat("_encstr_AD27268BDAF657E24B6F02C0B087AF61838A1CB395A1A1D31613B2B727878BEB8B137960F4E0FBEB", 5.0);
}

_id_140CF() {
  return 0;
}

_id_14382() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_8A431478F7784BCAC97FDB3836432F5B17EDD3F7F8EB");
  var_0 = forest_combat();
  wait(var_0);
}

forest_combat() {
  var_0 = getdvarfloat("_encstr_997227BB361DFE5153D9F01F0310EB29B74282A88D70B393D3532BE1CE50E9E2C0EB93C03771A22122", 795);
  var_1 = getdvarfloat("_encstr_AD7227B6D62BB70B6587E0905BADA37FB37D23B06B91977349C3D01907C4B99D1B23AB498749435928", 1110);

  if(var_1 > var_0)
    return randomfloatrange(var_0, var_1);
  else
    return var_0;
}

attackerswaittime() {
  level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::brleaderdialog("_encstr_B2741B92608527DF769398E1C243E7E7138A08F96F8007A3F1A0B8B159", 0);
  _id_12293();
}

_id_12AEE(var_0) {
  if(!isDefined(self.arena_bot_pickup_weapon))
    self.arena_bot_pickup_weapon = [];

  self.arena_bot_pickup_weapon[self.arena_bot_pickup_weapon.size] = var_0;
}

_id_12293() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  _id_12291();
  level thread _id_12290(level.current_safehouse_spawn_structs.specialdayloadouts);

  if(getdvarint("_encstr_AB4121F3471051433538BA6201180F149009A76DF52BA583C893823A4B702B4C589B03", 0) == 0) {
    _utilflare_lerpflare::_id_12424("_encstr_9560299839EB4ED5D64CC62BAF38CAF5C4B7DC57DCD7C1DBB4E61DF5D827C2A32BCDBED273D8BDDA5A9BEC");
    wait(level.current_safehouse_spawn_structs.spectatenumber);
  }

  _utilflare_lerpflare::_id_12424("_encstr_A76D27139CF539BAB6266395F507957D26BDB957E6F5E0DBD2B947AF36E42C8EAC9BAF7BB9B15A3795");
  wait(level.current_safehouse_spawn_structs.parachute_spawn);
  level thread _id_12292();
}

_id_12291() {
  level.current_safehouse_spawn_structs._id_12E29 = spawnStruct();
  level.current_safehouse_spawn_structs._id_12E29.aq_ontimerupdate = [];
  level.current_safehouse_spawn_structs._id_12E29.are_all_alive_players_touching_plane = [];

  if(!isDefined(level.current_safehouse_spawn_structs._id_12E2C.arena_bot_pickup_weapon)) {
    var_0 = (0, 0, 0);

    if(isDefined(level.current_safehouse_spawn_structs._id_12E2C.ground_detection_think))
      var_0 = level.current_safehouse_spawn_structs._id_12E2C.ground_detection_think;

    level.current_safehouse_spawn_structs._id_12E2C.arena_bot_pickup_weapon = [var_0 + (0, 0, 0), var_0 + (1500, 1500, 0), var_0 + (1500, -1500, 0), var_0 + (-1500, 1500, 0), var_0 + (-1500, -1500, 0), var_0 + (3000, 3000, 0), var_0 + (3000, -3000, 0), var_0 + (-3000, 3000, 0), var_0 + (-3000, -3000, 0)];
  }

  level.current_safehouse_spawn_structs._id_12E2C.arena_bot_pickup_weapon = scripts\engine\utility::array_randomize(level.current_safehouse_spawn_structs._id_12E2C.arena_bot_pickup_weapon);
  var_1 = scripts\cp_mp\killstreaks\airdrop::getleveldata("_encstr_B6D216F3986F56770805CBEF9F70371D91F0A97AA8EB0B97");
  var_1.capturestring = &"_encstr_AF491E6A82CB8E51E4154A4A0DAF137A3DA8F568940A5151EBD0A0058AAA94A8";
  var_1.dummymodel = "_encstr_BD94250DB3633CBBDF3BEB71E1276BF7380BBB833B30474F5F7B81AAEB106BAF28FB3E14532088";
  var_1.friendlymodel = undefined;
  var_1.enemymodel = undefined;
  var_1.mountmantlemodel = undefined;
  var_1.supportsownercapture = 0;
  var_1.headicon = undefined;
  var_1.minimapicon = undefined;
  var_1.usepriority = -1;
  var_1.usefov = 180;
  var_1.timeout = undefined;
  var_1.friendlyuseonly = 0;
  var_1.ownerusetime = level.current_safehouse_spawn_structs.spawnzombiedogtags;
  var_1.otherusetime = level.current_safehouse_spawn_structs.spawnzombiedogtags;
  var_1.activatecallback = ::_id_1228A;
  var_1.capturecallback = ::_id_1228B;
  var_1.destroyoncapture = 1;
}

_id_12292() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = level.current_safehouse_spawn_structs.specialdayloadouts;
  var_1 = level.current_safehouse_spawn_structs.specialistbr - var_0;
  _id_12294(var_0);

  if(level.current_safehouse_spawn_structs.parachutecancutautodeploy > level.current_safehouse_spawn_structs.spectatenumber)
    wait(level.current_safehouse_spawn_structs.parachutecancutautodeploy - level.current_safehouse_spawn_structs.spectatenumber);

  level thread _id_12290(var_1, var_0);
  wait(level.current_safehouse_spawn_structs.spectatenumber);
  _utilflare_lerpflare::_id_12424("_encstr_A76D27139CF539BAB6266395F507957D26BDB957E6F5E0DBD2B947AF36E42C8EAC9BAF7BB9B15A3795");
  wait(level.current_safehouse_spawn_structs.parachute_spawn);
  _id_12294(var_1, var_0);
}

_id_12294(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(!isDefined(var_1))
    var_1 = 0;

  for(var_2 = 0; var_2 < var_0; var_2++) {
    var_3 = level.current_safehouse_spawn_structs._id_12E2C.arena_bot_pickup_weapon[var_2 + var_1];
    var_3 = var_3 + (0, 0, 2000);
    var_4 = scripts\cp_mp\killstreaks\airdrop::dropcrate(undefined, undefined, "_encstr_B6D216F3986F56770805CBEF9F70371D91F0A97AA8EB0B97", var_3, (0, randomint(360), 0));
    level.current_safehouse_spawn_structs._id_12E29.aq_ontimerupdate[level.current_safehouse_spawn_structs._id_12E29.aq_ontimerupdate.size] = var_4;
    var_4 thread _id_1228D();
    var_4 thread _id_1228E();
    wait 2.5;
  }
}

_id_1228D() {
  var_0 = scripts\engine\utility::drop_to_ground(self.origin, 50, -3000, (0, 0, 1));
  self.molotov_delete_oldest_trigger = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0 + (0, 0, 3));
  self.molotov_delete_oldest_trigger setModel("_encstr_AAD412E6C69CEBB9B6DBD659D7CE9C9537583256");
  wait 1.0;
  self.molotov_delete_oldest_trigger setscriptablepartstate("_encstr_BE7206A2D07B1322", "_encstr_AB0703DBB9");
  self.molotov_delete_oldest_trigger setscriptablepartstate("_encstr_AF8B1C39EA27E8C552034953DF8AB7B0A50206F3D549407DA9F763691F22", "_encstr_8B4A0A6EB6F66D56D73799E1");
}

_id_1228E() {
  var_0 = scripts\engine\utility::ter_op(level.current_safehouse_spawn_structs.spectateprop == 10, "_encstr_BE2610CA77D8F37F18B3325A18E527218A71", "_encstr_A72C0D31BDE6AEB9F50EB74B9BD1DC");

  if(isDefined(level.current_safehouse_spawn_structs.specialistperk))
    var_0 = level.current_safehouse_spawn_structs.specialistperk;

  self setscriptablepartstate("_encstr_9A2B0A12F03587575B7BBEA5", var_0);
}

_id_12290(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = 0;

  for(var_2 = 0; var_2 < var_0; var_2++) {
    if(!isDefined(level.current_safehouse_spawn_structs._id_12E2C.arena_bot_pickup_weapon[var_2 + var_1])) {
      return;
    }
    level thread _id_1228F(var_2 + var_1);
    wait 2.0;
  }
}

_id_1228F(var_0) {
  var_1 = level.current_safehouse_spawn_structs._id_12E2C.arena_bot_pickup_weapon[var_0];
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_140B1(var_1, "_encstr_8218041DF5FA");
}

_id_1228A(var_0) {
  if(istrue(var_0)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_BA67082278D537E3C827", "_encstr_816818A3BA775378C3BD354FB2EE082D8B723B0D92D79F685B80"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_BA67082278D537E3C827", "_encstr_816818A3BA775378C3BD354FB2EE082D8B723B0D92D79F685B80")]](self);
  }
}

_id_1228B(var_0) {
  level.current_safehouse_spawn_structs._id_12E29.aq_ontimerupdate = scripts\engine\utility::array_remove(level.current_safehouse_spawn_structs._id_12E29.aq_ontimerupdate, self);
  self setscriptablepartstate("_encstr_92C611A9AEB33B7D3293BD0EAFC456B036B737", "_encstr_BA19049F4B2D");
  self setscriptablepartstate("_encstr_B2D4137AB068B7BA919117E9553042D7076B927218", "_encstr_ACCB09CA870E63F5B9991E");
  level thread _id_1228C(var_0.team);
  self notify("_encstr_B1CF098D5838A3D5C95623");
  playFX(scripts\engine\utility::getfx("_encstr_BA722020BDFB7E3B82FB281885E1B46F589B07519BBB1D7DAB2B028379B7E43F280F"), self.origin);
  var_1 = randomintrange(3, 5);
  level thread _handlevehiclerepair::_id_13673("_encstr_B85113DA10C8D7DAF1F17749F590E237E62B62C339", self.origin, var_1, 0);
  level scripts\mp\gamescore::giveteamscoreforobjective(var_0.pers["_encstr_8AEF05472BC2D6"], level.current_safehouse_spawn_structs.spectateprop, 0);

  if(isDefined(self.objectiveiconid))
    objective_delete(self.objectiveiconid);

  playFX(level.conf_fx["_encstr_8BE007AB0FE8607F9B"], self.molotov_delete_oldest_trigger.origin);
  self.molotov_delete_oldest_trigger delete();
}

_id_1228C(var_0) {
  foreach(var_2 in level.players) {
    if(isDefined(var_2) && isDefined(var_2.team) && var_2.team == var_0)
      var_2 thread scripts\mp\hud_message::showsplash("_encstr_A7C02D7D1BA83347939A6868B9AF172E78821D133387C0C208926B1FB30D381BDFCFE7E78B25201B2360B76AA1A1B8");
  }
}