/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\br_loot_cache_trapped.gsc
**************************************************/

init() {
  scripts\engine\scriptable::_id_12F5B("_encstr_82CD0D50D3AE19F3976CBE2345E7BB", ::_id_13D04);
}

_id_136A2(var_0, var_1) {
  var_2 = easepower("_encstr_A607164A23C0C3AD7B69D7F35BB8B42F685BC3E20B2FBF27", var_0, var_1);
  var_2._id_13A98 = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", var_0, 0, 90, 64);
  var_2._id_13A98._id_121D6 = var_2;
  scripts\mp\utility\trigger::makeenterexittrigger(var_2._id_13A98, ::_id_13A97, undefined);
  return var_2;
}

_id_13A97(var_0, var_1) {
  wait 0.3;
  var_2 = var_1._id_121D6 getscriptablepartstate("_encstr_82CD0D50D3AE19F3976CBE2345E7BB");

  if(var_2 != "_encstr_A350079E35DACF8944") {
    var_1 delete();
    return;
  }

  var_3 = ["_encstr_91911A3A72D00B1AE02FEBD46F49A30367EB0112791D9FD348C7A198", "_encstr_AC911AD3F3B9B8C36B3057E3A3E0606AF77066B99E5343F33A706F1F"];
  playsoundatpos(var_1.origin + (0, 0, 50), scripts\engine\utility::random(var_3));
  var_1 delete();
}

_id_13D04(var_0, var_1, var_2, var_3, var_4) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_AD75063D571AE108");
  var_5 = ["_encstr_81261794E121065B1DA92BDB46C75DB003EA7259142F21699A", "_encstr_AB841B19F0EB4C27ADF5CD3AD8D7C1D8C2CB2BC9F5322B85A386AF8918", "_encstr_91841B230FAF3139DA7DE63A8DEBE0B1B0E5B2E4FA192BB0D1A1AF9160", "_encstr_842617C81EAF98396BAFCDA31BAF8ED2B6564EBEECEDF5910C", "_encstr_82911ABFAA59C2BB212F4753BFC0232A4033F946615881B30D175ABA"];
  playsoundatpos(var_0.origin + (0, 0, 50), scripts\engine\utility::random(var_5));
  var_0 setscriptablepartstate(var_1, "_encstr_93CF08C7684F60BBB372");
  var_6 = level.hud_set_progress[var_0.hud_racetrack_timer];
  var_7 = "_encstr_87EC152FD868DC8B6F812A1D7803B088F368A7BB10033F" + var_6.id;
  scripts\engine\utility::exploder(var_7);
  var_8 = gettime();
  var_9 = getdvarfloat("_encstr_811922032EE6BF3D53D89BEBD18B52739D5048137F4B8067FFE7335190F2C03F342BBBA1", 30) * 1000;
  var_10 = getdvarfloat("_encstr_BDEB26D2BEF5E17A53D9FBFB304B200AA1D69CCF1E513987D99033BF3841EFF253E8E347068D92C4", 1);

  while(gettime() - var_8 < var_9) {
    foreach(var_3 in var_6._id_12699)
    var_0 scripts\mp\equipment\binoculars::lootleadermarkstrongsize(var_3, var_3, 9);

    wait(var_10);
  }

  scripts\engine\utility::stop_exploder(var_7);
  var_6 notify("_encstr_B86708270BC7CFAA9EA1");
  var_0 setscriptablepartstate(var_1, "_encstr_AF9A099E17EA0831658B71");
}