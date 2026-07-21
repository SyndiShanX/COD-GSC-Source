/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\br_publicevent_tower.gsc
*************************************************/

init() {
  var_0 = spawnStruct();
  var_0.weight = getdvarfloat("_encstr_8AD117EE8E73EF013A3FB8185754F8E7AA727074E73A578804", 0);
  var_0._id_140CF = ::_id_140CF;
  var_0._id_14382 = ::_id_14382;
  var_0.attackerswaittime = ::attackerswaittime;
  var_0.isfeaturedisabled = ::isfeaturedisabled;
  var_0._encstr_8BC10D10BFF87BCF58583BE223A02F = ::_encstr_8BC10D10BFF87BCF58583BE223A02F;
  var_0._id_11B78 = getdvarint("_encstr_B1201ACAA6FDE9426BD1F3AFB9C33713BB4659C51F31219CD078BF8F", 1);
  var_0.guard_door_clip = _encstr_8BBE299653FB18D9237332385BADBF513FFD9D0BB84F835F8E0BB9D8231671E86F65248D0E53CB95372320::relic_squadlink_init_vfx("_encstr_877D06BB570F2B5E", "_encstr_962128F267C186A8CB121A222213E0CEBB7DFE0E07693E70617A122A4ADBD8165357668637B1F6381BE2");
  var_0._encstr_A3BC1423775D180D6A8B83BDCF8255C0EDCC49B8DBAB = _encstr_99B82F4BFFA864837D23A68A6BF8E7DEF86BC4B931C82AB62E7BB963D3A60394F0C35E2DB52872AF41B1033ADBA877CA58::_encstr_BD2A1BFF8980447BA7F5CB97235DA3BD581133C740D81F028BE7B32B07("_encstr_877D06BB570F2B5E");
  _encstr_8BBE299653FB18D9237332385BADBF513FFD9D0BB84F835F8E0BB9D8231671E86F65248D0E53CB95372320::_id_12B35(15, var_0);
}

_encstr_8BC10D10BFF87BCF58583BE223A02F() {
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8E4D18AECF1FCB41798270D09A4A23632B69A692678750AF1ADB"] = "_encstr_8E4D18AECF1FCB41798270D09A4A23632B69A692678750AF1ADB";
}

_id_140CF() {
  var_0 = (21204, -13899, 4657);
  var_1 = (18876, -16025, 4657);
  var_2 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::ispointincurrentsafecircle(var_0);
  var_3 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::ispointincurrentsafecircle(var_1);
  return var_2 && var_3;
}

_id_14382() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_8A431478F7784BCAC97FDB3836432F5B17EDD3F7F8EB");
}

attackerswaittime() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  _encstr_8BBE299653FB18D9237332385BADBF513FFD9D0BB84F835F8E0BB9D8231671E86F65248D0E53CB95372320::_id_13371("_encstr_83F01286269F234DC690879F601B3F5B91370ABB");
  _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::brleaderdialog("_encstr_8E4D18AECF1FCB41798270D09A4A23632B69A692678750AF1ADB", 1);
  level._effect["_encstr_BA722020BDFB7E3B82FB281885E1B46F589B07519BBB1D7DAB2B028379B7E43F280F"] = loadfx("_encstr_BEC6342377888A438BE2B7D5D3D69C30250F6BF8DEE1D284B20BBFD78F8A55A8CE695010C53499352B1321FF87E228B8A7BFD8A92A8D");
  _encstr_AC27347FFB0AD8B75BB398D86BDEE4406555C9E370B740503BBB6EC133AF28A031BB774B375B58444F9366686AA35338D6046DCFA346::init();
}

isfeaturedisabled() {}

_id_1344E() {
  var_0 = _encstr_8A362837E0B36903E1B6DD451F6F4A29F848A3671009CB3E25CED93D888733F3A0B02BCB2B035EE25F6E::_id_11A06(self.origin + (0, 0, 500));

  if(isDefined(var_0)) {
    var_1 = scripts\cp_mp\killstreaks\airdrop::dropcrate(undefined, undefined, "_encstr_8664130DAC859DE5EBBBAC581CEDB9EB6C9385E8AC", self.origin, (0, randomfloat(360), 0), var_0);
    var_1._id_13428 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0);
    var_1._id_13428 setModel("_encstr_A2E6149A4380B76CA8893A3FB999B6B3371BF24189EE");
    var_1._id_13428 setscriptablepartstate("_encstr_A9A80DCBFDC7F01D417713076BCAD1", "_encstr_AB0703DBB9", 0);
    var_1._id_135B6 = self._id_135B6;

    if(isDefined(var_1))
      var_1 thread _id_13451();

    var_2 = scripts\cp_mp\killstreaks\airdrop::gettriggerobject(var_1);
    var_2._id_140A0 = 10;
  }
}

_id_13451() {
  self setscriptablepartstate("_encstr_9A2B0A12F03587575B7BBEA5", "_encstr_8C2414DAF1EFBB38919F1DE169E805D78F6BF222D8B6");
}

connectedplayercount() {
  self.stadiumpuzzleactive = 1;
  self waittill("_encstr_B4D10ADC950BE4EB76DE8536");
  self.stadiumpuzzleactive = 0;
}

_id_12D23(var_0) {
  switch (var_0) {
    case "_encstr_A79D0A6A9793E1AB1847020B":
      var_1 = "_encstr_81411B9D2A81C8F8CFB1B3D85BB72EF162950F13B2B761B5D76B6963C2";
      var_2 = scripts\mp\rank::getscoreinfovalue(var_1);

      if(!isDefined(self)) {
        return;
      }
      thread scripts\mp\rank::giverankxp(var_1, var_2);
      thread scripts\mp\rank::scoreeventpopup(var_1);
      break;
    case "_encstr_95AF15D843BEB23B56738EAF0E16C9D1961B4B8385DC8E":
      var_1 = "_encstr_99552592FB187765C877A4B70FC06A7F36B15B2A036D0F9CB069A1903B30F9C7D028A302493DBF";
      var_2 = scripts\mp\rank::getscoreinfovalue(var_1);

      if(!isDefined(self)) {
        return;
      }
      thread scripts\mp\rank::giverankxp(var_1, var_2);
      thread scripts\mp\rank::scoreeventpopup(var_1);
      break;
  }
}